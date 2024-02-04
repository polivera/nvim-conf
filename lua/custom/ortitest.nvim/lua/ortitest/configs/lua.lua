if vim.g.ortidebugmode then
	vim.g.ortidebug.reload_module("ortitest.util")
end

local util = require("ortitest.util")

local default_source_file = util.get_current_file_name()
local default_source_path = util.get_current_file_path()
local default_test_path = default_source_path
local default_test_pattern = ".*.spec.lua"

---@class GoConf
---@field source_file_path string
---@field source_file_name string
---@field test_file_path string
---@field test_file_pattern string
local GoConf = {}

---Create a new GoConf object
---@param source_path ?string
---@param source_file ?string
---@param test_path ?string
---@param test_pattern ?string
---@return GoConf
function GoConf:new(source_path, source_file, test_path, test_pattern)
	print("new has been called")
	local obj = {}
	setmetatable(obj, self)
	obj.__index = self
	obj.source_file_path = source_path or default_source_path
	obj.source_file_name = source_file or default_source_file
	obj.test_file_path = test_path or default_test_path
	obj.test_file_pattern = test_pattern or default_test_pattern
	return obj
end

---Find test file
function GoConf:find_test_files()
	print("this is getting called")
	local result = {}
	for _, line in pairs(util.scan_dir(self.test_file_path)) do
		if string.match(line, string.format("%s%s", self.source_file_name, self.test_file_pattern)) then
			table.insert(result, line)
		end
	end
	print("something new")
	vim.g.ortidebug.debug_print(result)
	return result
end

return GoConf
