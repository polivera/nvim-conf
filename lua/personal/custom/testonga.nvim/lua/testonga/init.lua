if os.getenv("XAP_DEBUG") == "true" then
	package.loaded["helpoga.buffer"] = nil
end
--[[
Testonga init

Params should be:
    - map[filetype] = {
    command = "test command"
    params = "test command params"
    ?test_query = "Tree sitter query to retrieve tests"
    }

This should do:
- List tests in file
- Run selected test
- Run last runned test
- Run immediate test
- Run all tests in file
--]]

vim.g.nvim_testonga = vim.g.nvim_testonga or {}

local buf_helper = require("helpoga.buffer")
local Mod = {}

local opts = {
	["go"] = require("testonga.configs.go"):new(),
	["php"] = require("testonga.configs.php"):new(),
}

Mod.show_test_in_file = function()
	local ftype = buf_helper.get_current_buffer_file_type()
	vim.g.nvim_testonga = vim.tbl_extend("force", vim.g.nvim_testonga, { LAST_TYPE = ftype })
	local testonga = opts[ftype]
	if testonga == nil then
		print("Test not configured for file type")
		return
	end
	testonga:show_test_in_file()
end

Mod.run_last_test = function()
	local testonga = opts[vim.g.nvim_testonga.LAST_TYPE]
	if testonga == nil then
		print("Test not configured for file type")
		return
	end
	testonga:run_last_test()
end

Mod.setup = function() end

return Mod
