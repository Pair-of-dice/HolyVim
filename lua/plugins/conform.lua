return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		--Conform configuration(formatter){{{
		local conform = require("conform")
		conform.setup({
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
				python = { "black" },
			},
		})
		--}}}
	end,
	keys = {
		{
			"<leader>f",
			"<cmd>lua require('conform').format()<cr>",
			desc = "Format file",
		},
	},
}
