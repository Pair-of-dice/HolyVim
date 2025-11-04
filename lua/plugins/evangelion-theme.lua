return {
	"xero/evangelion.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		overrides = {
			Normal = { fg = "#E1D6F8", bg = "#00001a" },
		},
	},
	init = function()
		vim.cmd.colorscheme("evangelion")
	end,
}
