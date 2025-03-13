if os.getenv("XAP_DEBUG") == "true" then
	package.loaded["helpoga.buffer"] = nil
end

local buf_helper = require("helpoga.buffer")

---Return table
local M = {}

---Search the position of the first encouter of needle_char from star_pos
---to the start of the string.
---If needle_char is not found, it will return -1.
---@param str string
---@param needle_char string
---@param star_pos integer
---@return integer
M.search_char_pos_backward = function(str, needle_char, star_pos)
	for i = star_pos, 1, -1 do
		if str:sub(i, i) == needle_char then
			return i
		end
	end
	return -1
end

return M
