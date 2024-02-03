local U = {}

local CURRENT_BUFF_ID = 0

U.getcurrentfilename = function()
	return vim.api.nvim_buf_get_name(CURRENT_BUFF_ID):match("^.+/(.+)$")
end

U.getcurrentfilepath = function()
	return "something"
end

return U
