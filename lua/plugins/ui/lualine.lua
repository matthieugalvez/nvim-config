return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	opts = function()
		local lazy_status = require("lazy.status")

		return {
			options = {
				globalstatus = true,
			},

			sections = {
				lualine_c = {
					{ "filename", path = 1 },
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = "DiagnosticWarn",
					},
					"encoding",
					"fileformat",
					"filetype",
				},
			},

			extensions = {
				"neo-tree",
				"mason",
				"lazy",
			},
		}
	end,
}
