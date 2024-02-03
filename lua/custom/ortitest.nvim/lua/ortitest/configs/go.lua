local util = require("ortitest.util")

local defaultSourceFile = util.getcurrentfilename()
local defaultSourcePath = util.getcurrentfilepath()
local defaultTestPath = defaultSourcePath

local GoConf = {
	test = "some test",
}

GoConf.new = function(sourcePath, sourceFile, testPath)
	local self = setmetatable({}, GoConf)
	self.sourcePath = sourcePath or defaultSourcePath
	self.sourceFile = sourceFile or defaultSourceFile
	self.testPath = testPath or defaultTestPath

	-- find test file

	return self
end

local foo = GoConf.new()
print(foo)

return GoConf
