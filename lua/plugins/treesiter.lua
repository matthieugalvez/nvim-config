return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter")

		treesitter.install({
			"asm",
			"bash",
			"c",
			"cpp",
			"dockerfile",
			"gitignore",
			"lua",
			"make",
			"markdown",
			"nasm",
			"ocaml",
			"printf",
			"python",
			"regex",
			"rust",
			"toml",
			"yaml",
			"zig",
		})
	end,
}
