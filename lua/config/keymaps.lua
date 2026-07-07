vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap.set

keymap("n", "<leader>l", ":Lazy<CR>", { desc = "Lazy" })

keymap("n", "<leader>d", ":nohl<CR>", { desc = "Reset highlight" })

keymap("n", "<C-Left>", "<C-w>h", { desc = "Move to the window to the left" })
keymap("n", "<C-Right>", "<C-w>l", { desc = "Move to the window to the right" })
keymap("n", "<C-Down>", "<C-w>j", { desc = "Move to the window below" })
keymap("n", "<C-Up>", "<C-w>k", { desc = "Move to the window above" })
