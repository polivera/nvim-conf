local M = {}

---Get treesitter root node
---@param bufnr number buffer identifier
---@param file_type string file_type of buffer
---@return TSNode
M.get_root = function(bufnr, file_type)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local parser = vim.treesitter.get_parser(bufnr, file_type, {})
	local tree = parser:parse()[1]
	return tree:root()
end

M.exec_query = function(bufnr, file_type, query)
	local ts_sql = vim.treesitter.query.parse(file_type, query)
	local ts_root = M.get_root(bufnr, file_type)
	local results = {}

	for _, node in ts_sql:iter_captures(ts_root, bufnr, 0, -1) do
		table.insert(results, vim.treesitter.get_node_text(node, bufnr, {}))
	end
	return results
end

local laa = M.get_root(25, "go")

print(vim.inspect(laa))

return M
