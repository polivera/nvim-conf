-- Define formatters and linters to install / use
local M = {}

M.tools = {
  formatters = {
    lua = "stylua",
    go = "goimports-reviser",
    javascript = "prettier",
    typescript = "prettier",
    yaml = "prettier",
    sh = "shfmt",
    php = "php-cs-fixer",
    -- vue = "prettier",
  },

  linters = {
    go = "golangci-lint",
    sh = "shellcheck",
    bash = "shellcheck",
    php = "phpstan",
    lua = "luacheck",
    vue = "eslint_d",
    javascript = "eslint_d",
    typescript = "eslint_d",
  },

  dap = {},
}

M.get_list = function()
  local tool_list = {}
  local result = {}
  for k in pairs(M.tools) do
    for _, value in pairs(M.tools[k]) do
      if not tool_list[value] then
        tool_list[value] = true
      end
    end
  end

  for k in pairs(tool_list) do
    table.insert(result, k)
  end

  return result
end

return M
