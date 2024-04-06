-- Bootstrap lazy.nvim

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

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
	-- { "ellisonleao/gruvbox.nvim", priority = 1000, lazy = false },
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		opts = {
			variant = "auto", -- auto, main, moon, or dawn
			dark_variant = "moon", -- main, moon, or dawn
			enable = {
				terminal = true,
			},
			styles = {
				transparency = true,
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	},
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({
				-- git = {
				--   bcommits = {
				--     cmd = "git log --color --follow --pretty=format:'%C(yellow)%h%Creset "
				--       .. "%Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset' <file>",
				--   },
				-- },
			})
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
		opts = {},
	},
	{
		"numToStr/Navigator.nvim",
		opts = {},
	},

	--  The configuration is done below. Search for lspconfig to find it below.
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
			{
				"linrongbin16/lsp-progress.nvim",
				config = function()
					require("lsp-progress").setup({})
				end,
			},
		},
	},

	-- better typescript https://github.com/pmizio/typescript-tools.nvim
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},

	{ "simrat39/rust-tools.nvim", opts = {} },
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			"saadparwaiz1/cmp_luasnip",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",

			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",

			-- Adds a number of user-friendly snippets
			"rafamadriz/friendly-snippets",
		},
	},

	{ "JoosepAlviste/nvim-ts-context-commentstring", dependencies = {
		{ "tpope/vim-commentary" },
	} },
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-rhubarb" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-abolish" },

	{ "lewis6991/gitsigns.nvim", opts = {} },

	{ "windwp/nvim-autopairs", opts = {} },
	{
		"stevearc/conform.nvim",
		opts = {},
	},
	{
		"nvim-java/nvim-java",
		dependencies = {
			"nvim-java/lua-async-await",
			"nvim-java/nvim-java-core",
			"nvim-java/nvim-java-test",
			"nvim-java/nvim-java-dap",
			"MunifTanjim/nui.nvim",
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap",
			{
				"williamboman/mason.nvim",
				opts = {
					registries = {
						"github:nvim-java/mason-registry",
						"github:mason-org/mason-registry",
					},
				},
			},
		},
	},
	"cormacrelf/dark-notify",

	-- plugins folder
	require("plugins.nvim-treesitter"),
	require("plugins.markdown-preview"),
	require("plugins.venv-selector"),
}, {
	checker = {
		-- automatically check for plugin updates
		enabled = true,
		concurrency = nil, ---@type number? set to 1 to check for updates very slowly
		notify = true, -- get a notification when new updates are found
		frequency = 43200, -- check for updates daily
	},
})
