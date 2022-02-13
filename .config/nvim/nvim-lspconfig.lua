-------------------- LSP ---------------------------------
local nvim_lsp = require("lspconfig")
local lsp_completion = require("completion")
local u = require("lspconfig.util")

local on_attach = function(client, bufnr)
	lsp_completion.on_attach()

	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	-- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

	-- Set autocommands conditional on server_capabilities
	-- if client.resolved_capabilities.document_highlight then
	--   vim.api.nvim_exec([[
	--     hi LspReferenceRead cterm=bold ctermbg=red guibg=Black
	--     hi LspReferenceText cterm=bold ctermbg=red guibg=Black
	--     hi LspReferenceWrite cterm=bold ctermbg=red guibg=Black
	--     augroup lsp_document_highlight
	--       autocmd! * <buffer>
	--       autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
	--       autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
	--     augroup END
	--   ]], false)
	-- end

	if client.resolved_capabilities.completion then
		lsp_completion.on_attach(client, bufnr)
	end

	if client.config.flags then
		client.config.flags.allow_incremental_sync = true
	end
	client.resolved_capabilities.document_formatting = false
end

--Enable completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- This is kinda hacky and maybe not needed https://github.com/emacs-lsp/lsp-mode/issues/1449
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = { "pyright", "flow", "html", "cssls", "terraformls" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- different tsserver setup, since javascript files should be handled by flow
nvim_lsp.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }, --  "javascriptreact" ?
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
		-- null_ls.builtins.formatting.eslint,
		null_ls.builtins.formatting.eslint_d,

		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.formatting.black,

		null_ls.builtins.diagnostics.luacheck,
		null_ls.builtins.formatting.stylua,

		-- null_ls.builtins.formatting.terrafmt,
		null_ls.builtins.formatting.terraform_fmt,
	},
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
      augroup LspFormatting
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
      ]])
		end
	end,
})

require("trouble").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
})
