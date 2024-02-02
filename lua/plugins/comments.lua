--
-- Comment Plugin
-- @see https://github.com/numToStr/Comment.nvim
--

local comment_config = function(_, _)
	require("Comment").setup()
end

return {
	"numToStr/Comment.nvim",
	lazy = false,
	config = comment_config,
}
