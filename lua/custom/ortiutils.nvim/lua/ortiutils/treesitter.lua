local M = {}

M.get_root = function(lang, bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local parser = vim.treesitter.get_parser(bufnr, lang, {})
	local tree = parser:parse()[1]
	return tree:root()
end

return M
