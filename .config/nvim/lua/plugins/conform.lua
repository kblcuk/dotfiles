-- null-ls was great, but not maintained
-- anymore, so conform is new null-ls
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "prettierd", "prettier" } },
		typescript = { "eslint_d", { "prettierd", "prettier" } },
		typescriptreact = { "eslint_d", { "prettierd", "prettier" } },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 100,
		lsp_fallback = true,
	},
})
