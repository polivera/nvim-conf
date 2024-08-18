if os.getenv("XAP_DEBUG") == "true" then
	package.loaded["helpoga.buffer"] = nil
end

local M = {}

M.placeholder = {
	RELPATH = "###relativepath###",
	ABSPATH = "###absolutepath###",
	FILENAME = "###filename###",
	TEST = "###test###",
}

local buf_helper = require("helpoga.buffer")

local no_param_func_map = {
	function(path)
		return string.gsub(path, M.placeholder.RELPATH, buf_helper.get_current_buffer_file_path())
	end,
	function(path)
		return string.gsub(path, M.placeholder.ABSPATH, buf_helper.get_current_buffer_full_path())
	end,
	function(path)
		return string.gsub(path, M.placeholder.FILENAME, buf_helper.get_current_buffer_file_name())
	end,
}

---Call all placeholder replace functions that have no param
---@param path string
---@return string
M.replace_no_param = function(path)
	for _, replace_func in ipairs(no_param_func_map) do
		path = replace_func(path)
	end
	return path
end

---Replace test placeholder for the given test
---@param str string
---@param test string
---@return string
M.replace_test = function(str, test)
	local replaced = string.gsub(str, M.placeholder.TEST, test)
	return replaced
end

return M
