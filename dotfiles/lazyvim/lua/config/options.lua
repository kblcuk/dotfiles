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
