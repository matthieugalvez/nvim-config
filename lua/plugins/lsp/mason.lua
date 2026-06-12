return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

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
				"basedpyright",
				"bashls",
				"clangd",
				"docker_language_server",
				"lua_ls",
				"ruff",
				"rust_analyzer",
				"vtsls",
				"zls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"shfmt",
				"clang-format",
				"prettier",
				"stylua",
			},
		})
	end,
}
