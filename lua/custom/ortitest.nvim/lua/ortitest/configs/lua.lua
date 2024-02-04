if vim.g.ortidebug_mode then
	vim.g.ortidebug.reload_module("ortitest.util")
	vim.g.ortidebug.reload_module("ortitest.configs.common")
end

local util = require("ortitest.util")
local common = require("ortitest.configs.common")

local default_test_pattern = ".*.spec.lua"

---@class LuaConf:CommonConf
local LuaConf = common:create()
LuaConf.__parent = common

function LuaConf:new(o)
	o = o or {}
	self:set_params({
		source_file_path = o.source_file_path or util.get_current_file_path(),
		source_file_name = o.source_file_name or util.get_current_file_name(),
		test_file_path = o.default_test_path or util.get_current_file_path(),
		test_file_pattern = o.default_test_pattern or default_test_pattern,
	})
	return self
end

return LuaConf
