local function setup_plugin()
  -- Setup lsp kind
  local lspkind = require("lspkind")
  lspkind.init({})

  local cmp = require("cmp")

  cmp.setup({
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "path" },
      { name = "buffer" },
    },
    mapping = {
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-n>"] = cmp.mapping(
        cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
        { "i", "c" }
      ),
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
  })

  -- Config luasnip
  local ls = require("luasnip")
  ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
  })

  -- Load snippets from folder
  for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
    loadfile(ft_path)()
  end

  vim.keymap.set({ "i", "s" }, "<c-n>", function()
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, { silent = true })

  vim.keymap.set({ "i", "s" }, "<c-p>", function()
    if ls.expand_or_jumpable(-1) then
      ls.expand_or_jump(-1)
    end
  end, { silent = true })
end

return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",
    },
    config = setup_plugin,
  },
}
