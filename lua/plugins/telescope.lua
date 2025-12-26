return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		defaults = {
			-- ...
		},
		pickers = {
			find_files = {
				theme = "ivy",
				hidden = "true",
			},
			live_grep = {
				theme = "ivy",
				hidden = "true",
			},
		},
		extensions = {
			-- ...
		},
	},
	keys = {
		{
			"<leader>tf",
			"<cmd>Telescope find_files<cr>",
			desc = "Telescope find files",
		},
		{
			"<leader>tb",
			"<cmd>Telescope buffers<cr>",
			desc = "Telescope buffers",
		},
		{
			"<leader>tg",
			"<cmd>Telescope live_grep<cr>",
			desc = "Telescope live grep",
		},
		{
			"<leader>th",
			"<cmd>Telescope help_tags<cr>",
			desc = "Telescope help tags",
		},
	},
}
