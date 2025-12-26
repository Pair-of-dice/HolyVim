--local efm = "%l:%c %m,%l %m"

return {
	lazy = true,
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			yaml = { "yamllint" },
			js = { "biomejs" },
			css = { "biomejs" },
			html = { "biomejs" },
			lua = { "selene" },
			toml = { "tombi" },
			python = { "ruff" },
		}
	end,
	init = function()
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
