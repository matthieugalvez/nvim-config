return {
	"stevearc/conform.nvim",
	opts = {},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				bash = { "shfmt" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				css = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				jsonc = { "prettier" },
				html = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				python = { "ruff_fix", "ruff_format" },
				rust = { "rustfmt" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				yaml = { "prettier" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			conform.format({
				lsp_format = "fallback",
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
