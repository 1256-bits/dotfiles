require("modules.remaps")
require("modules.lazy")
require("modules.utils.init")

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true
vim.opt.ignorecase = true
--vim.opt.clipboard = "unnamedplus"

vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir/"
vim.opt.undofile = true

vim.opt.scrolloff = 8
vim.opt.incsearch = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.cmd.highlight({ "ColorColumn", "ctermbg=8" })
vim.opt.termguicolors = true
vim.cmd.colorscheme("nordfox")
vim.cmd.highlight({ "signcolumn", "guibg=dimgray" })
vim.opt.splitright = true

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.ejs" },
  callback = function ()
      vim.cmd.setfiletype('html')
  end
})
