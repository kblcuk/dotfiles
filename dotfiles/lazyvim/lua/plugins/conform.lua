---https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#run-the-first-available-formatter-followed-by-more-formatters
---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
	local conform = require("conform")
	for i = 1, select("#", ...) do
		local formatter = select(i, ...)
		if conform.get_formatter_info(formatter, bufnr).available then
			return formatter
		end
	end
	return select(1, ...)
end

return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	lazy = true,
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			fish = { "fish_indent" },
			sh = { "shfmt" },
			rust = { "rustfmt", lsp_format = "fallback" },
			python = { "ruff" },
			javascript = function(bufnr)
				return { first(bufnr, "oxfmt", "prettierd", "prettier") }
			end,
			css = function(bufnr)
				return { first(bufnr, "oxfmt", "prettierd", "prettier") }
			end,
			typescript = function(bufnr)
				return { first(bufnr, "oxfmt", "prettierd", "prettier") }
			end,
			typescriptreact = function(bufnr)
				return { first(bufnr, "oxfmt", "prettierd", "prettier") }
			end,
			vue = function(bufnr)
				return { first(bufnr, "oxfmt", "prettierd", "prettier") }
			end,
			json = { "oxfmt" },
			toml = function(bufnr)
				return { first(bufnr, "oxfmt", "prettierd", "prettier") }
			end,
			["*"] = { "trim_whitespace" },
		},
	},
}
