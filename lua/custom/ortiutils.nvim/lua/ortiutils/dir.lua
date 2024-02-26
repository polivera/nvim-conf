local M = {}

M.get_current_file_name = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	return vim.api.nvim_buf_get_name(bufnr):match("^.+/(.+)[.].*$")
end

M.get_current_file_extension = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	return vim.api.nvim_buf_get_name(bufnr):match("^.+(%..+)$")
end

M.get_current_file_name_and_extension = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	return vim.api.nvim_buf_get_name(bufnr)
end

---Get current file path
---@return string
M.get_current_file_path = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	return vim.api.nvim_buf_get_name(bufnr):match("(.*/)")
end

---Return a list of the files in the <path> directory
---@param path string
---@return table
M.scan_dir = function(path)
	local result = {}
	local command = "ls %s"
	local filelist = assert(io.popen(string.format(command, path)), "r")
	for fl in filelist:lines() do
		table.insert(result, fl)
	end
	filelist:close()
	return result
end

return M
