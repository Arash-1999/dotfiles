return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = {
    {
      'nvim-tree/nvim-web-devicons',
      opts = {},
    }
  },
  lazy = false,
  config = function()
    require('oil').setup({
      columns = {
        'icon',
        -- 'permissions',
        'size',
      }
    })

    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end
}
