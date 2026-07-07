return {
	"mason-org/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	lazy = false,

	keys = {
		{
			"<leader>m",
			"<cmd>Mason<CR>",
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

		require("mason-tool-installer").setup({
			run_on_start = true,
			debounce_hours = 24,
			integrations = {
				["mason-lspconfig"] = false,
			},

			ensure_installed = {
				-- All-in-ones
				"biome",
				"ruff",
				"rust-analyzer",
				"taplo",

				-- LSPs
				"bash-language-server",
				"clangd",
				"docker-language-server",
				"lua-language-server",
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
