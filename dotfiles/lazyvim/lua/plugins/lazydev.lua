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
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
		-- disable when a .luarc.json file is found
		enabled = function(root_dir)
			return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
		end,
	},
}
