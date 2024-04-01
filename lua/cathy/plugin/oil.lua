require("mini.deps").add({
    source = "stevearc/oil.nvim",
    depends = {
        "nvim-tree/nvim-web-devicons"
    }
})
require("mini.deps").later(function()
    require("oil").setup({
        default_file_explorer = true,
        columns = {
            "permissions",
            "size",
            "mtime",
            "icon",
        },
    })
    vim.keymap.set("n", "-", "<cmd>Oil<cr>")
end)
