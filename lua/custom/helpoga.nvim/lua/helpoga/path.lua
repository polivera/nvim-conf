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

---Get the full path formed by the relative path and the path from the buffer.
---Example: if the buffer path is `/path/to/some/random/buffer.lua` and the relative path is
---`../new-buffer.lua` the result will be `/path/to/some/new-buffer.lua`.
---It will return nil if there was an error
---@param relative_path string
---@return string|nil - full path from the buffer
M.get_full_path_from_current_buffer = function(relative_path)
	local buffer_path = M.get_current_buffer_full_path()
	while relative_path:sub(0, 2) == "./" do
		relative_path = relative_path:sub(3)
	end
	while relative_path:sub(0, 3) == "../" and buffer_path ~= nil do
		relative_path = relative_path:sub(4)
		buffer_path = string.match(buffer_path, "(.*/)")
		if buffer_path ~= nil then
			buffer_path = buffer_path:sub(0, -2)
		end
	end
	if buffer_path == nil then
		return nil
	end
	local result_string = string.format("%s/%s", buffer_path, relative_path):gsub("//", "/")
	return result_string
end

return M
