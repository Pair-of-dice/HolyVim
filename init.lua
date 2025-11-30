-- vim:foldmethod=marker
--Basic Vim variables{{{
--Nvim default config(You probably won't edit this much.)
-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.acd = true
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.o.foldmethod = "syntax"
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

--seems to not work.
-- [[ Setting options ]] See `:h vim.o`
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:help option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
-- (Note the single quotes)

-- Print the line number in front of each line
vim.o.number = true

-- Use relative line numbers, so that it is easier to jump with j, k. This will affect the 'number'
-- option above, see `:h number_relativenumber`
vim.o.relativenumber = false

-- Sync clipboard between OS and Neovim. Schedule the setting after `UiEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.api.nvim_create_autocmd("UIEnter", {
	callback = function()
		vim.o.clipboard = "unnamedplus"
	end,
})

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Highlight the line where the cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Show <n> and trailing spaces
vim.o.list = true

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s) See `:help 'confirm'`
vim.o.confirm = true

-- [[ Set up keymaps ]] See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`

-- Use <Esc> to exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ "t", "i" }, "<A-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set({ "t", "i" }, "<A-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set({ "t", "i" }, "<A-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set({ "t", "i" }, "<A-l>", "<C-\\><C-n><C-w>l")
vim.keymap.set({ "n" }, "<A-h>", "<C-w>h")
vim.keymap.set({ "n" }, "<A-j>", "<C-w>j")
vim.keymap.set({ "n" }, "<A-k>", "<C-w>k")
vim.keymap.set({ "n" }, "<A-l>", "<C-w>l")
-- [[ Add optional packages ]]
-- Nvim comes bundled with a set of packages that are not enabled by
-- default. You can enable any of them by using the `:packadd` command.

-- For example, to add the 'nohlsearch' package to automatically turn off search highlighting after
-- 'updatetime' and when going to insert mode
vim.cmd("packadd! nohlsearch")
--}}}
--Autocommands{{{
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.hl.on_yank()
	end,
})
-- Doesn't work in the plugin's file, I don't know why and don't care.
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
--}}}
--Create user commands{{{
-- See `:h nvim_create_user_command()` and `:h user-commands`
-- Create a command `:GitBlameLine` that print the git blame for the current line
vim.api.nvim_create_user_command("GitBlameLine", function()
	local line_number = vim.fn.line(".") -- Get the current line number. See `:h line()`
	local filename = vim.api.nvim_buf_get_name(0)
	print(vim.fn.system({ "git", "blame", "-L", line_number .. ",+1", filename }))
end, { desc = "Print the git blame for the current line" })

--}}}
--Lsp servers to be enabled and configured.{{{
--Enable and mason setup{{{
--vim.lsp.start()
require("config.lazy")
require("mason").setup({ registries = { "github:crashdummyy/mason-registry", "github:mason-org/mason-registry" } })

--enable LSP SERVERS and setup LSP servers
vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
vim.lsp.enable("markdown_oxide")
--vim.lsp.enable('jsonls')
vim.lsp.enable("pylsp")
vim.lsp.enable("zls")
vim.lsp.enable("tombi")
vim.lsp.enable("html")
vim.lsp.enable("css_variables")
vim.lsp.enable("cssls")
vim.lsp.enable("biome")
vim.lsp.enable("ts_ls")
--vim.lsp.enable("jdtls") The config has been commented, it is in ftplugin at the moment.
-- vim.lsp.enable("roslyn_ls") I'm using the roslyn plugin instead, use this as a fallback
vim.lsp.enable("yamlls")
vim.lsp.enable("yamllint")

-- Set up lspconfig.

local cmpCapabilities = require("cmp_nvim_lsp").default_capabilities()

--}}}
--Lua{{{
vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml",
		"selene.yml",
		".git",
	},
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using (most
				-- likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Tell the language server how to find Lua modules same way as Neovim
				-- (see `:h lua-module-load`)
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths
					-- here.
					-- '${3rd}/luv/library'
					-- '${3rd}/busted/library'
				},
				-- Or pull in all of 'runtimepath'.
				-- NOTE: this is a lot slower and will cause issues when working on
				-- your own configuration.
				-- See https://github.com/neovim/nvim-lspconfig/issues/3189
				-- library = {
				--   vim.api.nvim_get_runtime_file('', true),
				-- }
			},
		})
	end,
	settings = {
		Lua = {},
	},
	capabilities = cmpCapabilities,
})
--}}}
--Clangd{{{
vim.lsp.config("clangd", {
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "objcpp", "cuda" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac",
		".git",
	},
	capabilities = cmpCapabilities,
})
--}}}
--zls{{{
vim.lsp.config("zls", {
	cmd = { "zls" },
	filetypes = { "zig", "zir" },
	root_markers = { "zls.json", "build.zig", ".git" },
	workspace_required = false,
	capabilities = cmpCapabilities,
})
--}}}
--markdown oxide{{{
local function command_factory(client, bufnr, cmd)
	return client:exec_cmd({
		title = ("Markdown-Oxide-%s"):format(cmd),
		command = "jump",
		arguments = { cmd },
	}, { bufnr = bufnr })
end
vim.lsp.config("markdown_oxide", {
	cmd = { "markdown-oxide" },
	filetypes = { "markdown", "md" },
	on_attach = function(client, bufnr)
		for _, cmd in ipairs({ "today", "tomorrow", "yesterday" }) do
			vim.api.nvim_buf_create_user_command(
				bufnr,
				"Lsp" .. ("%s"):format(cmd:gsub("^%l", string.upper)),
				function()
					command_factory(client, bufnr, cmd)
				end,
				{
					desc = ("Open %s daily note"):format(cmd),
				}
			)
		end
	end,
	root_markers = { ".git", ".obsidian", ".moxide.toml" },
	capabilities = cmpCapabilities,
})
--}}}
--Tombi{{{
vim.lsp.config("tombi", {
	cmd = { "tombi", "lsp" },
	filetypes = { "toml" },
	root_markers = { "tombi.toml", "pyproject.toml", ".git" },
	capabilities = cmpCapabilities,
})
--}}}
--html{{{
vim.lsp.config("html", {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html", "templ" },
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
		provideFormatter = false,
	},
	root_markers = { "package.json", ".git" },
	settings = {},
	capabilities = cmpCapabilities,
})
--}}}
--css_variables{{{
vim.lsp.config("css_variables", {
	cmd = { "css-variables-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	root_markers = { ".git" },
	settigs = {
		cssVariables = {
			blacklistFolders = {
				"**/.cache",
				"**/.DS_Store",
				"**/.git",
				"**/.hg",
				"**/.next",
				"**/.svn",
				"**/bower_components",
				"**/CVS",
				"**/dist",
				"**/node_modules",
				"**/tests",
				"**/tmp",
			},
			lookupFiles = { "**/*.less", "**/*.scss", "**/*.sass", "**/*.css" },
		},
	},
	capabilities = cmpCapabilities,
})
--}}}
--cssls{{{
vim.lsp.config("cssls", {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	init_options = {
		provideFormatter = false,
	},
	root_markers = { "package.json", ".git" },
	settings = {
		css = {
			validate = true,
		},
		less = {
			validate = true,
		},
		scss = {
			validate = true,
		},
	},
	capabilities = cmpCapabilities,
})
--}}}
--Biome{{{
vim.lsp.config("biome", {
	cmd = { "biome" },
	filetypes = {
		"astro",
		"graphql",
		"javascript",
		"javascriptreact",
		"svelte",
		"typescript",
		"typescript.tsx",
		"typescriptreact",
		"vue",
	},
	root_dir = function(bufnr, on_dir)
		-- The project root is where the LSP can be started from
		-- As stated in the documentation above, this LSP supports monorepos and simple projects.
		-- We select then from the project root, which is identified by the presence of a package
		-- manager lock file.
		local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
		-- Give the root markers equal priority by wrapping them in a table
		root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
			or vim.list_extend(root_markers, { ".git" })
		-- We fallback to the current working directory if no project root is found
		local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

		-- We know that the buffer is using Biome if it has a config file
		-- in its directory tree.
		local filename = vim.api.nvim_buf_get_name(bufnr)
		local biome_config_files = { "biome.json", "biome.jsonc" }
		local is_buffer_using_biome = vim.fs.find(biome_config_files, {
			path = filename,
			type = "file",
			limit = 1,
			upward = true,
			stop = vim.fs.dirname(project_root),
		})[1]
		if not is_buffer_using_biome then
			return
		end

		on_dir(project_root)
	end,
	workspace_required = true,
	capabilities = cmpCapabilities,
})
--}}}
--ts_ls(typescript and javascript ls){{{
vim.lsp.config("ts_ls", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	commands = {
		["editor.action.showReferences"] = function(command, ctx)
			local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
			local file_uri, position, references = unpack(command.arguments)

			local quickfix_items = vim.lsp.util.locations_to_items(references, client.offset_encoding)
			vim.fn.setqflist({}, " ", {
				title = command.title,
				items = quickfix_items,
				context = {
					command = command,
					bufnr = ctx.bufnr,
				},
			})
		end,
	},
	root_dir = function(bufnr, on_dir)
		-- The project root is where the LSP can be started from
		-- As stated in the documentation above, this LSP supports monorepos and simple projects.
		-- We select then from the project root, which is identified by the presence of a package
		-- manager lock file.
		local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
		-- Give the root markers equal priority by wrapping them in a table
		root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
			or vim.list_extend(root_markers, { ".git" })
		-- We fallback to the current working directory if no project root is found
		local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

		on_dir(project_root)
	end,
	handlers = {
		-- handle rename request for certain code actions like extracting functions / types
		["_typescript.rename"] = function(_, result, ctx)
			local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
			vim.lsp.util.show_document({
				uri = result.textDocument.uri,
				range = {
					start = result.position,
					["end"] = result.position,
				},
			}, client.offset_encoding)
			vim.lsp.buf.rename()
			return vim.NIL
		end,
	},
	on_attach = function(client, bufnr)
		-- ts_ls provides `source.*` code actions that apply to the whole file. These only appear in
		-- `vim.lsp.buf.code_action()` if specified in `context.only`.
		vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptSourceAction", function()
			local source_actions = vim.tbl_filter(function(action)
				return vim.startswith(action, "source.")
			end, client.server_capabilities.codeActionProvider.codeActionKinds)

			vim.lsp.buf.code_action({
				context = {
					only = source_actions,
				},
			})
		end, {})
	end,
	capabilities = cmpCapabilities,
})
--}}}
--Jdtls{{{
--local function get_jdtls_cache_dir()
--	return vim.fn.stdpath("cache") .. "/jdtls"
--end
--
--local function get_jdtls_workspace_dir()
--	return get_jdtls_cache_dir() .. "/workspace"
--end
--
--local function get_jdtls_jvm_args()
--	local env = os.getenv("JDTLS_JVM_ARGS")
--	local args = {}
--	for a in string.gmatch((env or ""), "%S+") do
--		local arg = string.format("--jvm-arg=%s", a)
--		table.insert(args, arg)
--	end
--	return unpack(args)
--end
--vim.lsp.config("jdtls", {
--	cmd = function(dispatchers, config)
--		local workspace_dir = get_jdtls_workspace_dir()
--		local data_dir = workspace_dir
--
--		if config.root_dir then
--			data_dir = data_dir .. "/" .. vim.fn.fnamemodify(config.root_dir, ":p:h:t")
--		end
--
--		local config_cmd = {
--			"jdtls",
--			"-data",
--			data_dir,
--			get_jdtls_jvm_args(),
--		}
--
--		return vim.lsp.rpc.start(config_cmd, dispatchers, {
--			cwd = config.cmd_cwd,
--			env = config.cmd_env,
--			detached = config.detached,
--		})
--	end,
--	filetypes = { "java" },
--	root_markers = {
--		{ "mvnw", "gradlew", "build.gradle", "build.gradle.kts", ".git" },
--		{ "build.xml", "pom.xml", "settings.gradle", "settings.gradle.kts" },
--	},
--	--Below line is used for the debugger.
--	init_options = { bundles = jdtls_bundles },
--})
--}}}
--Roslyn_ls{{{
local function on_init_sln(client, target)
	vim.notify("Initializing: " .. target, vim.log.levels.TRACE, { title = "roslyn_ls" })
	---@diagnostic disable-next-line: param-type-mismatch
	client:notify("solution/open", {
		solution = vim.uri_from_fname(target),
	})
end

---@param client vim.lsp.Client
---@param project_files string[]
local function on_init_project(client, project_files)
	vim.notify("Initializing: projects", vim.log.levels.TRACE, { title = "roslyn_ls" })
	---@diagnostic disable-next-line: param-type-mismatch
	client:notify("project/open", {
		projects = vim.tbl_map(function(file)
			return vim.uri_from_fname(file)
		end, project_files),
	})
end

---@param client vim.lsp.Client
local function refresh_diagnostics(client)
	local buffers = vim.lsp.get_buffers_by_client_id(client.id)
	for _, buf in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buf) then
			client:request(
				vim.lsp.protocol.Methods.textDocument_diagnostic,
				{ textDocument = vim.lsp.util.make_text_document_params(buf) },
				nil,
				buf
			)
		end
	end
end

local function roslyn_handlers()
	return {
		["workspace/projectInitializationComplete"] = function(_, _, ctx)
			vim.notify("Roslyn project initialization complete", vim.log.levels.INFO, { title = "roslyn_ls" })
			local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
			refresh_diagnostics(client)
			return vim.NIL
		end,
		["workspace/_roslyn_projectNeedsRestore"] = function(_, result, ctx)
			local client = assert(vim.lsp.get_client_by_id(ctx.client_id))

			---@diagnostic disable-next-line: param-type-mismatch
			client:request("workspace/_roslyn_restore", result, function(err, response)
				if err then
					vim.notify(err.message, vim.log.levels.ERROR, { title = "roslyn_ls" })
				end
				if response then
					for _, v in ipairs(response) do
						vim.notify(v.message, vim.log.levels.INFO, { title = "roslyn_ls" })
					end
				end
			end)

			return vim.NIL
		end,
		["razor/provideDynamicFileInfo"] = function(_, _, _)
			vim.notify(
				"Razor is not supported.\nPlease use https://github.com/tris203/rzls.nvim",
				vim.log.levels.WARN,
				{ title = "roslyn_ls" }
			)
			return vim.NIL
		end,
	}
end
local group = vim.api.nvim_create_augroup("lspconfig.roslyn_ls", { clear = true })
vim.lsp.config("roslyn_ls", {
	offset_encoding = "utf-8",
	cmd = {
		"roslyn",
		"--logLevel",
		"Information",
		"--extensionLogDirectory",
		vim.fs.joinpath(vim.uv.os_tmpdir(), "roslyn_ls/logs"),
		"--stdio",
	},
	filetypes = { "cs" },
	handlers = roslyn_handlers(),

	commands = {
		["roslyn.client.completionComplexEdit"] = function(command, ctx)
			local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
			local args = command.arguments or {}
			local uri, edit = args[1], args[2]

			if uri and edit and edit.newText and edit.range then
				local workspace_edit = {
					changes = {
						[uri.uri] = {
							{
								range = edit.range,
								newText = edit.newText,
							},
						},
					},
				}
				vim.lsp.util.apply_workspace_edit(workspace_edit, client.offset_encoding)
			else
				vim.notify(
					"roslyn_ls: completionComplexEdit args not understood: " .. vim.inspect(args),
					vim.log.levels.WARN
				)
			end
		end,
	},

	root_dir = function(bufnr, cb)
		local bufname = vim.api.nvim_buf_get_name(bufnr)
		-- don't try to find sln or csproj for files from libraries
		-- outside of the project
		if not bufname:match("^" .. vim.fs.joinpath("/tmp/MetadataAsSource/")) then
			-- try find solutions root first
			local root_dir = vim.fs.root(bufnr, function(fname, _)
				return fname:match("%.sln[x]?$") ~= nil
			end)

			if not root_dir then
				-- try find projects root
				root_dir = vim.fs.root(bufnr, function(fname, _)
					return fname:match("%.csproj$") ~= nil
				end)
			end

			if root_dir then
				cb(root_dir)
			end
		end
	end,
	on_init = {
		function(client)
			local root_dir = client.config.root_dir

			-- try load first solution we find
			for entry, type in vim.fs.dir(root_dir) do
				if type == "file" and (vim.endswith(entry, ".sln") or vim.endswith(entry, ".slnx")) then
					on_init_sln(client, vim.fs.joinpath(root_dir, entry))
					return
				end
			end

			-- if no solution is found load project
			for entry, type in vim.fs.dir(root_dir) do
				if type == "file" and vim.endswith(entry, ".csproj") then
					on_init_project(client, { vim.fs.joinpath(root_dir, entry) })
				end
			end
		end,
	},

	on_attach = function(client, bufnr)
		-- avoid duplicate autocmds for same buffer
		if vim.api.nvim_get_autocmds({ buffer = bufnr, group = group })[1] then
			return
		end

		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
			group = group,
			buffer = bufnr,
			callback = function()
				refresh_diagnostics(client)
			end,
			desc = "roslyn_ls: refresh diagnostics",
		})
	end,

	capabilities = {
		-- HACK: Doesn't show any diagnostics if we do not set this to true
		textDocument = {
			diagnostic = {
				dynamicRegistration = true,
			},
		},
		cmpCapabilities,
	},
	settings = {
		["csharp|background_analysis"] = {
			dotnet_analyzer_diagnostics_scope = "fullSolution",
			dotnet_compiler_diagnostics_scope = "fullSolution",
		},
		["csharp|inlay_hints"] = {
			csharp_enable_inlay_hints_for_implicit_object_creation = true,
			csharp_enable_inlay_hints_for_implicit_variable_types = true,
			csharp_enable_inlay_hints_for_lambda_parameter_types = true,
			csharp_enable_inlay_hints_for_types = true,
			dotnet_enable_inlay_hints_for_indexer_parameters = true,
			dotnet_enable_inlay_hints_for_literal_parameters = true,
			dotnet_enable_inlay_hints_for_object_creation_parameters = true,
			dotnet_enable_inlay_hints_for_other_parameters = true,
			dotnet_enable_inlay_hints_for_parameters = true,
			dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
			dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
			dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
		},
		["csharp|symbol_search"] = {
			dotnet_search_reference_assemblies = true,
		},
		["csharp|completion"] = {
			dotnet_show_name_completion_suggestions = true,
			dotnet_show_completion_items_from_unimported_namespaces = true,
			dotnet_provide_regex_completions = true,
		},
		["csharp|code_lens"] = {
			dotnet_enable_references_code_lens = true,
		},
		-- ["workspace/_roslyn_projectNeedsRestore"] = function(_, result, ctx)
		-- 	-- HACKY workaround for roslyn_ls bug (sends here .cs files for some reason)
		-- 	-- started around 5.0.0-1.25263.3
		-- 	--  THANK YOU KONRADMILK!
		-- 	local project_file_paths = vim.tbl_get(result, "projectFilePaths") or {}
		-- 	if vim.iter(project_file_paths):any(function(path)
		-- 		return vim.endswith(path, ".cs")
		-- 	end) then
		-- 		-- remove cs files and check if empty afterwards
		-- 		-- we could simply filter it out, but empty list would mean "restore-all"
		-- 		-- and it's not what we want since csprojs will come in later requests
		-- 		project_file_paths = vim.iter(project_file_paths)
		-- 			:filter(function(path)
		-- 				return not vim.endswith(path, ".cs")
		-- 			end)
		-- 			:totable()
		-- 		if vim.tbl_isempty(project_file_paths) then
		-- 			---@type lsp.ResponseError
		-- 			return { code = 0, message = "" }
		-- 		end
		-- 	end
		--
		-- 	local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
		--
		-- 	client:request(
		-- 		---@diagnostic disable-next-line: param-type-mismatch
		-- 		"workspace/_roslyn_restore",
		-- 		{ projectFilePaths = project_file_paths },
		-- 		function(err, response)
		-- 			if err then
		-- 				vim.notify(err.message, vim.log.levels.ERROR, { title = "roslyn_ls" })
		-- 			end
		-- 			if response then
		-- 				for _, v in ipairs(response) do
		-- 					vim.notify(v.message, vim.log.levels.INFO, { title = "roslyn_ls" })
		-- 				end
		-- 			end
		-- 		end
		-- 	)
		--
		-- 	return vim.NIL
		-- end,
	},
})
--}}}
--Yamlls{{{
vim.lsp.config("yamlls", {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
	root_markers = { ".git" },
	settings = {
		-- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
		redhat = { telemetry = { enabled = false } },
		-- formatting disabled by default in yaml-language-server; enable it
		yaml = { format = { enable = true } },
	},
	on_init = function(client)
		--- https://github.com/neovim/nvim-lspconfig/pull/4016
		--- Since formatting is disabled by default if you check `client:supports_method('textDocument/formatting')`
		--- during `LspAttach` it will return `false`. This hack sets the capability to `true` to facilitate
		--- autocmd's which check this capability
		client.server_capabilities.documentFormattingProvider = true
	end,
	capabilities = cmpCapabilities,
})
--}}}
--Python language server(pylsp){{{
vim.lsp.config("pylsp", {
	cmd = { "pylsp" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
	settings = {
		pylsp = {
			plugins = {
				--Configure plugins here
				pylint = {
					enabled = true,
				},
				black = {
					enabled = true,
				},
				yapf = {
					enabled = false,
				},
			},
		},
	},
	capabilities = cmpCapabilities,
})
--}}}
--}}}
--Set up builtin completion{{{
vim.cmd([[set completeopt+=menuone,noselect,popup,preinsert]])
-- local triggers = { "." }
-- vim.api.nvim_create_autocmd("InsertCharPre", {
-- 	buffer = vim.api.nvim_get_current_buf(),
-- 	callback = function()
-- 		if vim.fn.pumvisible() == 1 or vim.fn.state("m") == "m" then
-- 			return
-- 		end
-- 		local char = vim.v.char
-- 		if vim.list_contains(triggers, char) then
-- 			local key = vim.keycode("<C-x><C-n>")
-- 			vim.api.nvim_feedkeys(key, "m", false)
-- 		end
-- 	end,
-- })
--}}}
--Custom keybinds{{{
vim.keymap.set({ "i", "n" }, "<C-p>", function()
	vim.cmd("tabprevious")
end)
vim.keymap.set({ "i", "n" }, "<C-n>", function()
	vim.cmd("tabnext")
end)
vim.keymap.set({ "n" }, "<leader>s", function()
	vim.cmd("split")
	vim.cmd("terminal")
end)
vim.keymap.set({ "n" }, "<leader>d", function()
	vim.cmd("lua vim.diagnostic.setloclist()")
end)
--}}}
--Set colourscheme{{{
vim.cmd.colorscheme("Alienocean")
--}}`
