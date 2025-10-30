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
		csexec = ("/usr/bin/dotnet run"..vim.fn.getcwd()),
		program = function()
			return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
		end,
	},
}
