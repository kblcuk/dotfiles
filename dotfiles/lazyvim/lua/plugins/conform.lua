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
			-- Conform will run multiple formatters sequentially
			python = { "black", "pylint", "flake8" },
			javascript = function(bufnr)
				return { first(bufnr, "eslint_d", "eslint"), first(bufnr, "prettierd", "prettier") }
			end,
			css = function(bufnr)
				return { first(bufnr, "prettierd", "prettier") }
			end,
			typescript = function(bufnr)
				return { first(bufnr, "eslint_d", "eslint"), first(bufnr, "prettierd", "prettier") }
			end,
			typescriptreact = function(bufnr)
				return { first(bufnr, "eslint_d", "eslint"), first(bufnr, "prettierd", "prettier") }
			end,
			vue = function(bufnr)
				return { first(bufnr, "eslint_d", "eslint"), first(bufnr, "prettierd", "prettier") }
			end,
			["*"] = { "trim_whitespace" },
		},
	},
}
