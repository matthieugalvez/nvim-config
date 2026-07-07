return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	cmd = "Telescope",

	keys = {
		{
			"<leader>tf",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Find files",
		},
		{
			"<leader>tg",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Live grep",
		},
		{
			"<leader>tb",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Find buffers",
		},
		{
			"<leader>tx",
			function()
				require("telescope.builtin").grep_string()
			end,
			desc = "Grep word under cursor",
		},
	},

	opts = function()
		local actions = require("telescope.actions")
		local themes = require("telescope.themes")

		return {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "smart" },
				file_ignore_patterns = {
					"%.git/",
					"node_modules/",
				},

				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},

			extensions = {
				ui_select = themes.get_dropdown(),
			},
		}
	end,

	config = function(_, opts)
		local telescope = require("telescope")

		telescope.setup(opts)
		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
	end,
}
