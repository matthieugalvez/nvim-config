return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		local parsers = {
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
		}

		for _, parser in ipairs(parsers) do
			ts.install(parser)
		end

		local patterns = {}

		for _, parser in ipairs(parsers) do
			local parser_patterns = vim.treesitter.language.get_filetypes(parser)
			for _, pp in pairs(parser_patterns) do
				table.insert(patterns, pp)
			end
		end

		vim.treesitter.language.register("groovy", "Jenkinsfile")
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"

		vim.api.nvim_create_autocmd("FileType", {
			pattern = patterns,
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
