local ortidebug = require("ortidebug")
ortidebug.reload_module("ortiutils.telescope")

local tele = require("ortiutils.telescope")

tele.make_list("some title", { "this", "is", "Sparta" }, function(selection)
	print(selection[1])
end).call({})
