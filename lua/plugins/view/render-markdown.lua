return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown", "quarto" },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		completions = {
			lsp = { enabled = true },
		},
		render_modes = true,
	},
}
