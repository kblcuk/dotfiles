return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPre",
	opts = {
		lazy_load = true,
		user_default_options = {
			names = false,
			css = true,
			css_fn = true,
			tailwind = true,
		},
	},
}
