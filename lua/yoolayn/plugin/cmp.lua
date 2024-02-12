require("mini.deps").add({
    source = "hrsh7th/nvim-cmp",
    depends = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
    }
})

require("mini.deps").later(function()
    require("yoolayn.config.cmp")
    local colors = require("yoolayn.config.cmp-colors")
    colors.run(false)
    colors.set_autocmd()
end)
