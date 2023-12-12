require("oil").setup({
  columns = {
    "icon",
    "permissons",
    "size",
  }
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
