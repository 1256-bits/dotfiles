vim.api.nvim_create_user_command('HelpAutosplit',
    function(opts)
        if vim.fn.winwidth('%') > vim.fn.winheight('%') then
            vim.cmd([[vertical help ]] .. opts.fargs[1])
        else
            vim.cmd([[help ]] .. opts.fargs[1])
        end
    end, { nargs = 1, complete = "help" })
vim.cmd'cnoreabbrev h HelpAutosplit'
