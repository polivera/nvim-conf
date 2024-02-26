if vim.g.ortidebug_mode then
	vim.g.ortidebug.reload_module("ortiutils.dir")
end
local dir = require("ortiutils.dir")

assert(dir.get_current_file_name(0) == "dir_test", "error on get_current_file")
assert(dir.get_current_file_path(0) ~= "", "error on get_current_file_name")
assert(dir.get_current_file_extension(0) == ".lua", "error on get_current_file_name")
assert(dir.get_current_file_name_and_extension(0) ~= "", "error on get_current_file_name")
