if vim.g.ortidebug_mode then
	vim.g.ortidebug.reload_module("ortitest.util")
end

local util = require("ortitest.util")

local default_source_file = util.get_current_file_name()
local default_source_path = util.get_current_file_path()
local default_test_path = default_source_path
local default_test_pattern = ".*.spec.lua"

---@class LuaConf
---@field source_file_path string
---@field source_file_name string
---@field test_file_path string
---@field test_file_pattern string
local LuaConf = {}
LuaConf.__index = LuaConf

---Create a new GoConf object
---@param source_path ?string
---@param source_file ?string
---@param test_path ?string
---@param test_pattern ?string
---@return LuaConf
function LuaConf:new(source_path, source_file, test_path, test_pattern)
	local o = {}

	setmetatable(o, self)
	o.source_file_path = source_path or default_source_path
	o.source_file_name = source_file or default_source_file
	o.test_file_path = test_path or default_test_path
	o.test_file_pattern = test_pattern or default_test_pattern
	return o
end

---Find test file
function LuaConf:find_test_files()
	local result = {}
	for _, line in pairs(util.scan_dir(self.test_file_path)) do
		if string.match(line, string.format("%s%s", self.source_file_name, self.test_file_pattern)) then
			table.insert(result, line)
		end
	end
	return result
end

return LuaConf
