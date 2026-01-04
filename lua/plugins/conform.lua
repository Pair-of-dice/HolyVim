return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			cpp = { "clang-format" },
			cs = { "clang-format" },
			c = { "clang-format" },
			java = { "clang-format" },
			css = { "biome" },
			javascript = { "biome" },
			html = { "htmlbeautifier" },
			markdown = { "mdformat" },
			toml = { "tombi" },
			zig = { "zigfmt" },
			yaml = { "yamlfmt" },
			python = { "ruff_format" },
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				require("conform").format()
			end,
		})
	end,
	keys = {
		{
			"<leader>f",
			"<cmd>lua require('conform').format()<cr>",
			desc = "Format file",
		},
	},
}
