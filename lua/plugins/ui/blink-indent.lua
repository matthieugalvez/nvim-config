return {
	"saghen/blink.indent",

	---@module "blink.indent"
	---@type blink.indent.Config
	opts = {
		blocked = {
			buftypes = {
				include_defaults = true,
			},
			filetypes = {
				include_defaults = true,
				"neo-tree",
			},
		},
		static = {
			char = "╎",
		},

		scope = {
			enabled = true,
			char = "▏",
			highlights = {
				"BlinkIndentBlue",
			},
			underline = {
				enabled = true,
				highlights = {
					"BlinkIndentBlueUnderLine",
				},
			},
		},
	},
}
