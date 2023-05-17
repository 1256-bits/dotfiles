vim.api.nvim_create_user_command('HelpAutosplit',
    function(opts)
        if vim.fn.winwidth('%') > vim.fn.winheight('%') then
            vim.fn.execute([[vertical help ]] .. opts.fargs[1])
        else
            vim.fn.execute([[help ]] .. opts.fargs[1])
        end
    end, { nargs = 1 })
vim.cmd'cnoreabbrev h HelpAutosplit'
