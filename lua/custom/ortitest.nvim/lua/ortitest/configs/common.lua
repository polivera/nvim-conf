if vim.g.ortidebug_mode then
	vim.g.ortidebug.reload_module("ortitest.util")
end

local util = require("ortitest.util")

---@class CommonConf
---@field source_file_path string
---@field source_file_name string
---@field test_file_path string
---@field test_file_pattern string
local CommonConf = {}

--
-- Private funcitons area
--
local find_test_files = function(test_file_path, source_file_name, test_file_pattern)
	local result = {}
	for _, line in pairs(util.scan_dir(test_file_path)) do
		if string.match(line, string.format("%s%s", source_file_name, test_file_pattern)) then
			table.insert(result, { text = line, filename = test_file_path .. line })
		end
	end
	return result
end

---@return CommonConf
function CommonConf:create(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function CommonConf:set_params(o)
	self.source_file_path = o.source_file_path
	self.source_file_name = o.source_file_name
	self.test_file_path = o.test_file_path
	self.test_file_pattern = o.test_file_pattern
end

---Find test file
function CommonConf:find_test_files()
	local file_list = find_test_files(self.test_file_path, self.source_file_name, self.test_file_pattern)
	if #file_list == 0 then
		print(string.format("Can't find test files for %s", self.source_file_name))
		return
	end
	if #file_list == 1 then
		vim.cmd(string.format("edit %s", file_list[1].filename))
		return
	end
	vim.fn.setqflist(file_list)
	vim.cmd.copen()
end

return CommonConf
