local lsp = require('lsp-zero').preset({})
local cmp = require('cmp')
local lspconfig = require('lspconfig')

--Set up lsp

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)

lsp.ensure_installed({
    'bashls',
    'tsserver',
    'emmet_ls',
    'yamlls',
    'html',
    'cssls',
    'cssmodules_ls',
    'fennel_language_server',
    'pylsp',
})
-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

--Set up completion

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

--LSP modules configuration--

lspconfig.cssmodules_ls.setup {
    -- provide your on_attach to bind keymappings
    on_attach = custom_on_attach,
    -- optionally
    init_options = {
        camelCase = 'dashes',
    },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.cssls.setup {
    capabilities = capabilities,
}

local configs = require('lspconfig/configs')

lspconfig.emmet_ls.setup({
    init_options = {
        html = {
            options = {
                ['output.format'] = true,
                ['output.inlineBreak'] = 2,
                ["bem.enabled"] = true,
            },
        },
    }
})

require 'lspconfig'.pylsp.setup {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    maxLineLength = 100,
                }
            }
        }
    }
}

lsp.setup()
