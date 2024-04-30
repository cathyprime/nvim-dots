local on = true
local root_names = {
    "build.sbt",
    "Cargo.toml",
    ".git",
    "go.mod",
    "gradlew",
    "lua",
    "Makefile",
    "package.json",
    "%.csproj$"
}

local disabled_filetype = {
    "help",
}

local function isBanned(ft)
    if ft == "" then return true end
    return vim.iter(disabled_filetype):any(function(v)
        return v == ft
    end)
end

local function set_root()
    if isBanned(vim.o.filetype) then return end
    if not on then return end
    local path = vim.api.nvim_buf_get_name(0)
    if path == "" then return end

    local root = vim.fs.root(0, function(name)
        return vim.iter(root_names):any(function(value)
            return value == name or name:match('%.csproj$')
        end)
    end)

    local old = vim.fn.getcwd()
    if old ~= root and root ~= "." and root ~= "/" and root ~= nil then
        vim.notify(string.format("cwd: %s", root), vim.log.levels.INFO)
        vim.fn.chdir(root)
    end
end

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("rooter", {}),
    callback = set_root,
})

vim.api.nvim_create_user_command(
    "Rooter",
    function(opts)
        if opts.args == "" then
            on = not on
            if on then
                vim.notify("Rooter: on", vim.log.levels.INFO)
            else
                vim.notify("Rooter: off", vim.log.levels.INFO)
            end
        else
            if opts.args == "enable" then
                on = true
                vim.notify("Rooter: on", vim.log.levels.INFO)
            elseif opts.args == "disable" then
                on = false
                vim.notify("Rooter: off", vim.log.levels.INFO)
            else
                vim.notify("Rooter: unknown command", vim.log.levels.ERROR)
            end
        end
    end,
    {
        nargs = "*",
        complete = function(arg_lead)
            return vim.iter({ "enable", "disable" }):filter(function(el)
                return el:lower():match("^" .. arg_lead)
            end):totable()
        end
    }
)
