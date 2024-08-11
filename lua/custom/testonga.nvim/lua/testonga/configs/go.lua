if os.getenv("XAP_DEBUG") == "true" then
	package.loaded["helpoga.treesitter"] = nil
	package.loaded["testonga.configs.common"] = nil
end

local ts_helper = require("helpoga.treesitter")
local CommonTestonga = require("testonga.configs.common")

---@class GoTestonga : CommonTestonga
local GoTestonga = setmetatable({}, CommonTestonga)
GoTestonga.__index = GoTestonga
GoTestonga.__parent = CommonTestonga

function GoTestonga:new()
	return CommonTestonga.new(self, {
		file_type = "go",
		cmd = "go test",
		cmd_args = "-tags=unit,integration,e2e",
		query = [[
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
	})
end

---Callback to be call for each capture of your TSQuery
---@param bufnr integer
---@param captures table<string>
---@return fun(id:integer, node:TSNode, name:string)
function GoTestonga:capture_callback(bufnr, captures)
	local func_name = ""
	return function(_, node, name)
		if name == "func-name" then
			func_name = ts_helper.get_content(node, bufnr)
			table.insert(captures, func_name)
		end
		if name == "test-name" then
			local test_name = ts_helper.get_content(node, bufnr)
			test_name = string.gsub(test_name, "[\"|']", "")
			test_name = string.gsub(test_name, " ", "_")
			table.insert(captures, string.format("%s.*/%s", func_name, test_name))
		end
	end
end

return GoTestonga
