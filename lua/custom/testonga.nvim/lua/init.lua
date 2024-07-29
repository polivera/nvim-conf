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
	["*.go"] = {
		test_cmd = "go test",
		test_cmd_arts = "-tags=unit,integration,e2e",
	},
}

return Mod
