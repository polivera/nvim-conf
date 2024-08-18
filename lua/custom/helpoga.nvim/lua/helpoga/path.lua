if os.getenv("XAP_DEBUG") == "true" then
end

---Return table
local M = {}

---Get buffer relative (to the project) path
---@param bufnr integer
---@return string
M.get_buffer_file_path = function(bufnr)
	return vim.fn.fnamemodify(vim.fn.bufname(bufnr), ":p:.:h")
end

---Get buffer full path
---@param bufnr integer
---@return string
M.get_buffer_full_path = function(bufnr)
	return vim.fn.fnamemodify(vim.fn.bufname(bufnr), ":p:h")
end

---Get file name of buffer <bufnr>
---@param bufnr integer
---@return string
M.get_buffer_file_name = function(bufnr)
	return vim.fn.fnamemodify(vim.fn.bufname(bufnr), ":t")
end

---Get relative path of the current buffer
---@return string
M.get_current_buffer_file_path = function()
	return M.get_buffer_file_path(M.get_current_buffer_number())
end

---Get full path of the current buffer
---@return string
M.get_current_buffer_full_path = function()
	return M.get_buffer_full_path(M.get_current_buffer_number())
end

---Get current buffer file name
---@return string
M.get_current_buffer_file_name = function()
	return M.get_buffer_file_name(M.get_current_buffer_number())
end

---Get the buffer file type
---(Yes, is a one liner, but I can never remember it)
---@return string
M.get_file_type = function()
	return vim.bo.filetype
end

return M
