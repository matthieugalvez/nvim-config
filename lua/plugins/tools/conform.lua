return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",

	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({
					lsp_format = "fallback",
					timeout_ms = 1000,
				})
			end,
			mode = { "n", "v" },
			desc = "Format buffer or selection",
		},
	},

	opts = function()
		local config_path = vim.fn.stdpath("config") .. "/config"
		local ruff_config = config_path .. "/ruff/ruff.toml"

		return {
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 1000,
			},

			formatters_by_ft = {
				bash = { "shellcheck", "shfmt" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				css = { "biome-check" },
				dockerfile = { "dockerfmt" },
				html = { "biome-check" },
				javascript = { "biome-check" },
				javascriptreact = { "biome-check" },
				json = { "biome-check" },
				jsonc = { "biome-check" },
				lua = { "stylua" },
				markdown = { "biome-check" },
				python = { "ruff_fix", "ruff_format" },
				rust = { "rustfmt" },
				scss = { "biome-check" },
				sh = { "shellcheck", "shfmt" },
				toml = { "taplo" },
				typescript = { "biome-check" },
				typescriptreact = { "biome-check" },
				yaml = { "biome-check" },
			},

			formatters = {
				ruff_fix = {
					append_args = {
						"--config",
						ruff_config,
					},
				},

				ruff_format = {
					append_args = {
						"--config",
						ruff_config,
					},
				},

				["clang-format"] = {
					append_args = {
						"--style=file:" .. config_path .. "/clang-format/.clang-format",
					},
				},

				["biome-check"] = {
					append_args = {
						"--config-path",
						config_path .. "/biome/biome.json",
					},
				},
			},
		}
	end,
}
