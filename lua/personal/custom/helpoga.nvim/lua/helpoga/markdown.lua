if os.getenv("XAP_DEBUG") == "true" then
	package.loaded["helpoga.string"] = nil
	package.loaded["helpoga.path"] = nil
end

local str_helper = require("helpoga.string")
local path_helper = require("helpoga.path")

---Return table
local M = {}

---Get the path of the markdown link under the cursor
---@return string|nil
local get_markdown_link = function()
	local line = vim.fn.getline(".")
	local cursor_col = vim.fn.col(".")
	local link_text_start_pos = str_helper.search_char_pos_backward(line, "[", cursor_col)
	if link_text_start_pos == -1 then
		return nil
	end
	local link_href_start_pos = string.find(line, "%(", link_text_start_pos) or -1
	if link_href_start_pos == -1 then
		return nil
	end
	local link_href_end_pos = string.find(line, "%)", link_href_start_pos) or -1

	if link_href_end_pos == -1 or cursor_col < link_text_start_pos or cursor_col > link_href_end_pos then
		return nil
	end

	return string.sub(line, link_href_start_pos + 1, link_href_end_pos - 1)
end

---Go to the markdown link. If it does not exist. Create it.
M.markdown_go_to_link = function()
	local markdown_link = get_markdown_link()
	if markdown_link == nil then
		return
	end
	local link = path_helper.get_full_path_from_current_buffer(markdown_link)
	if nil == link then
		print("cannot find link")
		return
	end
	local path = string.match(link, "(.*/)")
	vim.fn.mkdir(path, "p")
	vim.cmd("edit " .. link)
end

return M
