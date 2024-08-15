-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		silent = true,
		border = "rounded",
	}),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
	["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics,
		{ virtual_text = true }
	),
}

local function on_attach()
	-- local function on_attach(client, bufnr)
	-- set up buffer keymaps, etc.
end

-- setup language servers
lspconfig.tailwindcss.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
})
lspconfig.cssls.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
	settings = require("lsp.settings.cssls").settings,
})
lspconfig.eslint.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
})
lspconfig.jsonls.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
	settings = require("lsp.settings.jsonls").settings,
})
lspconfig.lua_ls.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_init = function(client)
		local ws = client.workspace_folders[1].name
		if not vim.uv.fs_stat(ws .. "/.luarc.json") and not vim.uv.fs_stat(ws .. "/.luarc.jsonc") then
			-- Assume Neovim workspace
			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = {
					version = "LuaJIT",
				},
				workspace = {
					library = {
						vim.env.VIMRUNTIME,
					},
				},
			})
		end
	end,
	on_attach = on_attach,
	settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})
lspconfig.tsserver.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
})
lspconfig.html.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
})
lspconfig.bashls.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
})
lspconfig.graphql.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
})
lspconfig.pyright.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
})
lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
})
lspconfig.gopls.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
})
lspconfig.emmet_ls.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
	filetypes = {
		"css",
		"eruby",
		"html",
		"javascript",
		"javascriptreact",
		"less",
		"sass",
		"scss",
		"svelte",
		"pug",
		"typescriptreact",
		"vue",
	},
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
		},
	},
})

-- global mappings
-- -- Diagnostic
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>fc", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

vim.keymap.set("n", "<leader>fp", ":PrettierAsync<cr>")
