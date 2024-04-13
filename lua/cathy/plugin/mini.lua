local now   = require("mini.deps").now
local later = require("mini.deps").later

now(function()
    local config = require("cathy.config.ministarter")
    require("mini.starter").setup(config)
end)

later(function()

    require("mini.indentscope").setup({
        symbol = "",
    })
    vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("CathyIndentScope", { clear = true }),
        callback = function()
            if vim.opt.shiftwidth:get() == 2 and vim.opt.tabstop:get() == 2 then
                vim.b.miniindentscope_config = {
                    symbol = "│"
                }
            end
        end
    })

    require("mini.align").setup({
        mappings = {
            start = "",
            start_with_preview = "ga",
        },
    })

    require("mini.operators").setup({
        sort = {
            prefix = "",
            func = nil,
        }
    })

    require("mini.comment").setup({
        options = {
            custom_commentstring = function()
                return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
            end,
        },
    })

    require("mini.trailspace").setup()

    require("mini.move").setup({
        mappings = {
            left       = "<m-h>",
            right      = "<m-l>",
            down       = "<m-j>",
            up         = "<m-k>",
            line_left  = "",
            line_right = "",
            line_down  = "<m-j>",
            line_up    = "<m-k>",
        }
    })

    local clue = require("mini.clue")
    clue.setup({
        triggers = {
            { mode = "n", keys = "<leader>z" },
            { mode = "n", keys = "<leader>m" },
            { mode = "n", keys = "<c-w>" },
            { mode = "i", keys = "<c-x>" },
            { mode = "n", keys = "z" },
        },
        clues = {
            { mode = "n", keys = "<leader>zB" },
            { mode = "n", keys = "<leader>z<cr>", postkeys = "<leader>z" },
            { mode = "n", keys = "<leader>zl", postkeys = "<leader>z" },
            { mode = "n", keys = "<leader>zi", postkeys = "<leader>z" },
            { mode = "n", keys = "<leader>zo", postkeys = "<leader>z" },
            { mode = "n", keys = "<leader>zO", postkeys = "<leader>z" },
            { mode = "n", keys = "<leader>zu", postkeys = "<leader>z" },
            { mode = "n", keys = "<leader>zs", postkeys = "<leader>z" },
            { mode = "n", keys = "<leader>zc", postkeys = "<leader>z" },
            { mode = "n", keys = "<leader>zr", postkeys = "<leader>z" },
            { mode = "n", keys = "<c-w><", postkeys = "<c-w>", desc = "decrease width" },
            { mode = "n", keys = "<c-w>>", postkeys = "<c-w>", desc = "increase width" },
            { mode = "n", keys = "<c-w>-", postkeys = "<c-w>", desc = "decrease height" },
            { mode = "n", keys = "<c-w>+", postkeys = "<c-w>", desc = "increase height" },
            { mode = "n", keys = "<c-w>=", postkeys = "<c-w>", desc = "resize" },
            { mode = "n", keys = "zl", postkeys = "z", desc = "move right" },
            { mode = "n", keys = "zh", postkeys = "z", desc = "move left" },
            { mode = "n", keys = "zL", postkeys = "z", desc = "move right half a screen" },
            { mode = "n", keys = "zH", postkeys = "z", desc = "move left half a screen" },
            clue.gen_clues.builtin_completion(),
        }
    })

    require("mini.misc").setup()

    require("mini.splitjoin").setup({
        mappings = {
            toggle = "gs",
        }
    })

    local ai = require("mini.ai")
    ai.setup({
        custom_textobjects = {
            o = ai.gen_spec.treesitter({
                a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                i = { "@block.inner", "@conditional.inner", "@loop.inner" },
            }, {}),
            f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
            c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
        search_method = "cover_or_next"
    })

    require("mini.diff").setup({
        mappings = {
            apply = "",
            reset = "",
        },
        view = {
            style = "sign",
            signs = {
                add    = "┃",
                change = "┃",
                delete = "▁",
            },
        },
    })
    vim.api.nvim_set_hl(0, "MiniDiffSignAdd", {
        link = "diffAdded",
    })
    vim.api.nvim_set_hl(0, "MiniDiffSignChange", {
        link = "diffChanged",
    })
    vim.api.nvim_set_hl(0, "MiniDiffSignDelete", {
        link = "diffDeleted",
    })
    vim.keymap.set("n", "<leader>tg", function()
        pcall(MiniDiff.toggle_overlay)
    end)

    require("mini.notify").setup({
        lsp_progress = {
            enable = false
        },
    })
    vim.notify = require("mini.notify").make_notify({
        ERROR  = { duration = 5000 },
        WARN   = { duration = 4000 },
        INFO   = { duration = 3000 },
    })

end)
