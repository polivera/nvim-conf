if os.getenv("XAP_DEBUG") == "true" then
	package.loaded["helpoga.buffer"] = nil
end

---TODO: Better separate what is buffer and what is path helper

local buf_helper = require("helpoga.buffer")

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
	return M.get_buffer_file_path(buf_helper.get_current_buffer_number())
end

---Get full path of the current buffer
---@return string
M.get_current_buffer_full_path = function()
	return M.get_buffer_full_path(buf_helper.get_current_buffer_number())
end

---Get current buffer file name
---@return string
M.get_current_buffer_file_name = function()
	return M.get_buffer_file_name(buf_helper.get_current_buffer_number())
end

return M
