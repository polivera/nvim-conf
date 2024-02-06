if vim.g.ortidebug_mode then
	vim.g.ortidebug.reload_module("ortitest.util")
	vim.g.ortidebug.reload_module("ortitest.configs.common")
end

local util = require("ortitest.util")
local common = require("ortitest.configs.common")

local default_test_pattern = ".*_test.go"
local default_unit_test_command = "go test -tags unit ###package### -run ###test###"

---@class GoConf:CommonConf
local GoConf = common:create()
GoConf.__parent = common

function GoConf:new(o)
	o = o or {}
	self:set_params({
		source_file_path = o.source_file_path or util.get_current_file_path(),
		source_file_name = o.source_file_name or util.get_current_file_name(),
		test_file_path = o.default_test_path or util.get_current_file_path(),
		test_file_pattern = o.default_test_pattern or default_test_pattern,
		unit_test_command = o.unit_test_command or default_unit_test_command,
	})
	return self
end

function GoConf:get_test_package()
	return "NO PUEDO CREER QUE ESTO FUNCIONA, PARECE MENTIRA"
end

return GoConf
