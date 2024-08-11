if os.getenv("XAP_DEBUG") == "true" then
	package.loaded["helpoga.buffer"] = nil
	package.loaded["helpoga.treesitter"] = nil
	package.loaded["testonga.configs.go"] = nil
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

local Mod = {}

local opts = {
	["go"] = require("testonga.configs.go"):new(),
}

vim.api.nvim_create_user_command("Garompeta", function()
	local foo = opts["go"]:get_test_list()
	for _, val in pairs(foo) do
		print(val)
	end
end, {})

return Mod