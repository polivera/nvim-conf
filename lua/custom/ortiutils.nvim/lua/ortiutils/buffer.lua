local M = {}

---Check if the given window handler exist
---@param winid? integer
---@return boolean
M.does_window_exist = function(winid)
	print("param" .. winid)
	if winid then
		local win_list = vim.api.nvim_list_wins()
		for _, val in ipairs(win_list) do
			print(val)
			if val == winid then
				return true
			end
		end
	end
	return false
end

M.does_buffer_exist = function(bufnr)
	return bufnr and vim.fn.bufexists(bufnr) == 1
end

---Create a new scratch buffer on a vertical split
---If the winid is invalid it will create a new window and return an updated ID
---@param content string
---@param bufnr? integer
---@param winid? integer
---@return table
M.new_vsplit_scratch = function(content, bufnr, winid)
	if not winid or not M.does_window_exist(winid) then
		vim.cmd("vsplit")
		winid = vim.api.nvim_get_current_win()
	end
	if not bufnr or not M.does_buffer_exist(bufnr) then
		bufnr = vim.api.nvim_create_buf(false, true)
	end
	vim.api.nvim_win_set_buf(winid, bufnr)
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { content })
	return {
		bufnr = bufnr,
		winid = winid,
	}
end

M.append_content_to_buf = function(bufnr, content)
	if type(content) ~= "table" then
		content = { content }
	end
	vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, content)
end

return M
