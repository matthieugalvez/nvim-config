-- On définit notre touche leader sur espace
vim.g.mapleader = " "

-- Raccourci pour la fonction set
local keymap = vim.keymap.set

-- I déplace le texte sélectionné vers le haut en mode visuel (activé avec v)
keymap("v", "<S-i>", ":m .-2<CR>==", { desc = "Déplace le texte sélectionné vers le haut en mode visuel" })
-- K déplace le texte sélectionné vers le bas en mode visuel (activé avec v)
keymap("v", "<S-k>", ":m .+1<CR>==", { desc = "Déplace le texte sélectionné vers le bas en mode visuel" })

-- I déplace le texte sélectionné vers le haut en mode visuel bloc (activé avec V)
keymap("x", "<S-i>", ":move '<-2<CR>gv-gv", { desc = "Déplace le texte sélectionné vers le haut en mode visuel bloc" })
-- K déplace le texte sélectionné vers le bas en mode visuel  bloc (activé avec V)
keymap("x", "<S-k>", ":move '>+1<CR>gv-gv", { desc = "Déplace le texte sélectionné vers le bas en mode visuel bloc" })

keymap("n", "<leader>l", ":Lazy<CR>", { desc = "Lance lazy.nvim" })
keymap("n", "<leader>m", ":Mason<CR>", { desc = "Lance Mason" })

-- Changement de fenêtre avec Ctrl + déplacement uniquement au lieu de Ctrl-w + déplacement
keymap("n", "<C-Left>", "<C-w>h", { desc = "Déplace le curseur dans la fenêtre de gauche" })
keymap("n", "<C-Down>", "<C-w>j", { desc = "Déplace le curseur dans la fenêtre du bas" })
keymap("n", "<C-Up>", "<C-w>k", { desc = "Déplace le curseur dans la fenêtre du haut" })
keymap("n", "<C-Right>", "<C-w>l", { desc = "Déplace le curseur dans la fenêtre droite" })

-- Navigation entre les buffers
keymap("n", "<S-Right>", ":bnext<CR>", opts)
keymap("n", "<S-Left>", ":bprevious<CR>", opts)

keymap("n", "<C-h>", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
