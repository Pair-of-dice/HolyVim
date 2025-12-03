return {
	"romus204/referencer.nvim",
	cmd = {
		"ReferencerToggle",
		"ReferencerUpdate",
	},
	config = function()
		require("referencer").setup()
	end,
}
