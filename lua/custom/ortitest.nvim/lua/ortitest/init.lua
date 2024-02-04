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

-- Return module
local M = {}

M.setup = function(opts)
	opts = opts or {}

	local curr_file_ext = util.get_current_file_extension()

	if not conf_map[curr_file_ext] then
		print(string.format("extension %s not found", curr_file_ext))
		return
	end

	local runner = conf_map[curr_file_ext]:new()
	local asdf = runner:find_test_files()
	print("== about to print result ==")
	vim.g.ortidebug.debug_print(asdf)

	-- Here we select the config based on the file type
end

M.setup()

return M
