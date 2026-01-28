return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			cpp = { "clang-format" },
			cs = { lsp_format = "prefer" },
			c = { "clang-format" },
			java = { "clang-format" },
			css = { "biome" },
			javascript = { "biome" },
			html = { lsp_format = "prefer"},
			markdown = { "mdformat" },
			toml = { "tombi" },
			zig = { "zigfmt" },
			yaml = { "yamlfmt" },
			python = { "ruff_format" },
			sh = {"shfmt"},
			bash = {"shfmt"},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},
	keys = {
		{
			"<leader>f",
			"<cmd>lua require('conform').format()<cr>",
			desc = "Format file",
		},
	},
}
