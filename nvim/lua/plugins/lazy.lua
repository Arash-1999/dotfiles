local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
	-- fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
	},

	-- colorscheme
	{
		"rebelot/kanagawa.nvim",
		config = {
			transparent = true,
		},
	},

	-- syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
	{
		"norcalli/nvim-colorizer.lua",
	},

	-- vs code: tempalte string converted
	-- {
	--   "axelvc/template-string.nvim",
	--   event = "InsertEnter",
	--   ft = {
	--     "javascript",
	--     "typescript",
	--     "javascriptreact",
	--     "typescriptreact",
	--   },
	--   config = true, -- run require("template-string").setup()
	-- },

	-- LSP Base
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
	},

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
	},

	-- snippets
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
	},
	{
		"saadparwaiz1/cmp_luasnip",
	},

	-- formatter
	{
		"stevearc/conform.nvim",
	},

	-- UI
	-- {
	--   "folke/noice.nvim",
	--   event = "VeryLazy",
	--   opts = {
	--     -- add any options here
	--   },
	--   dependencies = {
	--     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	--     "MunifTanjim/nui.nvim",
	--     -- OPTIONAL:
	--     --   `nvim-notify` is only needed, if you want to use the notification view.
	--     --   If not available, we use `mini` as the fallback
	--     "rcarriga/nvim-notify",
	--   }
	-- },

	-- file explorer
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- highlight todos
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},

	-- comment
	{
		"numToStr/Comment.nvim",
		-- opts = {},
		lazy = false,
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},

	-- highlight indents
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		-- opts = {}
	},

	-- markdown preview
	{
		-- install without yarn or npm
		-- *** *** *** *** *** --
		-- *** *** *** *** *** --

		{
			-- Install markdown preview, use npx if available.
			"iamcco/markdown-preview.nvim",
			cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
			ft = { "markdown" },
			build = function(plugin)
				if vim.fn.executable("npx") then
					vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
				else
					vim.cmd([[Lazy load markdown-preview.nvim]])
					vim.fn["mkdp#util#install"]()
				end
			end,
			init = function()
				if vim.fn.executable("npx") then
					vim.g.mkdp_filetypes = { "markdown" }
				end
			end,
		},
		-- uncomment to install with yarn or npm
		-- *** *** *** *** *** --
		-- "iamcco/markdown-preview.nvim",
		-- cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		-- build = "cd app && yarn install",
		-- init = function()
		--   vim.g.mkdp_filetypes = { "markdown" }
		-- end,
		-- ft = { "markdown" },
		-- *** *** *** *** *** --
	},

	-- postman/insomnia alternative (rest api platform)
	-- {
	-- 	"vhyrro/luarocks.nvim",
	-- 	priority = 1000,
	-- 	config = true,
	-- 	opts = {
	-- 		rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
	-- 	},
	-- },
	-- {
	-- 	"rest-nvim/rest.nvim",
	-- 	ft = "http",
	-- 	dependencies = { "luarocks.nvim" },
	-- },

	-- better looking quickfix list
	{
		"kevinhwang91/nvim-bqf",
	},

	-- hiphish/rainbow-delimiters.nvim
})
