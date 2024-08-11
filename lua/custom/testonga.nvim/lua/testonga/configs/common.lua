if os.getenv("XAP_DEBUG") == "true" then
	package.loaded["helpoga.buffer"] = nil
	package.loaded["helpoga.treesitter"] = nil
end

local buf_helper = require("helpoga.buffer")
local ts_helper = require("helpoga.treesitter")

---@class CommonTestonga
---@field cmd string Command to run test
---@field cmd_args string Arguments to the test command
---@field query string TSQuery to retrieve tests from file
local CommonTestonga = {
	file_type = "common",
	cmd = "echo 'you should not use this'",
	cmd_args = "",
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
		table.insert(captures, ts_helper.get_content(node, bufnr))
	end
end

---Function to run the self.query and return all the captures as a list
---@return table<string>
function CommonTestonga:get_test_list()
	local bufnr = buf_helper.get_current_buffer_number()
	local test_list = {} -- :reference:
	ts_helper.capture_and_iter(self.file_type, bufnr, self.query, self:capture_callback(bufnr, test_list))
	return test_list
end

return CommonTestonga
