if vim.g.ortidebug_mode then
	vim.g.ortidebug.reload_module("ortiutils.dir")
	vim.g.ortidebug.reload_module("ortitest.configs.go")
	vim.g.ortidebug.reload_module("ortitest.configs.lua")
end

local util = require("ortiutils.dir")
local conf_map = {
	[".go"] = require("ortitest.configs.go"),
	[".lua"] = require("ortitest.configs.lua"),
}

local runners = {}

-- Return module
local M = {}

local get_runner = function()
	local curr_file_ext = util.get_current_file_extension()
	if not runners[curr_file_ext] then
		if not conf_map[curr_file_ext] then
			print(string.format("extension %s not found", curr_file_ext))
			return
		end
		runners[curr_file_ext] = conf_map[curr_file_ext]:new()
	end
	return runners[curr_file_ext]
end

---Find test files
local find_test_files = function()
	local runner = get_runner()
	if runner then
		runner:find_test_files()
	end
end

local run_test_file = function()
	local runner = get_runner()
	if runner then
		runner:run_test_file()
	end
end

---Setup OrtiTest Plugin
---@param opts any Don't know yet :)
M.setup = function(opts)
	opts = opts or {}

	vim.api.nvim_create_user_command("OrtiTestFind", find_test_files, {})
	vim.api.nvim_create_user_command("OrtiTestRun", run_test_file, {})
end

M.setup()

return M
