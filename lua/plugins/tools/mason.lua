return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	lazy = false,

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
		require("mason-lspconfig").setup()

		require("mason-tool-installer").setup({
			ensure_installed = {
				-- All-in-ones
				"biome",
				"ruff",
				"rust_analyzer",
				"taplo",

				-- LSPs
				"bashls",
				"clangd",
				"docker_language_server",
				"lua_ls",
				"ty",
				"zls",

				-- Linters
				"shellcheck",

				-- Formatters
				"clang-format",
				"dockerfmt",
				"shfmt",
				"stylua",
			},
		})
	end,
}
