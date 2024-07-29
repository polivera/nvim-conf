local M = {}

---Check if given window exist
---@param winid number
---@return boolean
M.window_exist = function(winid)
	return winid and vim.api.nvim_win_is_valid(winid)
end

---Create a vertical split and get the window ID
---@return integer winid
M.vsplit = function(winid)
	if winid and M.window_exist(winid) then
		return winid
	end
	vim.cmd("vsplit")
	return vim.api.nvim_get_current_win()
end

return M
