return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPre", "BufNewFile" },

	opts = {
		indent = {
			char = "│",
			tab_char = "│",
		},
		whitespace = {
			highlight = { "Whitespace", "NonText" },
		},
		scope = {
			show_start = true,
			show_end = true,
			show_exact_scope = true,
		},
		exclude = {
			filetypes = {
				"dashboard",
				"lspinfo",
				"checkhealth",
				"help",
				"man",
				"gitcommit",
				"TelescopePrompt",
				"TelescopeResults",
				"",
			},
		},
	},
}
