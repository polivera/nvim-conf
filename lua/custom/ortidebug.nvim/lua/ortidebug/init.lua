local M = {}

M.reload_module = function(modulename)
	for loadedmodule, _ in pairs(package.loaded) do
		if string.match(loadedmodule, modulename) then
			package.loaded[loadedmodule] = nil
			break
		end
	end
end

M.debug_print = function(param, depth)
	if not param then
		print("nothing to print here")
		return
	end
	depth = depth or 0
	if depth > 10 then
		print("max recursion exceeded")
		return
	end
	depth = depth + 1
	for key, val in pairs(param) do
		if type(val) == "table" then
			return M.debug_print(val, depth)
		end
		print(string.format("%s: %s", key, val))
	end
end

return M
