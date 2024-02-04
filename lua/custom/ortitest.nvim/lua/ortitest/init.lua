if vim.g.ortidebug_mode then
	vim.g.ortidebug.reload_module("ortitest.util")
	vim.g.ortidebug.reload_module("ortitest.configs.go")
	vim.g.ortidebug.reload_module("ortitest.configs.lua")
end

local util = require("ortitest.util")
local conf_map = {
	[".go"] = require("ortitest.configs.go"),
	[".lua"] = require("ortitest.configs.lua"),
}

local runners = {}

-- Return module
local M = {}

---Find test files
local find_test_files = function()
	local curr_file_ext = util.get_current_file_extension()
	if not runners[curr_file_ext] then
		if not conf_map[curr_file_ext] then
			print(string.format("extension %s not found", curr_file_ext))
			return
		end
		runners[curr_file_ext] = conf_map[curr_file_ext]:new()
	end
	runners[curr_file_ext]:find_test_files()
end

---Setup OrtiTest Plugin
---@param opts any Don't know yet :)
M.setup = function(opts)
	opts = opts or {}

	vim.api.nvim_create_user_command("OrtiTestFind", find_test_files, {})
end

M.setup()

return M
