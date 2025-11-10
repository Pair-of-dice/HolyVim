local colours = require("alienocean.palette").Get()
local alienocean = {}

alienocean.normal = {
	a = { bg = colours.bgdark, fg = colours.green },
	b = { bg = colours.bgdark, fg = colours.yellow },
	c = { bg = colours.bgdark, fg = colours.purple },
	x = { bg = colours.bgdark, fg = colours.green },
}
alienocean.inactive = {
	c = { bg = colours.bgdark, fg = colours.pink },
}
alienocean.insert = {
	a = { bg = colours.bgdark, fg = colours.yellow },
	b = { bg = colours.bgdark, fg = colours.yellow },
}
alienocean.visual = {
	a = { bg = colours.bgdark, fg = colours.cyan },
	b = { bg = colours.bgdark, fg = colours.cyan },
}
alienocean.replace = {
	a = { bg = colours.bgdark, fg = colours.red },
	b = { bg = colours.bgdark, fg = colours.red },
}
alienocean.terminal = {
	a = { bg = colours.bgdark, fg = colours.purple },
	b = { bg = colours.bgdark, fg = colours.purple },
}
alienocean.command = {
	a = { bg = colours.bgdark, fg = colours.green },
	b = { bg = colours.bgdark, fg = colours.green },
}
return alienocean
