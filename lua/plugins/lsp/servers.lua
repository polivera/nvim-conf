return {
  clangd = {},
  gopls = {
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = false,
        buildFlags = { "-tags=unit,integration,e2e,wireinject" },
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        gofumpt = false,
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },
  bashls = {},
  phpactor = {},
  elixirls = {
    cmd = { "elixir-ls" },
    settings = {
      elixirLS = {
        -- Optional settings
        dialyzerEnabled = true,
        fetchDeps = false,
        enableTestLenses = true,
        suggestSpecs = true,
      },
    },
  },
}
