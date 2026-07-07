return {
	"romus204/tree-sitter-manager.nvim",
	dependencies = {},
	lazy = false,

	keys = {
		{
			"<leader>s",
			":TSManager<CR>",
			desc = "Tree-sitter Manager",
		},
	},

	opts = {
		auto_install = true,
	},
}
