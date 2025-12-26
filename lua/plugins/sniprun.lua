return {
	"michaelb/sniprun",
	command = {
		"SnipRun",
		"SnipInfo",
		"SnipClose",
		"SnipReset",
		"SnipReplMemoryClean",
	},
	branch = "master",

	build = "sh install.sh",
	-- do 'sh install.sh 1' if you want to force compile locally
	-- (instead of fetching a binary from the github release). Requires Rust >= 1.65

	init = function()
		require("sniprun").setup()
	end,
	keys ={
		{
			"<leader>sr",
			"<cmd>SnipRun<cr>",
			desc = "Sniprun",
		}
	}
}
