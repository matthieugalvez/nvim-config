return {
	"j-hui/fidget.nvim",
	version = "*",
	event = { "LspAttach" },

	opts = {
		notification = {
			window = {
				avoid = { "neo-tree" },
			},
		},
	},
}
