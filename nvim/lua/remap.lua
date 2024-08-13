-- move lines
vim.keymap.set("n", "<C-k>", ":move-2<cr>")
vim.keymap.set("n", "<C-j>", ":move+<cr>")
vim.keymap.set("x", "<C-k>", ":move-2<cr>gv")
vim.keymap.set("x", "<C-j>", ":move'>+<cr>gv")

-- keep cursor position on joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- put cursor in mid on next/prev serach result
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- plus register is your system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "<leader>nt", ":tabnew<cr>")
vim.keymap.set("n", "<leader>vh", ":split<cr>")
vim.keymap.set("n", "<leader>vv", ":vsplit<cr>")
