local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pg', function()
	if pcall(builtin.git_files) then
		return
	end
		print("Not in git")
end)
vim.keymap.set('n', '<leader>ps', function()
	local searchterm = vim.fn.input("Grep >")
	if searchterm == "" then
		return
	end
	builtin.grep_string({ search = searchterm });
end)
