if os.getenv("XAP_DEBUG") == "true" then
	package.loaded["helpoga.window"] = nil
end

local window = require("helpoga.window")

---Return table
local M = {}

---Check if current buffer exist
---@param buffer_name string
---@return boolean
M.buffer_exist = function(buffer_name)
	return buffer_name and vim.fn.bufexists(buffer_name) == 1
end

---Get buffer information from name
---@param buffer_name string
---@return vim.fn.getbufinfo.ret.item | nil
M.get_buffer_info = function(buffer_name)
	if buffer_name == "" then
		return nil
	end
	return vim.fn.getbufinfo(buffer_name)[1]
end

---Get current buffnr
---(another function that I never remember)
---@return integer
M.get_current_buffer_number = function()
	return vim.api.nvim_get_current_buf()
end

---Get new buffer or get existing one if buffer with buffer_name exist
---@param buf_name string
---@param is_scratch boolean
---@param show_in_list boolean
---@return integer bufnr
---@return string buf_name
M.get_buffer = function(buf_name, is_scratch, show_in_list)
	-- Get buffer information from buffer name
	local bufinfo = M.get_buffer_info(buf_name)
	if bufinfo ~= nil then
		return bufinfo.bufnr, buf_name
	end
	-- this return 0 on error
	local bufnr = vim.api.nvim_create_buf(show_in_list or true, is_scratch or true)
	if bufnr ~= 0 and buf_name ~= "" then
		vim.api.nvim_buf_set_name(bufnr, buf_name)
	end
	return bufnr, buf_name
end

--- Creates a new scratch buffer
---@param buf_name string
---@param show_in_list boolean
---@return integer bufnr
---@return string buf_name
M.get_scratch_buffer = function(buf_name, show_in_list)
	return M.get_buffer(buf_name, true, show_in_list)
end

---Put content on buffer
---@param content table | string
---@param bufnr integer
---@param buf_start? boolean
M.put_content_on_buffer = function(content, bufnr, buf_start)
	if type(content) ~= "table" then
		content = { content }
	end
	local line_start = buf_start and 0 or -1
	vim.api.nvim_buf_set_lines(bufnr, line_start, -1, false, content)
end

---Open a scratch buffer
---@param content string
---@param buffer_name string
---@param winid? number
---@param show_in_list? boolean
---@return integer winid
---@return integer bufnr
M.vscratch = function(content, buffer_name, winid, show_in_list)
	local bufnr = -1
	winid = window.vsplit(winid)
	bufnr, buffer_name = M.get_scratch_buffer(buffer_name, show_in_list or true)
	M.put_content_on_buffer(content, bufnr, true)
	vim.api.nvim_win_set_buf(winid, bufnr)
	return winid, bufnr
end

---Get given buffer file type
---@param bufnr integer
---@return string
M.get_buffer_file_type = function(bufnr)
	return vim.bo[bufnr].filetype
end

---Get current buffer file type
---@return string
M.get_current_buffer_file_type = function()
	return M.get_buffer_file_type(M.get_current_buffer_number())
end

return M
