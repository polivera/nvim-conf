local M = {}

M.reload_module = function(modulename)
	for loadedmodule, _ in pairs(package.loaded) do
		if string.match(loadedmodule, modulename) then
			package.loaded[loadedmodule] = nil
		end
	end
end

M.debug_print = function(param)
	print("from here")
	print(param)
	for key, val in pairs(param) do
		print(string.format("%s: %s", key, val))
	end
end

return M
