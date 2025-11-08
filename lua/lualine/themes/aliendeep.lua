local colours = require("Aliendeep.palette").Get()
local aliendeep = {}

aliendeep.normal = {
	a = { bg = colours.bgdark, fg = colours.green },
	b = { bg = colours.bgdark, fg = colours.yellow },
	c = { bg = colours.bgdark, fg = colours.purple },
	x = { bg = colours.bgdark, fg = colours.green },
}
aliendeep.inactive = {
	c = { bg = colours.bgdark, fg = colours.pink },
}
aliendeep.insert = {
	a = { bg = colours.bgdark, fg = colours.yellow },
	b = { bg = colours.bgdark, fg = colours.yellow },
}
aliendeep.visual = {
	a = { bg = colours.bgdark, fg = colours.cyan },
	b = { bg = colours.bgdark, fg = colours.cyan },
}
aliendeep.replace = {
	a = { bg = colours.bgdark, fg = colours.red },
	b = { bg = colours.bgdark, fg = colours.red },
}
aliendeep.terminal = {
	a = { bg = colours.bgdark, fg = colours.purple },
	b = { bg = colours.bgdark, fg = colours.purple },
}
aliendeep.command = {
	a = { bg = colours.bgdark, fg = colours.green },
	b = { bg = colours.bgdark, fg = colours.green },
}
return aliendeep
