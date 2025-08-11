return {
	"neovim/nvim-lspconfig",
	dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    {
      'saghen/blink.cmp',
      dependencies = { 'rafamadriz/friendly-snippets' },
      version = '1.*',
      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        keymap = {
          preset = 'default',
          ['<CR>'] = {
            'accept',
            'fallback',
          }
        },
        -- keymap = { preset = 'default' },
        appearance = {
          -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
          -- Adjusts spacing to ensure icons are aligned
          nerd_font_variant = 'mono'
        },
        completion = {
          documentation = {
            auto_show = false
          },
          menu = {
            -- only show menu on manual <C-space>
            auto_show = false,
          },
          ghost_text = {
            enabled = true,
            -- only show when menu is closed
            show_with_menu = false,
          },
        },
        -- sources = {
        --   default = { 'lsp', 'path', 'snippets', 'buffer' },
        -- },
        fuzzy = { implementation = "prefer_rust_with_warning" }
      },
      opts_extend = { "sources.default" }
    },
    "stevearc/conform.nvim"
	},
	opts = {
		servers = {
      'eslint',
			'bashls',
			'ts_ls',
      'tailwindcss',
      jsonls = require('config.lsp.jsonls'),
      lua_ls = require('config.lsp.luals'),
      cssls = require('config.lsp.cssls')
		},
		mason = {
			ui = {
				icons = {
					package_isntalled = '-',
					package_pending = '*',
					pacakge_uninstalled = 'x',
				}
			},
		},
	},
	config = function(_, opts)
		local mason_lspconfig = require('mason-lspconfig')
		local mason = require('mason')

		mason.setup(opts.mason)

		local ensure_installed = {}

		for key, value in pairs(opts.servers) do
      if type(key) == 'string' then
        table.insert(ensure_installed , key)
      elseif type(value) == 'string' then
        table.insert(ensure_installed , value)
      end
		end

		mason_lspconfig.setup({
			ensure_installed = ensure_installed,
		})

    local lspconfig = require('lspconfig')
    local blink_cmp = require('blink.cmp')

    for key, value in pairs(opts.servers) do
      local server = nil
      local config = nil
      if type(key) == 'string' then
        server = key
        config = value
      elseif type(value) == 'string' then
        server = value
        config = {}
      end

      config.capabilities = blink_cmp.get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end

    require('config.formatter').setup()

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function ()
        -- local bufnr = args.buf

        local builtin = require('telescope.builtin')

        vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'

        vim.keymap.set('n', 'gd', builtin.lsp_definitions, { buffer = 0 });
        vim.keymap.set('n', 'gr', builtin.lsp_references, { buffer = 0 });
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = 0 });
        vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, { buffer = 0 });
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 });

        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = 0 });
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = 0 });

        vim.keymap.set('n', '<leader>fc', function ()
          vim.lsp.buf.format({ async = true })
        end, { buffer = 0 });

        vim.keymap.set('n', '[g', function ()
          vim.diagnostic.jump({ count = -1, float = true, })
        end, { buffer = 0 });
        vim.keymap.set('n', ']g', function ()
          vim.diagnostic.jump({ count = 1, float = true, })
        end, { buffer = 0 });
      end
    })
	end
}
