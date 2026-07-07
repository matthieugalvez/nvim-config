return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"Crysthamus/nvim-file-operations",
				config = true,
			},
		},
		cmd = "NeoTree",

		keys = {
			{
				"<C-h>",
				"<cmd>Neotree toggle<CR>",
				desc = "Toggle Neo-tree",
			},
		},
	},

	{
		"s1n7ax/nvim-window-picker",

		opts = {
			filter_rules = {
				include_current_win = false,
				autoselect_one = true,

				bo = {
					filetype = {
						"neo-tree",
						"neo-tree-popup",
						"notify",
					},
					buftype = {
						"terminal",
						"quickfix",
					},
				},
			},
		},
	},
}
