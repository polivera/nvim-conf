if vim.g.ortidebug_mode then
	vim.g.ortidebug.reload_module("ortiutils.dir")
	vim.g.ortidebug.reload_module("ortiutils.telescope")
	vim.g.ortidebug.reload_module("ortiutils.buffer")
end

local util = require("ortiutils.dir")
local util_telescope = require("ortiutils.telescope")
local util_buffer = require("ortiutils.buffer")

local test_buffer_pane = {
	bufnr = -1,
	windid = -1,
}

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
	local file_list = {}

	for _, line in pairs(util.scan_dir(self.test_file_path)) do
		if string.match(line, string.format("%s%s", self.source_file_name, self.test_file_pattern)) then
			table.insert(file_list, { text = line, filename = self.test_file_path .. line })
		end
	end

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

	util_telescope.make_list(current_file .. " tests", list, self:run_test(current_file)).call({})
end

function CommonConf:run_test(test_file)
	local current_file_path = util.get_current_file_path()
	local test_package = self:get_test_package()
	local command_template = self.unit_test_command
	return function(test_name)
		print("this is something")
		print(vim.inspect(test_buffer_pane))
		local open_split = util_buffer.new_vsplit_scratch(
			"Running test for " .. test_name,
			test_buffer_pane.bufnr,
			test_buffer_pane.windid
		)
		test_buffer_pane.bufnr = open_split.bufnr
		test_buffer_pane.windid = open_split.windid
		local test_command = build_test_command(command_template, test_package, current_file_path, test_file, test_name)

		vim.fn.jobstart(test_command, {
			stdout_buffered = true,
			on_stdout = function(_, data)
				util_buffer.append_content_to_buf(test_buffer_pane.bufnr, data or "")
			end,
			on_stderr = function(_, data)
				util_buffer.append_content_to_buf(test_buffer_pane.bufnr, data or "")
			end,
			on_exit = function(_, _)
				util_buffer.append_content_to_buf(test_buffer_pane.bufnr, "job complete")
			end,
		})
	end
end

function CommonConf:run_last_test()
	-- TODO: complete this
	return ""
end

return CommonConf
