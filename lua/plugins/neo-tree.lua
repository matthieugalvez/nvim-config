return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			"3rd/image.nvim",
			"s1n7ax/nvim-window-picker",
			"Crysthamus/nvim-file-operations",
		},
		lazy = false, -- neo-tree will lazily load itself
	},
}
