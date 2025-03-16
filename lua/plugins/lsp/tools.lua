-- Formatters and linters to install with Mason

-- Define formatters and linters to install
return {
  -- Formatters
  "stylua", -- Lua formatter
  "goimports-reviser", -- Go formatting script
  "prettier", -- For JS/TS/JSON/YAML/etc
  "shfmt", -- Shell formatter
  "php-cs-fixer", -- PHP formatter

  -- Linters
  "golangci-lint", -- Go linter
  "shellcheck", -- Shell linter
  "phpstan", -- PHP linter

  -- DAP (Debug Adapter Protocol) servers
}
