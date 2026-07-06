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
		})

		mason_tool_installer.setup({
			ensure_installed = {
				-- LSP
				"bashls",
				"biome",
				"clangd",
				"docker_language_server",
				"lua_ls",
				"ruff",
				"rust_analyzer",
				"taplo",
				"ty",
				"zls",

				-- Formatters / Linters
				"clang-format",
				"dockerfmt",
				"shellcheck",
				"shfmt",
				"stylua",
			},
		})
	end,
}
