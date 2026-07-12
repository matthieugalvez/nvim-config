local opt = vim.opt

vim.lsp.log.set_level("error")

vim.diagnostic.config({
	virtual_text = true,
	severity_sort = true,

	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
})

-- Line numbers
opt.number = true

-- Tabs and indentation
opt.tabstop = 4
opt.expandtab = true
opt.softtabstop = 4
opt.shiftwidth = 4

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Appearance
opt.title = true
opt.titlestring = "%{getcwd()} - Neovim"
opt.cursorline = true
opt.showmode = false
opt.modeline = false
opt.cmdheight = 0
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Clipboard
opt.clipboard = "unnamedplus"

-- Windows
opt.splitright = true
opt.splitbelow = true

-- Undo history
opt.undofile = true

-- Invisible characters
opt.list = true
opt.listchars = {
	nbsp = "␣",
	trail = "•",
	tab = "» ",
}

local yank_group = vim.api.nvim_create_augroup("HighlightYank", {
	clear = true,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = yank_group,
	desc = "Highlight yanked text",
	callback = function()
		vim.hl.on_yank()
	end,
})
