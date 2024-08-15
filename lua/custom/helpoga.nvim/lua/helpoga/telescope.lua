local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values

---Create a list and return a callable function
---@param title string
---@param list table<string>
---@param callback fun(selection:string)
---@return fun(opts?: table)
M.make_list = function(title, list, callback)
	title = title or ""

	local get_pickers = function(opts)
		local picker_overrides = {
			prompt_title = title,
			finder = finders.new_table({
				results = list,
			}),
			sorter = conf.generic_sorter(opts),
		}

		if callback then
			picker_overrides.attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					callback(selection[1])
				end)
				return true
			end
		end

		return picker_overrides
	end

	return function(opts)
		opts = opts or {}
		pickers.new(opts, get_pickers(opts)):find()
	end
end

---Open telescope with the given list
---@param title string
---@param list table<string>
---@param callback fun(selection:string)
---@param opts? table
M.show_list = function(title, list, callback, opts)
	M.make_list(title, list, callback)(opts)
end

return M
