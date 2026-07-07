return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/nvim-cmp",
	},

	opts = {
		check_ts = true,
		disable_filetype = { "TelescopePrompt" },
		ts_config = {
			lua = { "string" },
			javascript = { "template_string" },
			java = false,
		},
	},

	config = function(_, opts)
		local autopairs = require("nvim-autopairs")

		autopairs.setup(opts)

		local cmp = require("cmp")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")

		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
