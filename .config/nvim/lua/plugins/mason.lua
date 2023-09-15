require("mason").setup()

mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"docker_compose_language_service",
		"dockerls",
		"tsserver",
		"pyright",
	},
})

mason_lspconfig.setup_handlers({
	--      function (server_name)
	--require("lspconfig")[server_name].setup()
	--      end
})
