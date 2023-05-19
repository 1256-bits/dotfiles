vim.api.nvim_create_user_command('HelpAutosplit',
    function(opts)
        local err
        if vim.fn.winwidth('%') > vim.fn.winheight('%') then
            err = pcall(function() vim.cmd([[vertical help ]] .. opts.fargs[1]) end)
        else
            err = pcall(function() vim.cmd([[help ]] .. opts.fargs[1]) end)
        end
        if not err then
            print("No help for " .. opts.fargs[1])
        end
    end, { nargs = 1, complete = "help" })
vim.cmd 'cnoreabbrev h HelpAutosplit'
