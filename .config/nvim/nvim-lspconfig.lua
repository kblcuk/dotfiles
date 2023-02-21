-------------------- LSP ---------------------------------
vim.lsp.set_log_level("error")

local nvim_lsp = require("lspconfig")
local u = require("lspconfig.util")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<space>wl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end

local servers = { "pyright", "html", "cssls", "terraformls" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = on_attach,
	})
end

nvim_lsp.flow.setup({
	on_attach = on_attach,
})

-- different tsserver setup, since javascript files should be handled by flow
nvim_lsp.tsserver.setup({
	on_attach = on_attach,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx" }, --	"javascriptreact" ?
})

-- Formatting extras
-- https://www.reddit.com/r/neovim/comments/jvisg5/lets_talk_formatting_again/
vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
	if err ~= nil or result == nil then
		return
	end
	if not vim.api.nvim_buf_get_option(bufnr, "modified") then
		local view = vim.fn.winsaveview()
		vim.lsp.util.apply_text_edits(result, bufnr)
		vim.fn.winrestview(view)
		if bufnr == vim.api.nvim_get_current_buf() then
			vim.api.nvim_command("noautocmd :update")
		end
	end
end

nvim_lsp.kotlin_language_server.setup({})

-- set this if you haven't set it elsewhere, ideally inside on_attach
vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

-- define global function
_G.lsp_import_on_completion = function()
	local completed_item = vim.v.completed_item
	if
		not (
			completed_item
			and completed_item.user_data
			and completed_item.user_data.nvim
			and completed_item.user_data.nvim.lsp
			and completed_item.user_data.nvim.lsp.completion_item
		)
	then
		return
	end

	local item = completed_item.user_data.nvim.lsp.completion_item
	local bufnr = vim.api.nvim_get_current_buf()
	vim.lsp.buf_request(bufnr, "completionItem/resolve", item, function(_, _, result)
		if result and result.additionalTextEdits then
			vim.lsp.util.apply_text_edits(result.additionalTextEdits, bufnr)
		end
	end)
end

-- define autocmd to listen for CompleteDone
vim.api.nvim_exec(
	[[
augroup LSPImportOnCompletion
	autocmd!
	autocmd CompleteDone * lua lsp_import_on_completion()
augroup END
]],
	false
)

local null_ls = require("null-ls")

null_ls.setup({
	debug = true,
	root_dir = u.root_pattern(".null-ls-root", "Makefile", ".git", "main.tf"),
	sources = {
		null_ls.builtins.formatting.prettier.with({
			prefer_local = "node_modules/.bin",
		}),
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.formatting.eslint_d,

		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.formatting.black,

		null_ls.builtins.diagnostics.luacheck,
		null_ls.builtins.formatting.stylua,

		-- null_ls.builtins.diagnostics.yamllint,
		-- null_ls.builtins.diagnostics.ansiblelint,

		-- null_ls.builtins.formatting.terrafmt,
		null_ls.builtins.formatting.terraform_fmt,

		-- github actions
		-- null_ls.builtins.diagnostics.actionlint,

		-- docker
		null_ls.builtins.diagnostics.hadolint,
	},
	on_attach = function(client, bufnr)
		if client.server_capabilities.documentFormattingProvider then
			-- fffrfr, this should use vim.api.nvim_create_autocmd
			vim.cmd([[
	augroup LspFormatting
	autocmd! * <buffer>
	autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ timeout_ms = 2000 })
	augroup END
	]])
			-- vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			-- vim.api.nvim_create_autocmd("BufWritePre", {
			--	 group = augroup,
			--	 buffer = bufnr,
			--	 -- on 0.8, you should use vim.lsp.buf.format instead
			--	 callback = vim.lsp.buf.format,
			-- })
		end
		-- you can reuse a shared lspconfig on_attach callback here
		-- on_attach = function(client)
		--	 if client.server_capabilities.document_formatting then
		--	 vim.cmd([[
		-- augroup LspFormatting
		-- autocmd! * <buffer>
		-- autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
		-- augroup END
		-- ]])
		--	 end
	end,
})

require("trouble").setup()

require("nvim-web-devicons").setup()
require("lsp-colors").setup()
require("lualine").setup({ theme = "gruvbox-dark" })

-- Setup nvim-cmp.
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			select = false,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	-- mapping = cmp.mapping.preset.insert({
	--	 ["<C-b>"] = cmp.mapping.scroll_docs(-4),
	--	 ["<C-f>"] = cmp.mapping.scroll_docs(4),
	--	 ["<C-Space>"] = cmp.mapping.complete(),
	--	 ["<C-e>"] = cmp.mapping.abort(),
	--	 ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	-- }),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		-- { name = 'vsnip' }, -- For vsnip users.
		{ name = "luasnip" }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = "buffer" },
	}),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- Setup lspconfig.
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		capabilities = capabilities,
	})
end
