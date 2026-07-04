return {
	"stevearc/conform.nvim",
	opts = {},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				bash = { "shellcheck", "shfmt" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				css = { "biome" },
				dockerfile = { "dockerfmt" },
				javascript = { "biome" },
				javascriptreact = { "biome" },
				json = { "biome" },
				jsonc = { "biome" },
				html = { "biome" },
				lua = { "stylua" },
				markdown = { "biome" },
				python = { "ruff_fix", "ruff_format" },
				rust = { "rustfmt" },
				scss = { "biome" },
				toml = { "taplo" },
				typescript = { "biome" },
				typescriptreact = { "biome" },
				yaml = { "biome" },
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
