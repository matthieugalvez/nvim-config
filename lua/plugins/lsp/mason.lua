return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		-- import de mason
		local mason = require("mason")

		-- import de mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		-- Active mason et personnalise les icônes
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			automatic_enable = true,
			ensure_installed = {
				"bashls",
				"clangd",
				"docker_language_server",
				"lua_ls",
				"ruff",
				"rust_analyzer",
				"zls",
			},
		})
	end,
}
