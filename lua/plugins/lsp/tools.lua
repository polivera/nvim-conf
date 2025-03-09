-- Formatters and linters to install with Mason

-- Define formatters and linters to install
return {
    -- Formatters
    "stylua",         -- Lua formatter
    "gosimports",        -- Go formatter (stricter than gofmt)
    "prettier",       -- For JS/TS/JSON/YAML/etc
    "shfmt",          -- Shell formatter
    "phpcsfixer",     -- PHP formatter

    -- Linters
    "golangci-lint",  -- Go linter
    "shellcheck",     -- Shell linter
    "phpstan",        -- PHP linter

    -- DAP (Debug Adapter Protocol) servers
}