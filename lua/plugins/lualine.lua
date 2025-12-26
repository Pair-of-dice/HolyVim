return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	priority = 1000,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		--Setup Lualine.lua{{{
		require("lualine").setup({
			options = { theme = "alienocean" },
		})
		--}}}
	end,
}
