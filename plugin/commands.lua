vim.api.nvim_create_user_command(
	"Messages",
	"let output = [] | redir => output | silent messages | redir END | cexpr output",
	{}
)
vim.api.nvim_create_user_command(
	"Scratch",
	function(opts)
		if not opts.bang then
			vim.cmd(opts.mods .. " split")
		end
		vim.cmd"enew"
		vim.api.nvim_set_option_value("buftype", "nofile", { buf = 0 })
		vim.api.nvim_set_option_value("bufhidden", "hide", { buf = 0 })
		vim.api.nvim_set_option_value("swapfile", false, { buf = 0 })
	end,
	{ bang = true }
)

local status = true

vim.api.nvim_create_user_command(
	"Presentation",
	function()
		if status then
			vim.opt_global.laststatus = 0
			vim.opt_global.cmdheight = 0
			vim.fn.system("tmux set -g status off")
			status = false
		else
			vim.opt_global.laststatus = 3
			vim.opt_global.cmdheight = 1
			vim.fn.system("tmux set -g status on")
			status = true
		end
	end,
	{ nargs = 0 }
)
