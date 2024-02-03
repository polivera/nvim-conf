if vim.g.ortidebugmode then
	vim.g.ortidebug.reloadmodule("ortitest.util")
end

local util = require("ortitest.util")

local defaultSourceFile = util.getcurrentfilename()
local defaultSourcePath = util.getcurrentfilepath()
local defaultTestPath = defaultSourcePath
local defaultTestPattern = ".*.spec.lua"

---@class GoConf
---@field sourcePath string
---@field sourceFile string
---@field testPath string
---@field testPattern string
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
	print(util.scandir(self.testPath))
end

local foo = GoConf:new()
foo:findtestfile()

return GoConf
