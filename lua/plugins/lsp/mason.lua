return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},

	keys = {
		{
			"<leader>m",
			":Mason<CR>",
			desc = "Mason",
		},
	},

	opts = {
		ui = {
			icons = {
				package_installed = "󰄳",
				package_pending = "󰔟",
				package_uninstalled = "󰚌",
			},
		},
	},

	config = function(_, opts)
		require("mason").setup(opts)

		require("mason-lspconfig").setup({
			automatic_enable = true,
		})

		require("mason-tool-installer").setup({
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
