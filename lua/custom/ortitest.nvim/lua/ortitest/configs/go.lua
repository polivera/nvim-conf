local GoConf = {
	test = "some test",
}

GoConf.new = function()
	local self = setmetatable({}, GoConf)
	self.test = "something"

	return self
end

return GoConf
