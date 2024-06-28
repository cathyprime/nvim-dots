local function map(lhs, rhs)
    vim.keymap.set("n", "<leader>h" .. lhs, rhs)
end
local track = require("track")
map("a", track.toggle_label)
map("c", track.clear_labels)
map("e", track.edit_label)
vim.keymap.set("n", "<leader>fa", track.search_labels, { desc = "annotations" })

return {
    {
        "rktjmp/playtime.nvim",
        cmd = "Playtime"
    },
    {
        "jbyuki/venn.nvim",
        keys = {
            { "<leader>v" }
        },
        config = function()
            local hint = [[
  Arrow^^^^^^
  ^ ^ _K_ ^ ^   Select region with <C-v>  ^
  _H_ ^ ^ _L_   _f_: surround it with box
  ^ ^ _J_ ^ ^                      _<Esc>_
]]

            require("hydra")({
                name = "venn",
                mode = "n",
                hint = hint,
                config = {
                    color = "pink",
                    invoke_on_body = true,
                    hint = {
                        float_opts = {
                            border = "rounded",
                        }
                    },
                    on_enter = function()
                        vim.opt_local.virtualedit = "all"
                    end,
                    on_exit = function()
                        vim.opt_local.virtualedit = ""
                    end
                },
                body = "<leader>v",
                heads = {
                    { "H",     "<C-v>h:VBox<CR>" },
                    { "J",     "<C-v>j:VBox<CR>" },
                    { "K",     "<C-v>k:VBox<CR>" },
                    { "L",     "<C-v>l:VBox<CR>" },
                    { "f",     ":VBox<CR>",      { mode = "v" } },
                    { "<Esc>", nil,              { exit = true } },
                }
            })
        end
    },
    {
        "Eandrju/cellular-automaton.nvim",
        cmd = "CellularAutomaton"
    },
    {
        "folke/trouble.nvim",
        config = true,
        keys = {
            { "ZX", "<cmd>Trouble diagnostics filter.buf=0<cr>", { silent = true } },
            { "<leader>x", "<cmd>Trouble<cr>", { silent = true } }
        }
    },
    {
        "mbbill/undotree",
        config = function()
            vim.g.undotree_WindowLayout = 2
            vim.g.undotree_ShortIndicators = 0
            vim.g.undotree_SplitWidth = 40
            vim.g.undotree_SetFocusWhenToggle = 1
            vim.g.undotree_DiffCommand = [[diff]]
        end,
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>" }
        }
    },
    {
        "dohsimpson/vim-macroeditor",
        cmd = "MacroEdit"
    },
    {
        "kevinhwang91/nvim-fundo",
        dependencies = {
            "kevinhwang91/promise-async"
        },
        config = function()
            require("fundo").install()
        end
    },
    {
        "Vigemus/iron.nvim",
        config = function()
            require("iron.core").setup({
                config = {
                    repl_open_cmd = "vertical botright 70 split",
                    repl_definition = {
                        sh = {
                            command = { "zsh" },
                        },
                    },
                },
                keymaps = {
                    send_motion = "<localleader>",
                    visual_send = "<localleader>",
                    send_file = "<localleader>f",
                    send_line = "<localleader><localleader>",
                    cr = "<localleader><cr>",
                    interrupt = "<localleader><c-c>",
                    exit = "<localleader><c-d>",
                    clear = "<localleader><c-l>",
                    send_mark = "<localleader>mm",
                    mark_motion = "<localleader>m",
                    mark_visual = "<localleader>m",
                    remove_mark = "<localleader>md",
                },
            })
        end,
        keys = {
            { "<leader>is", "<cmd>IronRepl<cr>" },
            { "<leader>ih", "<cmd>IronHide<cr>" },
            { "<leader>if", "<cmd>IronWatch file<cr>" },
            { "<leader>im", "<cmd>IronWatch mark<cr>" }
        }
    },
    "milisims/nvim-luaref",
    {
        "folke/zen-mode.nvim",
        dependencies = {
            "folke/twilight.nvim",
        },
        cmd = "ZenMode",
        config = function()
            require("zen-mode").setup({
                plugins = {
                    options = {
                        enabled = true,
                        ruler = false,
                        showcmd = false,
                        laststatus = 0,
                    },
                    twilight = { enabled = true },
                    gitsigns = { enabled = true },
                    wezterm = {
                        enabled = true,
                        font = 4,
                    },
                },
                on_open = function()
                    vim.opt.fillchars = [[foldclose:>,foldopen:v,foldsep: ,fold: ]]
                end
            })
        end
    },
    {
        "chrishrb/gx.nvim",
        keys = {
            { "gX", "<cmd>Browse<cr>" }
        }
    },
    {
        "cbochs/grapple.nvim",
        config = function()
            require("grapple").setup({
                scope = "git_branch",
            })
            vim.api.nvim_del_user_command("Grapple")
        end,
        keys = function()
            local grapple = require("grapple")
            return {
                { "<leader>a", grapple.toggle },
                { "<leader>e", grapple.toggle_tags },
                { "<c-f>", function() grapple.select({ index = 1 }) end },
                { "<c-s>", function() grapple.select({ index = 2 }) end },
                { "<c-n>", function() grapple.select({ index = 3 }) end },
                { "<c-s-a>", function() grapple.cycle_scopes("next") end },
                { "<c-s-x>", function() grapple.cycle_scopes("prev") end },
                { "<c-s-f>", function() grapple.cycle_tags("next") end },
                { "<c-s-s>", function() grapple.cycle_tags("prev") end }
            }
        end
    },
    {
        "mistricky/codesnap.nvim",
        build = "make",
        cmd = {
            "CodeSnap",
            "CodeSnapSave",
            "CodeSnapHighlight",
            "CodeSnapSaveHighlight",
        },
        config = function()
            require("codesnap").setup({
                has_breadcrumbs = true,
                save_path = os.getenv("HOME") .. "/Pictures/",
                watermark = ""
            })
        end
    },
    {
        "willothy/flatten.nvim",
        config = true,
        lazy = false,
        priority = 1001,
    },
}
