-- lspconfig
-- configuration for neovim lsp client
-- https://github.com/neovim/nvim-lspconfig

local lsp_keymaps = function(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<leader>lK", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<leader>lk", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
  vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>le", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
  vim.keymap.set("n", "<leader>ls", function()
    vim.diagnostic.open_float(nil, { focus = true })
  end)
end

-- Plugin loading function
local lsp_config = function(_, opts)
  local _ = require("neodev").setup({})
  local lspconfig = require("lspconfig")
  local ok_cmp, cmp_nvim = pcall(require, "cmp_nvim_lsp")

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
      -- Define variables
      -- This is just for easy access
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local lsp_defaults = lspconfig.util.default_config

      -- Set client capabilities
      -- dynamicRegistration suppose to help LSP to refresh its content when, for example,
      -- a new constant is added to an existing file (it doesn't work :smile:)
      lsp_defaults.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
      -- Merge capabilities with cmp_nvim_lsp
      if ok_cmp then
        lsp_defaults.capabilities = vim.tbl_deep_extend(
          "force",
          lsp_defaults.capabilities,
          cmp_nvim.default_capabilities()
        )
      end

      -- Set Server Capabilities
      if client.server_capabilities.completionProvider then
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
      end
      if client.server_capabilities.definitionProvider then
        vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
      end

      -- Enable completion triggered by <c-x><c-o>
      lsp_keymaps(bufnr)
    end,
  })

  for k, v in pairs(opts.servers) do
    v.config(lspconfig[k], lspconfig.util)
  end
end

-- Plugin definition
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/neodev.nvim",
  },
  opts = {
    servers = {
      lua_ls = require("plugins.lsp.luals"),
      gopls = require("plugins.lsp.gopls"),
      phpactor = require("plugins.lsp.phpactor"),
    },
    ignore_formatting = {
      lua_ls = true,
    },
  },
  config = lsp_config,
}
