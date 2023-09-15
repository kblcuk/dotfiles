-- null_ls
local null_ls = require("null-ls")
local u = require("lspconfig.util")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- require("null-ls").setup({
--     -- you can reuse a shared lspconfig on_attach callback here
--     on_attach = function(client, bufnr)
--         if client.supports_method("textDocument/formatting") then
--             vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--             vim.api.nvim_create_autocmd("BufWritePre", {
--                 group = augroup,
--                 buffer = bufnr,
--                 callback = function()
--                     -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
--                     -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
--                     vim.lsp.buf.formatting_sync()
--                 end,
--             })
--         end
--     end,
-- })

null_ls.setup({
	debug = false,
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
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
					vim.lsp.buf.format()
				end,
			})
		end
	end,

	--if client.server_capabilities.documentFormattingProvider then
	--	-- fffrfr, this should use vim.api.nvim_create_autocmd
	--	vim.cmd([[
	--augroup LspFormatting
	--autocmd! * <buffer>
	--autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ timeout_ms = 2000 })
	--augroup END
	--]])
	--	-- vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	--	-- vim.api.nvim_create_autocmd("BufWritePre", {
	--	--	 group = augroup,
	--	--	 buffer = bufnr,
	--	--	 -- on 0.8, you should use vim.lsp.buf.format instead
	--	--	 callback = vim.lsp.buf.format,
	--	-- })
	--end
	---- you can reuse a shared lspconfig on_attach callback here
	---- on_attach = function(client)
	----	 if client.server_capabilities.document_formatting then
	----	 vim.cmd([[
	---- augroup LspFormatting
	---- autocmd! * <buffer>
	---- autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
	---- augroup END
	---- ]])
	----	 end
	--end,
})
