vim.cmd [[colorscheme kanagawa-dragon]]
vim.cmd.set('termguicolors')

-- large cursor
vim.opt.guicursor = ""

-- show line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- indenting options
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
