-- On définit notre touche leader sur espace
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Raccourci pour la fonction set
local keymap = vim.keymap.set

keymap("n", "<leader>l", ":Lazy<CR>", { desc = "Lazy" })
keymap("n", "<leader>m", ":Mason<CR>", { desc = "Mason" })

keymap("n", "<leader>d", ":nohl<CR>", { desc = "Reset highlight" })

-- Changement de fenêtre avec Ctrl + déplacement uniquement au lieu de Ctrl-w + déplacement
keymap("n", "<C-Left>", "<C-w>h", { desc = "Move to the window to the left" })
keymap("n", "<C-Right>", "<C-w>l", { desc = "Move to the window to the right" })
keymap("n", "<C-Down>", "<C-w>j", { desc = "Move to the window below" })
keymap("n", "<C-Up>", "<C-w>k", { desc = "Move to the window above" })
