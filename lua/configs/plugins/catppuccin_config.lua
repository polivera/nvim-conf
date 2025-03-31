local M = {}

M.setup_plugin = function()
  require("catppuccin").setup({
    flavor = "mocha",
    integrations = {
      telescope = {
        enabled = true,
      },
    },
  })
  vim.cmd([[colorscheme catppuccin]])
end

return M
