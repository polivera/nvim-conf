local Eventer = {}

local pholders = {
	["###file###"] = function()
		-- <afile> is used because it will run on an autocmd
		return vim.fn.expand("<afile>:p")
	end,
}

local event_active = {}

local function replace_vars(cmd)
	for key, replace_func in pairs(pholders) do
		cmd = cmd:gsub(key, replace_func())
	end
	return cmd
end

local function set_autocmd(pattern, commands)
	local ev_group = vim.api.nvim_create_augroup("xap/eventer/" .. pattern, { clear = true })

	vim.api.nvim_create_autocmd("BufWritePost", {
		group = ev_group,
		pattern = pattern,
		callback = function()
			if not event_active[pattern] then
				return
			end

			-- Concatenate the final command here
			local exec_command = ""
			for _, cmd in ipairs(commands) do
				exec_command = exec_command .. replace_vars(cmd) .. ";"
			end

			if exec_command == "" then
				return
			end

			vim.fn.jobstart(exec_command, {
				on_exit = function()
					vim.api.nvim_command("checktime")
				end,
				on_stderr = function(_, data, _)
					if #data > 1 then
						print("[Error] in autocmd")
						for k, v in ipairs(data) do
							if v ~= "" then
								print(k, " - ", v)
							end
						end
					end
				end,
			})
		end,
	})
end

Eventer.setup = function(params)
	params = params or {}
	for fileType, commands in pairs(params) do
		set_autocmd(fileType, commands)
		event_active[fileType] = true
	end
end

return Eventer
