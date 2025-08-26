return {
	{
		"yetone/avante.nvim",
		version = false,
		event = "VeryLazy",
		dependencies = {
			"ibhagwan/fzf-lua",
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"zbirenbaum/copilot.lua", -- for providers='copilot'
		},
		build = "make",
		opts = {
			-- Default configuration
			hints = { enabled = false },

			---@alias AvanteProvider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
			provider = "copilot", -- Recommend using Claude
			auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
			providers = {
				claude = {
					endpoint = "https://api.anthropic.com",
					model = "claude-3-5-sonnet-20241022",
					extra_request_body = {
						temperature = 0,
						max_tokens = 4096,
					},
				},
			},

			selector = {
				-- @alias avante.SelectorProvider "native" | "fzf_lua" | "mini_pick" | "snacks" | "telescope" | fun(selector: avante.ui.Selector): nil
				provider = "fzf_lua",
				-- Options override for custom providers
				provider_opts = {},
			},
		},
	},
	-- {
	-- 	"saghen/blink.cmp",
	-- 	lazy = true,
	-- 	dependencies = { "saghen/blink.compat" },
	-- 	opts = {
	-- 		sources = {
	-- 			default = { "avante_commands", "avante_mentions", "avante_files" },
	-- 			compat = {
	-- 				"avante_commands",
	-- 				"avante_mentions",
	-- 				"avante_files",
	-- 			},
	-- 			-- LSP score_offset is typically 60
	-- 			providers = {
	-- 				avante_commands = {
	-- 					name = "avante_commands",
	-- 					module = "blink.compat.source",
	-- 					score_offset = 90,
	-- 					opts = {},
	-- 				},
	-- 				avante_files = {
	-- 					name = "avante_files",
	-- 					module = "blink.compat.source",
	-- 					score_offset = 100,
	-- 					opts = {},
	-- 				},
	-- 				avante_mentions = {
	-- 					name = "avante_mentions",
	-- 					module = "blink.compat.source",
	-- 					score_offset = 1000,
	-- 					opts = {},
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },
	{
		-- Make sure to set this up properly if you have lazy=true
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {
			file_types = { "markdown", "Avante" },
		},
		ft = { "markdown", "Avante" },
	},
	{
		"folke/which-key.nvim",
		optional = true,
		opts = {
			spec = {
				{ "<leader>a", group = "ai" },
			},
		},
	},
}
