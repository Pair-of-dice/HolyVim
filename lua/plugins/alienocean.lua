return {
	"Pair-of-dice/Alienocean.nvim",
	dependencies = {
		"Pair-of-dice/Alienocean-lualine", --lualine theme
	},
	init = function()
		vim.cmd.colorscheme("Alienocean") --Sets the colourscheme to Alienocean on load
	end,
}
