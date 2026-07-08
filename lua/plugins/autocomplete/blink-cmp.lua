return {
	"saghen/blink.cmp",
	version = "1.*",
	event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},

	---@module "blink.cmp"
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "none",
			["<Down>"] = { "select_next", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "hide", "fallback" },
		},

		completion = {
			list = {
				selection = {
					preselect = false,
					auto_insert = false,
				},
			},
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				lua = { inherit_defaults = true, "lazydev" },
			},
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},

		cmdline = {
			enabled = false,
		},
	},
}
