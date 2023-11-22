vim.g.mapleader = " "
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<Leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<Leader>/", function()
  vim.cmd.let("@/=''")
end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>f", function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      if vim.bo.filetype == "typescript" or vim.bo.filetype == "javascript" then
        return client.name == "efm"
      else
        return true
      end
    end,
    bufnr = bufnr,
  })
end)

vim.keymap.set("n", "<leader>s", [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)

vim.keymap.set("n", "<leader>w", "<C-W>")

vim.keymap.set({ "n", "v" }, "<leader>gg", function()
  vim.cmd("G push")
end)
