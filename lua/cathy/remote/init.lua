local utils = require("cathy.remote.utils")
vim.g.remote_connected_hostname = nil
vim.g.remote_path = nil

vim.api.nvim_create_user_command("Remote",
    function (opts)
        local connect = function (hostname, path)
            local on_connect = function ()
                local path = utils.get_path(hostname)
                vim.cmd.cd(path)
                vim.cmd("e " .. path)
            end

            utils.connect(hostname, path, vim.schedule_wrap(on_connect))
        end

        if #opts.fargs >= 1 then
            local arg_funcs = {
                connect = function ()
                    if vim.g.remote_connected_hostname then
                        vim.notify("Already connected, can't connect again", vim.log.levels.ERROR)
                        return
                    end
                    if not opts.fargs[2] then
                        utils.choose_host(connect)
                        return
                    end
                    connect(opts.fargs[2], opts.fargs[3])
                end,
                disconnect = function ()
                    if not vim.g.remote_connected_hostname then
                        vim.notify("Not connected; can't disconnect", vim.log.levels.ERROR)
                        return
                    end
                    utils.disconnect(vim.g.remote_connected_hostname)
                end,
                cd = function ()
                    if not vim.g.remote_connected_hostname then
                        vim.notify("Not connected; can't cd", vim.log.levels.ERROR)
                        return
                    end
                    local hostname = vim.g.remote_connected_hostname
                    utils.disconnect(hostname, vim.schedule_wrap(function ()
                        connect(hostname, opts.fargs[2])
                    end))
                end
            }
            local func = arg_funcs[opts.fargs[1]]
            if not func then
                vim.notify(opts.args .. " are not a valid arguments", vim.log.levels.ERROR)
                return
            end
            func()
            return
        end

        if vim.g.remote_connected_hostname and utils.is_mounted(vim.g.remote_connected_hostname) then
            utils.disconnect(vim.g.remote_connected_hostname)
            return
        end

        utils.choose_host(connect)
    end,
    {
        force = true,
        nargs = "*",
        complete = function(arg_lead, cmdline)
            if cmdline:match("connect%s+%S+") or
                cmdline:match("disconnect%s*$") or
                cmdline:match("cd%s*$") then
                return {}
            end

            if cmdline:match("connect%s+") then
                return utils.get_hosts()
            end

            local options = {}
            if vim.g.remote_connected_hostname then
                table.insert(options, "disconnect")
                table.insert(options, "cd")
            else
                table.insert(options, "connect")
            end

            if arg_lead and #arg_lead > 0 then
                local filtered = {}
                for _, option in ipairs(options) do
                    if option:sub(1, #arg_lead) == arg_lead then
                        table.insert(filtered, option)
                    end
                end
                return filtered
            end

            return options
        end
    }
)
