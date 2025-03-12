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

return PHPTestonga
