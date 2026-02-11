return {
	"folke/which-key.nvim",
	dependencies = {
		"nvim-mini/mini.nvim",
	},
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = true })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
