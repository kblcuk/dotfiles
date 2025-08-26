return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = false },
			servers = {
				vtsls = {
					handlers = {
						["textDocument/publishDiagnostics"] = function(_, result, ctx)
							if result.diagnostics == nil then
								return
							end
							local idx = 1
							while idx <= #result.diagnostics do
								local entry = result.diagnostics[idx]
								if entry.code == 80001 then
									-- { message = "File is a CommonJS module; it may be converted to an ES module.", }
									table.remove(result.diagnostics, idx)
								elseif entry.code == 7016 then
									-- { message = "Could not find a declaration file for module...", }
									table.remove(result.diagnostics, idx)
								else
									idx = idx + 1
								end
							end
							vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx)
						end,
					},
				},
			},
		},
	},
}
