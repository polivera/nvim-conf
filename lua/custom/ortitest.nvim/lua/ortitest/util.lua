local U = {}

local CURRENT_BUFF_ID = 0

---Get current file name and extension
---@return string
U.get_current_file_name = function()
	return vim.api.nvim_buf_get_name(CURRENT_BUFF_ID):match("^.+/(.+)[.].*$")
end

U.get_current_file_extension = function()
	return vim.api.nvim_buf_get_name(CURRENT_BUFF_ID):match("^.+(%..+)$")
end

U.get_current_file_name_and_extension = function()
	return vim.api.nvim_buf_get_name(CURRENT_BUFF_ID):match("^.+/(.+)$")
end

---Get current file path
---@return string
U.get_current_file_path = function()
	return vim.api.nvim_buf_get_name(CURRENT_BUFF_ID):match("(.*/)")
end

---Return a list of the files in the <path> directory
---@param path string
---@return table
U.scan_dir = function(path)
	local result = {}
	local command = "ls %s"
	local filelist = assert(io.popen(string.format(command, path)), "r")
	for fl in filelist:lines() do
		table.insert(result, fl)
	end
	filelist:close()
	return result
end

return U
