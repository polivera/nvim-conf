local M = {}

---Get treesitter root node
---@param file_type string file_type of buffer
---@param bufnr number buffer identifier
---@return TSNode
M.get_root = function(file_type, bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local parser = vim.treesitter.get_parser(bufnr, file_type, {})
	local tree = parser:parse()[1]
	return tree:root()
end

local laa = M.get_root("go", 24)

print(vim.inspect(laa))

return M
