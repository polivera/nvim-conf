if vim.g.ortidebug_mode then
	vim.g.ortidebug.reload_module("ortiutils.dir")
	vim.g.ortidebug.reload_module("ortiutils.treesitter")
	vim.g.ortidebug.reload_module("ortitest.configs.common")
end

local util_dir = require("ortiutils.dir")
local util_treesitter = require("ortiutils.treesitter")
local common = require("ortitest.configs.common")

local default_test_pattern = ".*_test.go"
local default_unit_test_command = "go test -tags unit ###path### -v -run ###test###"

---@class GoConf:CommonConf
local GoConf = common:create()
GoConf.__parent = common

function GoConf:new(o)
	o = o or {}
	self:set_params({
		source_file_path = o.source_file_path or util_dir.get_current_file_path(),
		source_file_name = o.source_file_name or util_dir.get_current_file_name(),
		test_file_path = o.default_test_path or util_dir.get_current_file_path(),
		test_file_pattern = o.default_test_pattern or default_test_pattern,
		unit_test_command = o.unit_test_command or default_unit_test_command,
	})
	return self
end

---Get test package path
---@return string
function GoConf:get_test_package()
	-- Can search the package here
	return ""
end

function GoConf:get_test_methods_list()
	local bufnr = vim.api.nvim_get_current_buf()
	local ts_sql = vim.treesitter.query.parse(
		"go",
		[[
      (function_declaration
        name: (identifier) @func_name)
    ]]
	)
	local result_list = {}
	local root = util_treesitter.get_root("go")
	for _, node in ts_sql:iter_captures(root, bufnr, 0, -1) do
		table.insert(result_list, vim.treesitter.get_node_text(node, bufnr, {}))
	end
	return result_list
end

return GoConf
