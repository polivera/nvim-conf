if vim.g.ortidebugmode then
	vim.g.ortidebug.reloadmodule("ortitest.util")
end

local util = require("ortitest.util")

local defaultSourceFile = util.get_current_file_name()
local defaultSourcePath = util.get_current_file_path()
local defaultTestPath = defaultSourcePath
local defaultTestPattern = ".*.spec.lua"

---@class GoConf
---@field source_file_path string
---@field source_file_name string
---@field test_file_path string
---@field test_file_pattern string
local GoConf = {}

---Create a new GoConf object
---@param sourcePath ?string
---@param sourceFile ?string
---@param testPath ?string
---@param testPattern ?string
---@return GoConf
function GoConf:new(sourcePath, sourceFile, testPath, testPattern)
	local obj = {}
	setmetatable(obj, { __index = GoConf })
	obj.sourcePath = sourcePath or defaultSourcePath
	obj.sourceFile = sourceFile or defaultSourceFile
	obj.testPath = testPath or defaultTestPath
	obj.testPattern = testPattern or defaultTestPattern
	return obj
end

---Find test file
function GoConf:findtestfile()
	for _, line in pairs(util.scan_dir(self.test_file_path)) do
		if string.match(line, string.format("%s%s", self.source_file_name, self.test_file_pattern)) then
			print(line)
		end
	end
end

local foo = GoConf:new()
foo:findtestfile()

return GoConf
