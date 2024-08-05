if os.getenv("XAP_DEBUG") == "true" then
	package.loaded["helpoga.buffer"] = nil
	package.loaded["helpoga.treesitter"] = nil
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

--[[
Query 2:
(
 [
    (function_declaration 
      
        name: (identifier) @func-name
        )

    (expression_statement
      (call_expression
                function: (selector_expression
                    field: (field_identifier) @test-func)
                arguments: (argument_list
                             (interpreted_string_literal) @test-name)
                )
      )

    (#match? @test-func "Run")
    ]
) 


--]]

local buf_helper = require("helpoga.buffer")
local treesit_helper = require("helpoga.treesitter")
local Mod = {}

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

local function leteste()
	local res = treesit_helper.exec_query(206, "go", opts["go"].test_cmd_arts)
	print(vim.inspect(res))
end

vim.api.nvim_create_user_command("OrtiTestFind", leteste, {})

return Mod
