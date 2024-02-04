if vim.g.ortidebugmode then
	vim.g.ortidebug.reload_module("ortitest.util")
end

local util = require("ortitest.util")

local defaultSourceFile = util.get_current_file_name()
local defaultSourcePath = util.get_current_file_path()
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
