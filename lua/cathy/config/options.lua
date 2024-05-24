local options = {}

options.options = {
    rnu = true,
    nu = true,
    cpo = {
        append = {
            ">"
        }
    },
    spell = true,
    spl = "en_us,en_gb,pl",
    tabstop = 4,
    shiftwidth = 4,
    smartindent = false,
    autoindent = false,
    background = "dark",
    expandtab = true,
    exrc = true,
    list = true,
    listchars = {
        append = {
            [[trail:-]],
            [[tab:\u00b7\u0020\u0020]],
            [[precedes:\u2190]],
            [[extends:\u2192]],
            [[leadmultispace:\u00b7]],
            [[nbsp:\u2423]],
        },
    },
    fillchars = {
        append = {
            [[foldclose:>]],
            [[foldopen:v]],
            [[foldsep: ]],
            [[fold: ]],
        },
    },
    linebreak = true,
    showbreak = "-> ",
    path = ".,**",
    ignorecase = true,
    smartcase = true,
    incsearch = true,
    foldlevel = 20,
    formatoptions = {
        remove = {
            "l"
        }
    },
    -- foldexpr = [[getline(v:lnum)=~'^\s*$'?'0':'1']],
    foldexpr = [[v:lua.vim.treesitter.foldexpr()]],
    foldtext = "",
    foldmethod = "expr",
    foldcolumn = "4",
    foldnestmax = 4,
    hls = true,
    cursorline = true,
    guicursor = "i-ci-ve:block",
    showcmdloc = "statusline",
    showtabline = 1,
    scrolloff = 8,
    termguicolors = true,
    signcolumn = "yes",
    inccommand = "split",
    splitright = true,
    splitbelow = true,
    splitkeep = "screen",
    timeout = false,
    updatetime = 500,
    swapfile = true,
    dir = os.getenv("HOME") .. "/.local/state/nvim/swap",
    writebackup = false,
    shortmess = {
        append = "c",
    },
    showmode = false,
    laststatus = 2,
    undofile = true,
    undodir = os.getenv("HOME") .. "/.config/nvim/undo",
    wildmode = "longest:full,full",
    winminwidth = 5,
    pumheight = 4,
    wrap = true,
    indentkeys = {
        remove = ":,<>>"
    }
}

options.prg = {
    grep = "rg --vimgrep --no-heading --smart-case",
}

options.globals = {
    markdown_recommended_style = 0,
}

local function set_option(name, opts)
    local obj = vim.opt[name]
    for func, value in pairs(opts) do
        if type(value) ~= "table" then
            obj[func](obj, value)
        else
            for _, atom in ipairs(value) do
                obj[func](obj, atom)
            end
        end
    end
end

for key, value in pairs(options.prg) do
    key = key .. "prg"
    vim.opt[key] = value
end

for key, value in pairs(options.globals) do
    vim.g[key] = value
end

for key, value in pairs(options.options) do
    if type(value) ~= "table" then
        vim.opt[key] = value
    else
        set_option(key, value)
    end
end

-- neovide only
if vim.g.neovide then
    if vim.fn.hostname() == "luna" then
        vim.opt.guifont = "JetBrainsMono NFM:h14.8"
    elseif vim.fn.hostname() == "juno" then
        vim.opt.guifont = "JetBrainsMono NFM:h16.8"
    else
        vim.opt.guifont = "JetBrainsMono NFM:h14"
    end
    vim.opt.guifont = "JetBrainsMono NFM:h14.8"
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_refresh_rate = 144
    -- vim.g.neovide_transparency = 0.9
    vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.g.neovide_fullscreen = true
end
