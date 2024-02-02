-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme rose-pine]])

-- Sync clipboard between OS and Neovim
vim.o.clipboard = "unnamedplus"

-- navigation
vim.keymap.set({ "n", "t" }, "<A-h>", "<CMD>NavigatorLeft<CR>")
vim.keymap.set({ "n", "t" }, "<A-l>", "<CMD>NavigatorRight<CR>")
vim.keymap.set({ "n", "t" }, "<A-k>", "<CMD>NavigatorUp<CR>")
vim.keymap.set({ "n", "t" }, "<A-j>", "<CMD>NavigatorDown<CR>")
vim.keymap.set({ "n", "t" }, "<A-p>", "<CMD>NavigatorPrevious<CR>")

-- keymaps
vim.keymap.set("n", "<Leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fg", "<cmd>lua require('fzf-lua').grep_project()<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fG", "<cmd>lua require('fzf-lua').grep_cword()<CR>", { silent = true })
vim.keymap.set("n", "<Leader>gc", "<cmd>lua require('fzf-lua').git_commits()<CR>", { silent = true })
vim.keymap.set("n", "<Leader>gb", "<cmd>lua require('fzf-lua').git_bcommits()<CR>", { silent = true })

-- fugitive
vim.keymap.set("n", "<Leader>gg", "<cmd>Git<CR>", { silent = true })

-- random
vim.keymap.set("i", "jk", "<ESC>", { silent = true })
-- quickfix shortcuts
vim.keymap.set("n", "]q", "<cmd>cnext<CR>", { silent = true })
vim.keymap.set("n", "]Q", "<cmd>clast<CR>", { silent = true })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>", { silent = true })
vim.keymap.set("n", "[Q", "<cmd>cfirst<CR>", { silent = true })

-- opts
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.scrolloff = 5
vim.o.signcolumn = "yes"

vim.o.wildoptions = "pum"
vim.o.pumblend = 20

-- Switching to new buffer without saving current one is ok
vim.o.hidden = true

-- Sadly Fish causes random mega-slowliness to vim-fugitive :(
vim.o.shell = "/bin/bash"

-- Better display for messages
vim.o.cmdheight = 2

-- You will have bad experience for diagnostic messages when it's default 4000.
vim.o.updatetime = 50

-- vim.o.completeopt to have a better completion experience
vim.o.completeopt = menuone, noinsert, noselect

-- don't give |ins-completion-menu| messages.
-- Avoid showing message extra message when using completion
-- vim.o.shortmess+=c
