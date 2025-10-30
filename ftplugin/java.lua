--Debugger{{{
local jdtls_bundles = {
	vim.fn.glob(
		"~/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
	),
}
local excluded = {
	"com.microsoft.java.test.runner-jar-with-dependencies.jar",
	"jacocoagent.jar",
}
local java_test_bundles =
	vim.split(vim.fn.glob("~/.local/share/nvim/mason/packages/java-test/extension/server/*.jar", 1), "\n")

for _, java_test_jar in ipairs(java_test_bundles) do
	local fname = vim.fn.fnamemodify(java_test_jar, ":t")
	if not vim.tbl_contains(excluded, fname) then
		table.insert(jdtls_bundles, java_test_jar)
	end
end
local dap = require("dap")
dap.configurations.java = {
	{
		-- You need to extend the classPath to list your dependencies.
		-- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
		classPaths = {},

		-- If using multi-module projects, remove otherwise.
		--projectName = "yourProjectName",

		javaExec = "/usr/bin/java",

		-- If using the JDK9+ module system, this needs to be extended
		-- `nvim-jdtls` would automatically populate this property
		modulePaths = {},
		request = "launch",
		type = "java",
	},
}
--}}}
--jdtls langauge server config{{{
local config = {
	name = "jdtls",

	-- `cmd` defines the executable to launch eclipse.jdt.ls.
	-- `jdtls` must be available in $PATH and you must have Python3.9 for this to work.
	--
	-- As alternative you could also avoid the `jdtls` wrapper and launch
	-- eclipse.jdt.ls via the `java` executable
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = { "jdtls" },

	-- `root_dir` must point to the root of your project.
	-- See `:help vim.fs.root`
	root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw" }),

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {},
	},

	-- This sets the `initializationOptions` sent to the language server
	-- If you plan on using additional eclipse.jdt.ls plugins like java-debug
	-- you'll need to set the `bundles`
	--
	-- See https://codeberg.org/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on any eclipse.jdt.ls plugins you can remove this
	init_options = {},
}

config["init_options"] = {
	bundles = jdtls_bundles,
}

require("jdtls").start_or_attach(config)
