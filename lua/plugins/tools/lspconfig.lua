return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "Crysthamus/nvim-file-operations", opts = {} },
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {},
		},
	},

	config = function()
		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities(),
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

		require("mason-lspconfig").setup()
	end,
}
