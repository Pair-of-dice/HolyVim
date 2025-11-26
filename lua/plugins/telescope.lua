return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		-- Telescope config and setup{{{

		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		telescope.setup({
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
			extensions = {},
		})
		vim.keymap.set({ "i", "n" }, "<C-f>", function()
			vim.cmd("Telescope find_files")
		end)
		vim.keymap.set("n", "<leader>tf", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>tg", builtin.live_grep, { desc = "Telescope live grep" })
		vim.keymap.set("n", "<leader>tb", builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set("n", "<leader>th", builtin.help_tags, { desc = "Telescope help tags" })
		--}}}
	end,
}
