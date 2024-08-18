if os.getenv("XAP_DEBUG") == "true" then
	package.loaded["helpoga.treesitter"] = nil
	package.loaded["helpoga.path"] = nil
	package.loaded["testonga.configs.common"] = nil
end

local pl_helper = require("helpoga.placeholder")
local CommonTestonga = require("testonga.configs.common")

---@class PHPTestonga : CommonTestonga
local PHPTestonga = setmetatable({}, CommonTestonga)
PHPTestonga.__index = PHPTestonga
PHPTestonga.__parent = CommonTestonga

function PHPTestonga:new()
	return CommonTestonga.new(self, {
		file_type = "php",
		cmd = string.format(
			"php ./vendor/bin/phpunit --config ./phpunit.xml --filter '%s' --test-suffix %s",
			pl_helper.placeholder.TEST,
			pl_helper.placeholder.FILENAME
		),
		query = [[
            (
             (method_declaration 
              name: (name) @test-name)             

             (#match? @test-name "test")
            )
        ]],
	})
end

-- ---Callback to be call for each capture of your TSQuery
-- ---@param bufnr integer
-- ---@param captures table<string>
-- ---@return fun(id:integer, node:TSNode, name:string)
-- function PHPTestonga:capture_callback(bufnr, captures)
-- 	local func_name = ""
-- 	return function(_, node, name)
-- 		if name == "func-name" then
-- 			func_name = ts_helper.get_content(node, bufnr)
-- 			table.insert(captures, func_name)
-- 		end
-- 		if name == "test-name" then
-- 			local test_name = ts_helper.get_content(node, bufnr)
-- 			test_name = string.gsub(test_name, "[\"|']", "")
-- 			test_name = string.gsub(test_name, " ", "_")
-- 			table.insert(captures, string.format("%s.*/%s", func_name, test_name))
-- 		end
-- 	end
-- end

return PHPTestonga
