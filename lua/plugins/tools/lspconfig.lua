return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"saghen/blink.cmp",
			{ "Crysthamus/nvim-file-operations", opts = {} },
		},

		config = function()
			local capabilities = vim.tbl_deep_extend(
				"force",
				require("blink.cmp").get_lsp_capabilities(),
				require("nvim-file-operations.config").default_capabilities()
			)

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--clang-tidy",
					"--enable-config",
				},
			})

			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
					},
				},
			})
			vim.lsp.enable("rust_analyzer")

			require("mason-lspconfig").setup()
		end,
	},

	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {},
	},
}
