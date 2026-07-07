return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			{ "Crysthamus/nvim-file-operations", opts = {} },
			{
				"s1n7ax/nvim-window-picker",
				version = "2.*",

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
		},
		cmd = "Neotree",

		keys = {
			{
				"<C-h>",
				"<cmd>Neotree toggle<CR>",
				desc = "Toggle Neo-tree",
			},
		},

		opts = {
			window = {
				mappings = {
					["<CR>"] = "open_with_window_picker",
				},
			},
		},
	},
}
