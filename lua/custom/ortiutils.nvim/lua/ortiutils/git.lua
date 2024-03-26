local M = {}

---Get git root path
---@return string
M.get_git_root = function()
	-- git rev-parse --show-toplevel
	local fl = assert(io.popen("git rev-parse --show-toplevel", "r"))
	local res = assert(fl:read("*a"))
	fl:close()

	return res
end

return M
