return {
	"j-hui/fidget.nvim",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },

	opts = {
		notification = {
			window = {
				avoid = { "neo-tree" },
			},
		},
	},
}
