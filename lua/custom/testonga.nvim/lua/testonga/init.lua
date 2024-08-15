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
	["php"] = require("testonga.configs.php"):new(),
}

vim.api.nvim_create_user_command("Garompeta", function()
	opts["php"]:show_test_in_file()
end, {})

return Mod
