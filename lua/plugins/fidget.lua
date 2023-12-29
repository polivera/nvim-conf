--
-- Fidget Plugin
-- @see https://github.com/j-hui/fidget.nvim
--
local fidget_config = function(_, _)
  require('fidget').setup({})
end

return {
  "j-hui/fidget.nvim",
  opts = {
    -- options
  },
  config = fidget_config,
}
