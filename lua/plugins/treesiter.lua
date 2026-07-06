return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",

	opts = {
		ensure_installed = {
			"asm",
			"bash",
			"c",
			"cpp",
			"css",
			"csv",
			"dockerfile",
			"gitignore",
			"html",
			"javascript",
			"json",
			"lua",
			"make",
			"markdown",
			"markdown_inline",
			"nasm",
			"ocaml",
			"ocaml_interface",
			"printf",
			"python",
			"regex",
			"rust",
			"scss",
			"sql",
			"toml",
			"typescript",
			"yaml",
			"zig",
		},
	},

	config = function(_, opts)
		require("nvim-treesitter").setup(opts)

		vim.treesitter.language.register("groovy", "Jenkinsfile")

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})
	end,
}
