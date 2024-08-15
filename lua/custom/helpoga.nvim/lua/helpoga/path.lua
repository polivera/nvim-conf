if os.getenv("XAP_DEBUG") == "true" then
	package.loaded["helpoga.buffer"] = nil
end

local M = {}

M.placeholder = {
	RELPATH = "###relativepath###",
	ABSPATH = "###absolutepath###",
	FILENAME = "###filename###",
}

local buf_helper = require("helpoga.buffer")

local mapFuncs = {
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

M.replace_all_on_path = function(path)
	for _, replace_func in ipairs(mapFuncs) do
		path = replace_func(path)
	end
	return path
end

print(M.replace_all_on_path("some ###relativepath### of ###absolutepath### that has the file ###filename###"))

return M
