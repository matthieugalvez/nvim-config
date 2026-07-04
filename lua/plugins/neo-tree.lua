return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		keys = {
			{
				"<C-h>",
				"<cmd>Neotree toggle<CR>",
				desc = "Toggle Neo-tree",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"Crysthamus/nvim-file-operations",
				config = true,
			},
		},
	},

	{
		"s1n7ax/nvim-window-picker",
		config = function()
			require("window-picker").setup({
				filter_rules = {
					include_current_win = false,
					autoselect_one = true,
					-- filter using buffer options
					bo = {
						-- if the file type is one of following, the window will be ignored
						filetype = { "neo-tree", "neo-tree-popup", "notify" },
						-- if the buffer type is one of following, the window will be ignored
						buftype = { "terminal", "quickfix" },
					},
				},
			})
		end,
	},
}
