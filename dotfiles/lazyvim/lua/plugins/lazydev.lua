return {
	"folke/lazydev.nvim",
	ft = "lua",
	cmd = "LazyDev",
	opts = {
		library = {
			-- load testing libraries types if we are in test files
			-- (where "test files" means it contains "describe" or "assert")
			{ path = "${3rd}/busted/library", words = { "describe" } },
			{ path = "${3rd}/luassert/library", words = { "assert" } },
		},
	},
}
