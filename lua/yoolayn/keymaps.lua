-- local Utils = require("yoolayn.utils")

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ef", vim.cmd.Ex, {desc = "explore files"})

-- disable scroll full page
vim.keymap.set("n", "<C-b>", "<Nop>")
vim.keymap.set("n", "<C-f>", "<Nop>")

-- move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move line up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "join lines" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "scroll up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "next search" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "prev search" })

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "replace and don't save" })

-- stylua: ignore start
vim.keymap.set({ "o", "x" }, "il", ":<c-u>normal! _vg_<cr>", { desc = "inner line", silent = true })
vim.keymap.set({ "o", "x" }, "al", ":<c-u>normal! 0v$<cr>", { desc = "around line", silent = true })

-- stylua: ignore
vim.keymap.set( { "n", "v" }, "<leader>y", [["+y]], { desc = "yank to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>p", [["+p]], { desc = "paste from clipboard" })
vim.keymap.set("n", "<leader>P", [["+P]], { desc = "Paste from clipboard" })

-- style: ignore
vim.keymap.set( { "n", "v" }, "<leader>d", [["_d]], { desc = "delete to black hole" })

vim.keymap.set(
    "n",
    "<leader>s",
    [[:s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>]],
    { desc = "replace inline instances under cursor" }
)
vim.keymap.set(
    "n",
    "<leader>S",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]],
    { desc = "replace all instances under cursor" }
)
