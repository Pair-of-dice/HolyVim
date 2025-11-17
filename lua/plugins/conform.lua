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
				css = { "biome", "format" },
				javascript = { "biome", "format" },
				html = { "htmlbeautifier" },
				markdown = { "mdformat" },
				toml = { "tombi" },
				zig = { "zigfmt" },
				yaml = { "yamlfmt" },
				python = { "black" },
			},
		})
		vim.keymap.set({ "n", "i" }, "<C-A-f>", function()
			vim.cmd("lua require('conform').format()")
		end)
		--}}}
	end,
}
