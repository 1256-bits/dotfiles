local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  "mbbill/undotree",
  "hrsh7th/cmp-path",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-buffer",
  "EdenEast/nightfox.nvim",
  "dstein64/vim-startuptime",
  "mattn/efm-langserver",
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "nvim-treesitter/nvim-treesitter-textobjects",
  {
    "kovetskiy/sxhkd-vim",
    cond = vim.fs.basename(vim.api.nvim_buf_get_name(0)),
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  {
    "mfussenegger/nvim-dap",
    lazy = true,
  },
  {
    "ThePrimeagen/harpoon",
    lazy = true,
  },
  {
    "shaunsingh/nord.nvim",
    lazy = true,
  },
  {
    "LhKipp/nvim-nu",
    lazy = true,
  },
  {
    "nvim-neotest/nvim-nio",
    lazy = true,
  },
  {
    "ishan9299/modus-theme-vim",
    lazy = true,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    lazy = true,
  },
  {
    "mcchrish/zenbones.nvim",
    lazy = true,
    dependencies = { "rktjmp/lush.nvim" },
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
    lazy = true,
  },
  --[[{
    "microsoft/vscode-js-debug",
    build = "sh -c 'npm install && npx gulp vsDebugServerBundle && mv dist out'",
    lazy = true,
  },]]
  {
    "creativenull/efmls-configs-nvim",
    version = "v1.x.x", -- version is optional, but recommended
    dependencies = { "neovim/nvim-lspconfig" },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      {
        -- Optional
        "williamboman/mason.nvim",
        build = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },  -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "L3MON4D3/LuaSnip" },  -- Required
    },
  },
}

local opts = {}

require("lazy").setup(plugins, opts)
