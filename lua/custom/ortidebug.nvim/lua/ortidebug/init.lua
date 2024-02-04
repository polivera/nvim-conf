local M = {}

M.reload_module = function(modulename)
	local found = false
	for loadedmodule, _ in pairs(package.loaded) do
		if string.match(loadedmodule, modulename) then
			package.loaded[loadedmodule] = nil
			found = true
			break
		end
	end

	if not found then
		print(string.format("can't reload module %s", modulename))
	end
end

M.debug_print = function(param)
	for key, val in pairs(param) do
		print(string.format("%s: %s", key, val))
	end
end

return M
