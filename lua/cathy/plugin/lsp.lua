return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
        "j-hui/fidget.nvim",
        {
            "zeioth/garbage-day.nvim",
            dependencies = "neovim/nvim-lspconfig",
            event = "VeryLazy",
            opts = {}
        },
    },
    config =  function()
        require("cathy.config.lsp")
        require("fidget").setup({
            progress = {
                display = {
                    progress_icon = {
                        pattern = "moon",
                        period = 1,
                    },
                },
            },
            notification = {
                window = {
                    winblend = 0,
                    max_width = 90,
                },
            }
        })
    end,
    event = "VeryLazy",
}
