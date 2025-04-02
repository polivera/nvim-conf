return {
  clangd = {},
  zls = {},
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
  volar = {
    filetypes = {
      "typescript",
      "javascript",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "json",
    },
    init_options = {
      typescript = {
        tsdk = vim.fn.expand(
          "~/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib"
        ),
      },
      vue = {
        hybridMode = false,
      },
    },
  },
  tailwindcss = {
    root_dir = require("lspconfig.util").root_pattern(
      "tailwind.config.js",
      "tailwind.config.cjs",
      "tailwind.config.mjs",
      "tailwind.config.ts",
      "package.json",
      ".git"
    ),
  },
  -- TypeScript
  ts_ls = {},
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
