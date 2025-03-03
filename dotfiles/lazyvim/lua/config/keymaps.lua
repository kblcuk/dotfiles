-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "t" }, "<A-h>", "<CMD>NavigatorLeft<CR>")
vim.keymap.set({ "n", "t" }, "<A-k>", "<CMD>NavigatorUp<CR>")
vim.keymap.set({ "n", "t" }, "<A-j>", "<CMD>NavigatorDown<CR>")
vim.keymap.set({ "n", "t" }, "<A-l>", "<CMD>NavigatorRight<CR>")
vim.keymap.set({ "n", "t" }, "<A-p>", "<CMD>NavigatorPrevious<CR>")

vim.keymap.set("i", "jk", "<ESC>", { silent = true })
--
-- fugitive
-- vim.keymap.set("n", "<Leader>gg", "<cmd>Git<CR>", { silent = true })
vim.keymap.set("n", "<Leader>gg", "<cmd>Neogit kind=split<CR>", { silent = true })
