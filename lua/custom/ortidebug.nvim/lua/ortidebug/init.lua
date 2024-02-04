local M = {}

M.reload_module = function(modulename)
	for loadedmodule, _ in pairs(package.loaded) do
		if string.match(loadedmodule, modulename) then
			package.loaded[loadedmodule] = nil
			break
		end
	end
end

M.debug_print = function(param)
	for key, val in pairs(param) do
		if type(val) == "table" then
			return M.debug_print(val)
		end
		print(string.format("%s: %s", key, val))
	end
end

return M
