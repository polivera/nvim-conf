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

---Query treesiter
---@param file_type string
---@param query string
---@return vim.treesitter.Query
M.query = function(file_type, query)
	return vim.treesitter.query.parse(file_type, query)
end

---Capture entries using query and loop through each capture calling
---callback function
---@param file_type string
---@param bufnr integer
---@param query string
---@param callback (fun(id:integer, node:TSNode, name: string))
M.capture_and_iter = function(file_type, bufnr, query, callback)
	local root = M.get_root(file_type, bufnr)
	local emb_sql = M.query(file_type, query)
	for id, node in emb_sql:iter_captures(root, bufnr, 0, -1) do
		callback(id, node, emb_sql.captures[id])
	end
end

---Get the content of the given node
---@param node TSNode
---@param bufnr integer
---@return string
M.get_content = function(node, bufnr)
	return vim.treesitter.get_node_text(node, bufnr)
end

return M
