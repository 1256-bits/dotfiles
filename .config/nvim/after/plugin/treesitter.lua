require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "javascript", "typescript", "bash", "c", "lua", "vim", "vimdoc", "query", "html", "sxhkdrc",
        "scss", "nu", },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        disable = { },
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
}
