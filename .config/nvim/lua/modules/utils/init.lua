vim.api.nvim_create_user_command('HelpAutosplit',
    function(opts)
        local ok
        if vim.fn.winwidth('%') > 100 then
            ok = pcall(function() vim.cmd([[vertical help ]] .. opts.fargs[1]) end)
        else
            ok = pcall(function() vim.cmd([[help ]] .. opts.fargs[1]) end)
        end
        if not ok then
            print("No help for " .. opts.fargs[1])
        end
    end, { nargs = 1, complete = "help" })
vim.cmd 'cnoreabbrev h HelpAutosplit'
