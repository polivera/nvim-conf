if os.getenv("XAP_DEBUG") == "true" then
	package.loaded["helpoga.buffer"] = nil
	package.loaded["helpoga.treesitter"] = nil
	package.loaded["helpoga.telescope"] = nil
	package.loaded["helpoga.path"] = nil
end

local buf_helper = require("helpoga.buffer")
local treesit_helper = require("helpoga.treesitter")
local telescope_helper = require("helpoga.telescope")
local pl_helper = require("helpoga.placeholder")

local winid = nil

---@class CommonTestonga
---@field cmd string Command to run test
---@field query string TSQuery to retrieve tests from file
local CommonTestonga = {
	file_type = "common",
	cmd = "echo 'you should not use this'",
	query = [[
        (
          [
           (function_declaration 
             name: (identifier) @func-name)
          ]
        ) 
    ]],
}
CommonTestonga.__index = CommonTestonga

---Create a new instance of CommonTestonga table
---@return CommonTestonga
function CommonTestonga:new(obj)
	obj = obj or {}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

---Callback to be call for each capture of your TSQuery
---@param bufnr integer
---@param captures table<string>
---@return fun(id:integer, node:TSNode, name:string)
function CommonTestonga:capture_callback(bufnr, captures)
	return function(_, node, _)
		table.insert(captures, treesit_helper.get_content(node, bufnr))
	end
end

---Function to run the self.query and return all the captures as a list
---@return table<string>
function CommonTestonga:get_test_list()
	local bufnr = buf_helper.get_current_buffer_number()
	local test_list = {} -- :reference:
	treesit_helper.capture_and_iter(self.file_type, bufnr, self.query, self:capture_callback(bufnr, test_list))
	return test_list
end

---Show all test in the test file
function CommonTestonga:show_test_in_file()
	local test_list = self:get_test_list()
	if #test_list == 1 then
		print("No test found in file")
		return
	end
	telescope_helper.show_list("Tests on file", test_list, function(selection)
		self:run_test(selection)
	end)
end

---Build the command used to run the test
---@param test_name string
---@return string
function CommonTestonga:build_test_command(test_name)
	local cmd = pl_helper.replace_no_param(self.cmd)
	cmd = pl_helper.replace_test(cmd, test_name)
	return cmd
end

--- Run selected test
function CommonTestonga:run_test(test_name)
	local bufid = nil
	local test_command = self:build_test_command(test_name)
	winid, bufid = buf_helper.vscratch(string.format("Running test %s", test_command), "Testonga!", winid)

	vim.fn.jobstart(test_command, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			buf_helper.put_content_on_buffer(data or "", bufid)
		end,
		on_stderr = function(_, data)
			buf_helper.put_content_on_buffer(data or "", bufid)
		end,
		on_exit = function(_, _)
			buf_helper.put_content_on_buffer("Job complete!", bufid)
		end,
	})
end

return CommonTestonga
