local highlight = {
  'IndentColor1',
}

local hooks = require('ibl.hooks')

hooks.register(hooks.type.HIGHLIGHT_SETUP, function ()
  vim.api.nvim_set_hl(0, 'IndentColor1', { fg = '#282828' })
end)

require("ibl").setup({
  indent = {
    char = {'|', '¦', '┆', '┊'},
    highlight = highlight,
  },
  scope = {
    enabled = true,
    show_start = false,
    show_end = false,
  },
})
