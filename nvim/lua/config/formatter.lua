local M = {}

M.setup = function()
  local conform = require('conform')

  local js_formatter = 'prettier'

  conform.setup({
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { js_formatter },
      typescript = { js_formatter },
      javascriptreact = { js_formatter },
      typescriptreact = { js_formatter },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      svg = { "xmlformat" },
      -- go = { "gofmt" },
    },

    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    },
  })

  conform.formatters.xmlformat = {
    prepend_args = { '--selfclose' },
  }

  vim.keymap.set("n", "<leader>fp", function()
    conform.format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    })
  end)
end

return M
