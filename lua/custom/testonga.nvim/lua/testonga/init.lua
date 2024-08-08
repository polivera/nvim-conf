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

local buf_helper = require("helpoga.buffer")
local ts_helper = require("helpoga.treesitter")
local Mod = {}

print("something like that")

local opts = {
	["go"] = {
		test_cmd = "go test",
		test_cmd_arts = "-tags=unit,integration,e2e",
		test_query = [[
            (
              [
               (function_declaration 
                 name: (identifier) @func-name)

               (expression_statement
                 (call_expression
                   function: (selector_expression
                     field: (field_identifier) @test-func)
                   arguments: (argument_list
                     (interpreted_string_literal) @test-name)))

                (#match? @test-func "Run")
              ]
            ) 
        ]],
	},
}

local function lala()
	local bfn = buf_helper.get_current_buffer_number()
	local ft = "go"
	ts_helper.capture_and_iter(ft, bfn, opts[ft].test_query, function(_, node, name)
		print(name)
		print(ts_helper.get_content(node, bfn))
	end)
end

vim.api.nvim_create_user_command("Garompeta", lala, {})

return Mod
