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
			highlight = { "Function", "Label" },
			show_start = true,
			show_end = false,
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
