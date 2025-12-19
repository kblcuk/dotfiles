-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- need to disable both number & relativenumber,
-- since setting the latter one to `true` (lazyvim
-- default) also enables number
local opt = vim.opt
opt.number = false
opt.relativenumber = false
opt.list = false
opt.shell = "/bin/bash"

vim.g.lazyvim_python_ruff = "ruff"

vim.g.snacks_animate = false

-- For some reason this is disabled even though
-- docs say it should be enabled
vim.g.editorconfig = true

-- enabling copypasting in neovide
if vim.g.neovide then
	vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
	vim.keymap.set("v", "<D-c>", '"+y') -- Copy
	vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
	vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
	vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

	vim.g.neovide_theme = "auto"
	vim.g.neovide_position_animation_length = 0.02
	vim.g.neovide_cursor_animation_length = 0.02
	vim.g.neovide_cursor_short_animation_length = 0.02
	vim.g.neovide_cursor_trail_size = 0.02
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_cursor_animate_command_line = true
	vim.g.neovide_scroll_animation_far_lines = 1
	vim.g.neovide_scroll_animation_length = 0.02
	vim.g.neovide_opacity = 0.98

	vim.g.neovide_cursor_vfx_mode = ""

	vim.o.guifont = "JetBrainsMono Nerd Font:h12"
end

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
