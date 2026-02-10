return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			separator_style = "slant",
			offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
			right_mouse_command = nil,
			middle_mouse_command = "bdelete! %d",
		},
	},
}
