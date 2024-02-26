if vim.g.ortidebug_mode then
	vim.g.ortidebug.reload_module("ortiutils.dir")
	vim.g.ortidebug.reload_module("ortiutils.telescope")
end

local util = require("ortiutils.dir")
local util_telescope = require("ortiutils.telescope")

--- Const like
local PATH_WILDCARD = "###path###"
local FILE_WILDCARD = "###file###"
local TEST_WILDCARD = "###test###"
local PACKAGE_WILDCARD = "###package###"

---@class CommonConf
---@field source_file_path string
---@field source_file_name string
---@field test_file_path string
---@field test_file_pattern string
---@field unit_test_command string
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

--
-- Build the test command to execute
--
local build_test_command = function(command, package, path, file, test_name)
	return command
		:gsub(PATH_WILDCARD, path)
		:gsub(FILE_WILDCARD, file)
		:gsub(TEST_WILDCARD, test_name)
		:gsub(PACKAGE_WILDCARD, package)
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
	self.unit_test_command = o.unit_test_command
end

function CommonConf:get_test_package()
	return util.get_current_file_path()
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

function CommonConf:get_test_name()
	-- TODO: Fix this bro
	print("bro you should not be here")
	return ""
end

function CommonConf:get_test_methods_list()
	-- TODO: Fix this
	print("you should not be here")
	return {}
end

function CommonConf:run_test_file()
	local current_file = util.get_current_file_name_and_extension()
	if not string.match(current_file, self.test_file_pattern) then
		print("Current file is not a test file")
	end

	local list = self:get_test_methods_list()

	util_telescope
		.make_list(current_file .. " tests", list, function(selected)
			local foo = build_test_command(
				self.unit_test_command,
				self:get_test_package(),
				util.get_current_file_path(),
				current_file,
				selected
			)
			print(foo)
		end)
		.call({})
end

function CommonConf:run_last_test()
	-- TODO: complete this
	return ""
end

return CommonConf
