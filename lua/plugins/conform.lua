return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },

	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({
					lsp_format = "fallback",
					async = false,
					timeout_ms = 1000,
				})
			end,
			desc = "Format buffer",
		},
	},

	opts = function()
		local config_path = vim.fn.stdpath("config") .. "/config"

		return {
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},

			formatters_by_ft = {
				bash = { "shellcheck", "shfmt" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				css = { "biome" },
				dockerfile = { "dockerfmt" },
				html = { "biome" },
				javascript = { "biome" },
				javascriptreact = { "biome" },
				json = { "biome" },
				jsonc = { "biome" },
				lua = { "stylua" },
				markdown = { "biome" },
				python = { "ruff_fix", "ruff_format" },
				rust = { "rustfmt" },
				scss = { "biome" },
				sh = { "shellcheck", "shfmt" },
				toml = { "taplo" },
				typescript = { "biome" },
				typescriptreact = { "biome" },
				yaml = { "biome" },
			},

			formatters = {
				ruff_format = {
					args = {
						"--config",
						config_path .. "/ruff/ruff.toml",
					},
				},

				["clang-format"] = {
					args = {
						"--style=file:" .. config_path .. "/clang-format/.clang-format",
					},
				},

				biome = {
					command = "biome",
					args = {
						"check",
						"--write",
						"--stdin-file-path",
						"$FILENAME",
						"--config-path=" .. config_path .. "/biome/biome.json",
					},
				},
			},
		}
	end,
}
