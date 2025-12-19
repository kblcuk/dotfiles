return {
	"folke/snacks.nvim",
	opts = {
		-- disable indent guidelines, since they are always 2-space,
		-- and make little sense when 4-space indents are used
		-- sadly there is no way to configure this yet, it seems
		indent = { enabled = false },
	},
}
