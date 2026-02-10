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
			-- Liste des serveurs à installer par défaut
			-- List des serveurs possibles : https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
			-- Vous pouvez ne pas en mettre ici et tout installer en utilisant :Mason
			-- Mais au lieu de passer par :Mason pour installer, je vous recommande d'ajouter une entrée à cette liste
			-- Ça permettra à votre configuration d'être plus portable
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
