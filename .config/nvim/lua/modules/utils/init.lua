vim.api.nvim_create_user_command('HelpAutosplit',
    function(opts)
        local arg = opts.fargs[1] and opts.fargs[1] or ""
        local ok
        if vim.fn.winwidth('%') > 100 then
            ok = pcall(function() vim.cmd([[vertical help ]] .. arg) end)
        else
            ok = pcall(function() vim.cmd([[help ]] .. arg) end)
        end
        if not ok then
            print("No help for " .. opts.fargs[1])
        end
    end, { nargs = "?", complete = "help" })
vim.cmd 'cnoreabbrev h HelpAutosplit'
