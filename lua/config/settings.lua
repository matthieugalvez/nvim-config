local opt = vim.opt

vim.lsp.log.set_level("error")

vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = false,
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

-- Numéros de ligne
opt.number = true

-- Tabulations et indentation
opt.tabstop = 4
opt.shiftwidth = 4

-- Recherche
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Apparence
opt.cursorline = true
opt.showmode = false
opt.modeline = false
opt.cmdheight = 0
opt.shortmess:append("c")
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Presse-papiers
opt.clipboard = "unnamedplus"

-- Fenêtres
opt.splitright = true
opt.splitbelow = true

-- Historique d’annulation
opt.undofile = true

-- Complétion
opt.completeopt = { "menu", "menuone", "noselect" }

-- Caractères invisibles
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
