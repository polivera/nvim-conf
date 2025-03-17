-- Define formatters and linters to install / use
local M = {}

M.tools = {
  formatters = {
    lua = "stylua", -- Lua formatter
    go = "goimports-reviser", -- Go formatting script
    javascript = "prettier", -- For JS/TS/JSON/YAML/etc
    typescript = "prettier",
    sh = "shfmt",
    php = "php-cs-fixer", -- PHP formatter
  },

  linters = {
    go = "golangci-lint", -- Go linter
    sh = "shellcheck", -- Shell linter
    bash = "shellcheck", -- Shell linter
    php = "phpstan", -- PHP linter
    lua = "luacheck", -- Lua linter
    javascript = "eslint_d", -- Javascript linter
    typescript = "eslint_d", -- Typescript linters
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
