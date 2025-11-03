return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		--Setup Lualine.lua{{{
		require("lualine").setup({
			options = { theme = "fluoromachine" },
		})
		--}}}
	end,
}
