return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function ()
    local configs = require('nvim-treesitter.configs')

    configs.setup({
      ensure_installed = {
        'c',
        'lua',
        'vim',
        'vimdoc',
        'tsx',
        'typescript',
        'javascript',
        'bash',
        'html',
        'css',
        'regex',
        'json',
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        use_languagetree = true,
        disable = function (_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,

        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
        disable = { 'python' }
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'gnn',
          node_incremental = 'grn',
          scope_incremental = 'grc',
          node_decremental = 'grm',
        }
      }
    })

    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }

    -- folding
    -- vim.wo.foldmethod = 'expr'
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end
}
