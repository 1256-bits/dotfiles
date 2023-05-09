require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "javascript", "typescript", "bash", "c", "lua", "vim", "vimdoc", "query", "html", "sxhkdrc", "scss",},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		disable = { "html" },
		additional_vim_regex_highlighting = false,
	},
}
