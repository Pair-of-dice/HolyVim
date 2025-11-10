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
		}
	end,
}
