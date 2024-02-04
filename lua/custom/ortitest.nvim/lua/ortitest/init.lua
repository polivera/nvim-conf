if vim.g.ortidebugmode then
	vim.g.ortidebug.reload_module("ortitest.util")
	vim.g.ortidebug.reload_module("ortitest.go")
	vim.g.ortidebug.reload_module("ortitest.lua")
end

local util = require("ortitest.util")
local M = {}

local conf_map = {
	[".go"] = require("ortitest.configs.go"),
	[".lua"] = require("ortitest.configs.lua"),
}
local pepe = require("ortitest.configs.lua")

M.setup = function(opts)
	print(pepe:new())
	opts = opts or {}

	local curr_file_ext = util.get_current_file_extension()

	if not conf_map[curr_file_ext] then
		print(string.format("extension %s not found", curr_file_ext))
		return
	end

	local runner = conf_map[curr_file_ext]:new()
	-- local runner = conf_map[curr_file_ext]:new()
	vim.g.ortidebug.debug_print(runner:find_test_files())

	-- Here we select the config based on the file type
end

M.setup()

return M
