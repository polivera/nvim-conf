local M = {}

M.reloadmodule = function(modulename)
	for loadedmodule, _ in pairs(package.loaded) do
		if string.match(loadedmodule, modulename) then
			package.loaded[loadedmodule] = nil
		end
	end
end

M.debugprint = function(param)
	for key, val in pairs(param) do
		print(string.format("%s: %s", key, val))
	end
end

return M
