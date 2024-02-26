-- Abstraction over abstraction? believe it or not, is just because I am lazy
--

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values

local M = {}

M.make_list = function(title, list, select_callback)
	title = title or ""

	local get_pickers = function(opts)
		local picker_overrides = {
			prompt_title = title,
			finder = finders.new_table({
				results = list,
			}),
			sorter = conf.generic_sorter(opts), -- OPTS should be here, find way to pass it through
		}

		if select_callback then
			picker_overrides.attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					select_callback(selection[1])
				end)
				return true
			end
		end

		return picker_overrides
	end

	return {
		call = function(opts)
			opts = opts or {}
			pickers.new(opts, get_pickers(opts)):find()
		end,
	}
end

return M
