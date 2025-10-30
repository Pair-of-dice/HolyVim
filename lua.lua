vim.api.nvim_create_user_command("Luarun", function()
	local filename = vim.api.nvim_buf_get_name(0)
	vim.cmd("w")
	print(vim.fn.system({ "lua", filename }))
end, { desc = "Run the current Lua buffer" })

vim.keymap.set({ "n" }, "<leader>lle", function()
	vim.cmd("Luarun")
end, { desc = "Lua Run" })
