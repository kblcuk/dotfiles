require("nvim-treesitter.configs").setup({
	--> parsers <--
	ensure_installed = {
		"css",
		"fish",
		"javascript",
		"lua",
		"typescript",
		"python"
	},
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
