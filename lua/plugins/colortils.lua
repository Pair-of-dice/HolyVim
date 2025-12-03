return {
	"max397574/colortils.nvim",
	cmd = "Colortils",
	config = function()
		require("colortils").setup()
		vim.keymap.set("n", "<leader>ct", function()
			vim.cmd("Colortils")
		end, { desc = "color utils" })
	end,
}
