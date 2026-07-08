return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",

	opts = {
		check_ts = true,
		disable_filetype = { "TelescopePrompt" },
		ts_config = {
			lua = { "string" },
			javascript = { "template_string" },
			java = false,
		},
	},
}
