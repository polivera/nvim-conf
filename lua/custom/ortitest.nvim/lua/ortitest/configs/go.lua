if vim.g.ortidebugmode then
	vim.g.ortidebug.reloadmodule("ortitest.util")
end

local util = require("ortitest.util")

local defaultSourceFile = util.getcurrentfilename()
local defaultSourcePath = util.getcurrentfilepath()
local defaultTestPath = defaultSourcePath
local defaultTestPattern = ".*_test.go"

local GoConf = {
	test = "some test",
}

GoConf.new = function(sourcePath, sourceFile, testPath)
	local self = setmetatable({}, GoConf)
	self.sourcePath = sourcePath or defaultSourcePath
	self.sourceFile = sourceFile or defaultSourceFile
	self.testPath = testPath or defaultTestPath
	return self
end

function GoConf:findtestfile() end

local foo = GoConf.new()
print(foo.testPath)

return GoConf
