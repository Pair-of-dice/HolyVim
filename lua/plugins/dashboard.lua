local logo = [[
:::    :::  ::::::::  :::     :::   :::  
:+:    :+: :+:    :+: :+:     :+:   :+:  
+:+    +:+ +:+    +:+ +:+      +:+ +:+   
+#++:++#++ +#+    +:+ +#+       +#++:    
+#+    +#+ +#+    +#+ +#+        +#+     
#+#    #+# #+#    #+# #+#        #+#     
###    ###  ########  ########## ###     
:::     ::: ::::::::::: ::::    ::::  :::
:+:     :+:     :+:     +:+:+: :+:+:+ :+:
+:+     +:+     +:+     +:+ +:+:+ +:+ +:+
+#+     +:+     +#+     +#+  +:+  +#+ +#+
 +#+   +#+      +#+     +#+       +#+ +#+
  #+#+#+#       #+#     #+#       #+#    
    ###     ########### ###       ### ###

]]

logo = string.rep("\n", 2) .. logo .. "\n\n"

return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#BD0042" })
		require("dashboard").setup({
			theme = "hyper", -- theme is doom and hyper default is hyper
			disable_move = false, -- default is false disable move keymap for hyper
			shortcut_type = "number", -- shortcut type 'letter' or 'number'
			shuffle_letter = false, -- default is false, shortcut 'letter' will be randomize, set to false to have ordered letter
			--letter_list,    -- default is a-z, excluding j and k
			change_to_vcs_root = false, -- default is false,for open file in hyper mru. it will change to the root of vcs
			config = { --config for theme
				header = vim.split(logo, "\n"),
				shortcut = {
					{
						icon = " ",
						icon_hl = "@variable",
						desc = "Update",
						group = "DiffText",
						action = "Lazy update",
						key = "u",
					},
					{
						icon = " ",
						icon_hl = "@DiffText",
						desc = "Files",
						group = "DiffText",
						action = "Telescope find_files",
						key = "f",
					},
				},
			},
			hide = {
				statusline = true, -- hide statusline default is true
				tabline = true, -- hide the tabline
				winbar = true, -- hide winbar
			},
			preview = {
				--command = "bat",
				--file_path,-- preview file path
				--file_height,-- preview file height
				--file_width,-- preview file width
			},
			footer = { "Welcome to Holy Vim!" },
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
