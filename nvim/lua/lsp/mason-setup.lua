require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
		border = "rounded",
	},
})
require("mason-lspconfig").setup({
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
		"emmet_ls",
		"rust_analyzer",
		"gopls",
	},

	automatic_installation = true,
})
