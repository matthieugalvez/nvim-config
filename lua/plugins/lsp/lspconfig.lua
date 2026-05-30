return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- Va permettre de remplir le plugin de complétion automatique nvim-cmp
		-- avec les résultats des LSP
		"hrsh7th/cmp-nvim-lsp",
		-- Ajoute les « code actions » de type renommage de fichiers intelligent, etc
		{ "antosha417/nvim-lsp-file-operations", config = true },
		-- Utile pour éditer les fichiers lua spécifiques à la config neovim
		-- Notamment pour éviter le "Undefined global `vim`"
		{ "folke/lazydev.nvim", opts = {} },
	},
	config = function()
		-- Customize error signs
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "󰌵",
				},
			},
		})
	end,
}
