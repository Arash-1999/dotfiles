require('mason').setup({
  ui = {
    icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
    },
    border = "rounded",
  },
})
require('mason-lspconfig').setup({
  ensure_installed = {
     "bashls",
     "cssls",
     "eslint",
     "graphql",
     "html",
     "jsonls",
     "lua_ls",
     "tailwindcss",
     "pyright",
     "tsserver",
  },

  automatic_installation = true,
})

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  print("Failed to load luasnip")
  return
end

local cmp = require'cmp'

cmp.setup({
  snippet = {
  --   -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    silent = true,
    border = 'rounded',
  }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
  ["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { virtual_text = true }
  ),
}

local function on_attach(client, bufnr)
  -- set up buffer keymaps, etc.
end


lspconfig.tailwindcss.setup({
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
})
lspconfig.cssls.setup({
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  settings = require('lsp.settings.cssls').settings,
})
lspconfig.eslint.setup({
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
})
lspconfig.jsonls.setup({
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  settings = require('lsp.settings.jsonls').settings,
})
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
})
lspconfig.tsserver.setup({
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
})
lspconfig.html.setup({
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
})
lspconfig.bashls.setup({
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
})
lspconfig.graphql.setup({
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
})
lspconfig.pyright.setup({
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
})
