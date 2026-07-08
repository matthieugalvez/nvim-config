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
		completion = {
			list = {
				selection = {
					preselect = false,
					auto_insert = false,
				},
			},
		},

		keymap = {
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "hide", "fallback" },
		},

		signature = {
			enabled = true,
			trigger = {
				show_on_keyword = true,
				show_on_insert = true,
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
