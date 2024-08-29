vim.g.dispatch_handlers = {
    "terminal",
    "headless",
    "job",
}

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.api.nvim_del_user_command("Dispatch")
        vim.api.nvim_create_user_command(
            "Dispatch",
            function(opts)
                local count = 0
                local args = opts.args or ""
                local mods = opts.mods or ""
                local bang = opts.bang and 1 or 0

                if bang == 1 then
                    vim.g["dispatch_ready"] = true
                end
                if opts.count < 0 or opts.line1 == opts.line2 then
                    count = opts.count
                end
                if args == "" and vim.b.dispatch ~= "" then
                    args = vim.b.dispatch
                end
                vim.b["dispatch"] = args
                vim.fn["dispatch#compile_command"](bang, args, count, mods)
            end,
            {
                bang = true,
                nargs = "*",
                range = -1,
                complete = "customlist,dispatch#command_complete",
            }
        )
        vim.api.nvim_del_user_command("Start")
        vim.api.nvim_create_user_command(
            "Start",
            function(opts)
                local count = 0
                local args = opts.args or ""
                local mods = opts.mods or ""
                local bang = opts.bang and 1 or 0

                if opts.count < 0 or opts.line1 == opts.line2 then
                    count = opts.count
                end
                if args == "" and vim.b.start_compile ~= "" then
                    args = vim.b.start_compile or ""
                end
                vim.b["start_compile"] = args
                vim.fn["dispatch#start_command"](bang, "-wait=always "..args, count, mods)
            end,
            {
                bang = true,
                nargs = "*",
                range = -1,
                complete = "customlist,dispatch#command_complete",
            }
        )
        vim.api.nvim_del_user_command("Copen")
        vim.api.nvim_create_user_command(
            "Copen",
            function(opts)
                local bang = opts.bang and 1 or 0
                vim.g["dispatch_ready"] = false
                vim.fn["dispatch#copen"](bang, opts.mods or "")
            end,
            {
                bang = true,
                bar = true,
            }
        )
    end,
})

return {
    {
        "tpope/vim-dispatch",
        config = function()
            vim.keymap.set("n", "Zc", "<cmd>AbortDispatch<cr>", { silent = true  })
            vim.keymap.set("n", "ZC", "<cmd>AbortDispatch<cr>", { silent = true  })
            vim.keymap.set("n", "ZF", "<cmd>Focus!<cr>",        { silent = true  })
            vim.keymap.set("n", "Zf", ":Focus ",                { silent = false })
            vim.keymap.set("n", "Zm", "<cmd>Make<cr>",          { silent = true  })
            vim.keymap.set("n", "ZM", "<cmd>Make<cr>",          { silent = true  })
            vim.keymap.set("n", "Zd", "<cmd>Dispatch<cr>",      { silent = true  })
            vim.keymap.set("n", "ZD", ":Dispatch ",             { silent = false })
            vim.keymap.set("n", "ZS", ":Start ",                { silent = false })
            vim.keymap.set("n", "Zs", "<cmd>Start<cr>",         { silent = true  })
        end,
    },
}
