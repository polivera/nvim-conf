local EX = {}

local group

local filewildcard = "###file###"

-- What I need to do:
--  - Pass file wildcard
--  - Pass command to run

-- Replace the vars in the string for the needed information
---@param cmd string
---@return string
local replace_vars = function(cmd)
	local result = ""
	local currentfile = vim.fn.expand("<afile>:p")
	if string.find(cmd, filewildcard) then
		result = cmd:gsub(filewildcard, currentfile)
	else
		result = cmd .. " " .. currentfile
	end
	return result
end

---@param wilcard string
---@param commands table<string>
local set_autocmd = function(wilcard, commands)
	if not group then
		group = vim.api.nvim_create_augroup("ortiexec", { clear = true })
	end
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = group,
		pattern = wilcard,
		callback = function()
			-- Concatenate the final command here
			local exec_command = ""
			for _, cmd in ipairs(commands) do
				exec_command = exec_command .. replace_vars(cmd) .. ";"
			end

			if exec_command ~= "" then
				vim.fn.jobstart(exec_command, {
					on_exit = function()
						vim.api.nvim_command("checktime")
					end,
					on_stderr = function(_, data, _)
						if #data > 1 then
							print("[Error] in autocmd")
							for k, v in pairs(data) do
								print(k, " - ", v)
							end
						end
					end,
				})
			end
		end,
	})
end

-- Parameters: ~
--  • {params} Dictionary:
--      The key will be the wildcard to use in the auto_cmd
--      The value will be a list of commands to run
--      ```lua
--        local params = {
--          ["*.ext"] = {
--            "echo 'hello world'",
--            "echo 'goodbye'"
--          }
--        }
--      ```
--- @param params? table<string, table<string>>
EX.setup = function(params)
	params = params or {}
	for card, cmds in pairs(params) do
		set_autocmd(card, cmds)
	end
end

return EX
