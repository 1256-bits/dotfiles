local languages = require("efmls-configs.defaults").languages()
local shfmt = require("efmls-configs.formatters.shfmt")
languages = vim.tbl_extend("force", languages, {
	sh = { shfmt },
	python = {},
	fennel = {
		{ formatCommand = "fnlfmt -", formatStdin = true },
	},
})

local efmls_config = {
	filetypes = vim.tbl_keys(languages),
	settings = {
		rootMarkers = { ".git/" },
		languages = languages,
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
	},
}

require("lspconfig").efm.setup(vim.tbl_extend("force", efmls_config, {
	-- Pass your custom lsp config below like on_attach and capabilities
	--
	-- on_attach = on_attach,
	-- capabilities = capabilities,
}))
