return {
	"xero/evangelion.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		overrides = {
			Normal = { fg = "#E1D6F8", bg = "#00001a" },
			TelescopePromptNormal = { bg = "#610044" },
			LineNr = { fg = "#000018", bg = "#610044" },
			TelescopeNormal = {bg = "#00001a"},
			Comment = {fg = "#3e0000", bg = "#39274D"},
		},
	},
	init = function()
		vim.cmd.colorscheme("evangelion")
	end,
}
