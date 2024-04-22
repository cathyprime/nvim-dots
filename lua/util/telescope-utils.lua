local builtin = require "telescope.builtin"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local state   = require "telescope.actions.state"
local actions = require "telescope.actions"
local config  = require "util.telescope-config"

local M = {}

local is_inside_work_tree = {}

M.project_files = function()
    local opts = {
        file_ignore_patterns = config.ignores
    }

    local cwd = vim.fn.getcwd()
    if is_inside_work_tree[cwd] == nil then
        vim.fn.system("git rev-parse --is-inside-work-tree")
        is_inside_work_tree[cwd] = vim.v.shell_error == 0
    end

    if is_inside_work_tree[cwd] then
        builtin.git_files()
    else
        builtin.find_files(opts)
    end
end

M.change_dir = function()
    local function enter(prompt_bufnr)
        local selected = state.get_selected_entry()
        actions.close(prompt_bufnr)
        require("telescope.builtin").find_files({
            cwd = selected[1],
            hidden = true,
            file_ignore_patterns = config.ignores,
        })
    end

    local input = {
        os.getenv("SHELL"),
        "-C",
        os.getenv("HOME") .. "/.config/wezterm/workspace.sh"
    }

    local opts = {
        finder = finders.new_oneshot_job(input, {}),
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = function(prompt_bufnr, map)
            map("i", "<cr>", function()
                enter(prompt_bufnr)
            end)
            return true
        end
    }

    local picker = pickers.new({}, opts)
    picker:find()
end

M.get_nvim = function()
    builtin.find_files({
        cwd = "~/.config/nvim"
    })
end

M.hidden = function()
    require("telescope.builtin").find_files({
        file_ignore_patterns = config.ignores,
        hidden = true,
    })
end

return M
