return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-buffer", -- source pour compléter le texte déjà présent dans le buffer
		"hrsh7th/cmp-path", -- source pour compléter les chemins des fichiers
		"hrsh7th/cmp-cmdline", -- source pour les completions de la cmdline de vim
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- ajoute LuaSnip à l'autocompletion
		"rafamadriz/friendly-snippets", -- collection de snippets pratiques
	},
	config = function()
		local cmp = require 'cmp'
		local luasnip = require 'luasnip'
		require('luasnip.loaders.from_vscode').lazy_load()
		luasnip.config.setup {}

		cmp.setup {
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert {
				['<Down>'] = cmp.mapping.select_next_item(),
				['<Up>'] = cmp.mapping.select_prev_item(),
				['<C-Space>'] = cmp.mapping.complete {},
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.insert,
					select = false,
				},
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { 'i', 's' }),
			},
			sources = {
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			},
		}
	end,
}
