local efm = "%l:%c %m,%l %m"
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
			markdown = { "mado" },
		}
--		require("lint").linters.mado = {
--			cmd = "mado",
--			stdin = true, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
--			args = { "check" }, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
--			stream = nil, -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
--			ignore_exitcode = false, -- set this to true if the linter exits with a code != 0 and that's considered normal.
--			env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
--			parser = require("lint.parser").from_errorformat(efm, {
--				source = "mado",
--				severity = vim.diagnostic.severity.WARN,
--			}),
--		}
--		I will do Mado later maybe.
	end,
}
