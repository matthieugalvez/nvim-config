-- On définit notre touche leader sur espace
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Raccourci pour la fonction set
local keymap = vim.keymap.set

keymap("n", "<leader>l", ":Lazy<CR>", { desc = "Lance lazy.nvim" })
keymap("n", "<leader>m", ":Mason<CR>", { desc = "Lance Mason" })

-- Changement de fenêtre avec Ctrl + déplacement uniquement au lieu de Ctrl-w + déplacement
keymap("n", "<C-Left>", "<C-w>h", { desc = "Déplace le curseur dans la fenêtre de gauche" })
keymap("n", "<C-Down>", "<C-w>j", { desc = "Déplace le curseur dans la fenêtre du bas" })
keymap("n", "<C-Up>", "<C-w>k", { desc = "Déplace le curseur dans la fenêtre du haut" })
keymap("n", "<C-Right>", "<C-w>l", { desc = "Déplace le curseur dans la fenêtre droite" })

keymap("n", "<C-h>", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
