return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 10000,
	config = function()
		require("kanagawa").setup({
			transparent = true,
		})
		vim.cmd([[colorscheme kanagawa-dragon]])
	end
}
