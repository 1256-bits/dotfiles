local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

lsp.ensure_installed({
	'bashls',
	'tsserver',
	'emmet_ls',
	'yamlls',
})
-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()


local cmp = require('cmp')

cmp.setup({
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'path' },
		{ name = 'buffer' },
		{ name = 'luasnip' },
	},
	mapping = {
		['<C-n'] = cmp.mapping.select_next_item(),
		['<C-p'] = cmp.mapping.select_prev_item(),
	}
})
