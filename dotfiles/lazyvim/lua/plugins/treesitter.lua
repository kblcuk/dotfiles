return {
	"nvim-treesitter/nvim-treesitter",
	opts = function(_, opts)
		vim.list_extend(opts.ensure_installed, {
			"bash",
			"css",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"regex",
			"scss",
			"tsx",
			"typescript",
			"vim",
			"vue",
			"yaml",
		})
	end,
}
