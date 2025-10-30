vim.api.nvim_create_user_command("Pyrun", function()
	local filename = vim.api.nvim_buf_get_name(0)
	vim.cmd("w")
	print(vim.fn.system({ "python", filename }))
end, { desc = "Run the current Python buffer" })

vim.keymap.set({ "n" }, "<leader>pr", function()
	vim.cmd("Pyrun")
end, { desc = "Python Run" })
