--@type LazySpec
return {
	"kelly-lin/ranger.nvim",
	--{{{Ranger configuration
	config = function()
		local ranger_nvim = require("ranger-nvim")
		ranger_nvim.setup({ replace_netrw = true })
		vim.api.nvim_set_keymap("n", "<leader>r", "", {
			noremap = true,
			callback = function()
				require("ranger-nvim").open(true)
			end,
		})
		ranger_nvim.setup({
			enable_cmds = false,
			replace_netrw = false,
			keybinds = {
				["ov"] = ranger_nvim.OPEN_MODE.vsplit,
				["oh"] = ranger_nvim.OPEN_MODE.split,
				["ot"] = ranger_nvim.OPEN_MODE.nedit,
				["or"] = ranger_nvim.OPEN_MODE.rifle,
			},
			ui = {
				border = "none",
				height = 1,
				width = 1,
				x = 0.5,
				y = 0.5,
			},
		})
		--}}}
	end,
}
