return {
	"rcarriga/nvim-notify",
	lazy = true,

	init = function()
		---@diagnostic disable-next-line: duplicate-set-field
		vim.notify = function(...)
			return require("notify")(...)
		end
	end,

	opts = {
		fps = 60,
		render = "compact",
		timeout = 2000,
	},
}
