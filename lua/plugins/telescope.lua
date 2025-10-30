return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		-- Telescope config and setup{{{

		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				-- ...
			},
			pickers = {
				find_files = {
					theme = "ivy",
					hidden = "true",
				},
			},
			extensions = {
				-- ...
			},
		})
		--}}}
	end,
}
