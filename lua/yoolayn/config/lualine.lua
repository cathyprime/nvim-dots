local config = {}


local mode = {
	colors = {
		["normal"] = { bg = "#571cbd", fg = "#c8c093" },
		["visual"] = { bg = "#76946a", fg = "#181818" },
		["vislin"] = { bg = "#ad410e", fg = "#c8c093" },
		["visblk"] = { bg = "#181818", fg = "#80a0ff" },
		["oppend"] = { bg = "#e6c384", fg = "#181818" },
		["select"] = { bg = "#80a0ff", fg = "#003366" },
		["sellin"] = { bg = "#80a0ff", fg = "#003366" },
		["selblk"] = { bg = "#80a0ff", fg = "#003366" },
		["insert"] = { bg = "#7e9cd8", fg = "#181818" },
		["replce"] = { bg = "#ce0406", fg = "#181818" },
		["replin"] = { bg = "#ce0406", fg = "#181818" },
		["cmmand"] = { bg = "#ffa066", fg = "#181818" },
		["termnl"] = { bg = "#181818", fg = "#e6c384" },
		["confrm"] = { bg = "#571cbd", fg = "#c8c093" },
		["unknwn"] = { bg = "black", fg = "white" },
	},
	modes = {
		["n"] = "normal",
		["niI"] = "normal",
		["niR"] = "normal",
		["niV"] = "normal",
		["nt"] = "normal",
		["ntT"] = "normal",
		["v"] = "visual",
		["vs"] = "visual",
		["V"] = "vislin",
		["Vs"] = "vislin",
		[""] = "visblk",
		["s"] = "visblk",
		["no"] = "oppend",
		["nov"] = "oppend",
		["noV"] = "oppend",
		["no"] = "oppend",
		["s"] = "select",
		["S"] = "sellin",
		[""] = "selblk",
		["i"] = "insert",
		["ic"] = "insert",
		["ix"] = "insert",
		["R"] = "replce",
		["Rc"] = "replce",
		["Rx"] = "replce",
		["r"] = "replce",
		["Rv"] = "replin",
		["Rvc"] = "replin",
		["Rvx"] = "replin",
		["c"] = "cmmand",
		["cv"] = "cmmand",
		["ce"] = "cmmand",
		["t"] = "termnl",
		["r?"] = "confrm",
		["default"] = "unknwn",
	},
	name = {
		["normal"] = "[ Normal ]",
		["visual"] = "[ Visual ]",
		["vislin"] = "[ VisLin ]",
		["visblk"] = "[ VisBlk ]",
		["oppend"] = "[ OpPend ]",
		["select"] = "--Select--",
		["sellin"] = "--SelLin--",
		["selblk"] = "--SelBlk--",
		["insert"] = "--Insert--",
		["replce"] = "--Replce--",
		["replin"] = "--RepLin--",
		["cmmand"] = "--Cmmand--",
		["termnl"] = "--Termnl--",
		["confrm"] = "--Confrm--",
		["unknwn"] = "--[????]--",
	},
}

local function mode_component()
	local mode_name = mode.modes[vim.fn.mode()]
	local mode_str = mode.name[mode_name]
	return mode_str
end

config = {
	options = {
		icons_enabled = false,
		theme = "auto",
		component_separators = "",
		section_separators = "",
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = {
			"mode"
			-- {
			-- 	mode_component,
			-- 	color = function()
			-- 		local mode_name = mode.modes[vim.fn.mode()]
			-- 		return mode.colors[mode_name]
			-- 	end,
			-- }
		},
		lualine_b = {"branch", "diff", "diagnostics"},
		lualine_c = {"filename"},
		lualine_x = {"encoding", "fileformat", "filetype"},
		lualine_y = {"progress"},
		lualine_z = {"location"}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {"filename"},
		lualine_x = {"location"},
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}

return config