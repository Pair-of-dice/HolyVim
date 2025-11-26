--Debugger{{{
local dap = require("dap")

dap.adapters.coreclr = {
	type = "executable",
	command = "/home/paradise/.local/share/nvim/mason/bin/netcoredbg",
	args = { "--interpreter=vscode" },
}
dap.configurations.cs = {
	{
		type = "coreclr",
		name = "launch - netcoredbg",
		request = "launch",
		csexec = ("/usr/bin/dotnet run" .. vim.fn.getcwd()),
		program = function()
			return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
		end,
	},
}
--}}}
--Dotnet and csharp keybinds and commands{{{
vim.api.nvim_create_user_command("Dotnetrun", function()
	vim.cmd("w")
	vim.cmd("split")
	vim.cmd("terminal dotnet run")
end, { desc = "Run the current Dotnet project" })
vim.api.nvim_create_user_command("CsharpTemplate", function()
	vim.cmd("read ~/.config/nvim/misc/template.cs")
end, { desc = "Add Csharp boilerplate" })

vim.keymap.set({ "n" }, "<leader>lr", function()
	vim.cmd("STerm dotnet run")
end, { desc = "Dotnet Run" })
vim.keymap.set({ "n" }, "<leader>lt", function()
	vim.cmd("CsharpTemplate")
end, { desc = "Auto-boilerplate" })
vim.keymap.set({ "n" }, "<leader>lf", function()
	vim.cmd("Roslyn restart")
end,{ desc = "Restart Roslyn" })
--}}}
