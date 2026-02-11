return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = {
			char = "│",
			tab_char = "│",
		},
		whitespace = {
			highlight = { "Whitespace", "Nontext" },
		},
		scope = {
			highlight = { "Function", "Statement", "Conditional", "Repeat", "Label", "Keyword", "Exception" },
			show_start = true,
			show_end = true,
		},
		exclude = {
			filetypes = {
				"dashboard",
				"lspinfo",
				"packer",
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
