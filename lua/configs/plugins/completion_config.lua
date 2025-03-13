local M = {}

M.setup_plugin = function()
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
      ["<C-n>"] = cmp.mapping(function(fallback)
        -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if not entry then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          end
          cmp.confirm()
        else
          fallback()
        end
      end, { "i", "s", "c" }),
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

  vim.keymap.set({ "i", "s" }, "<c-l>", function()
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, { silent = true })

  vim.keymap.set({ "i", "s" }, "<c-h>", function()
    if ls.expand_or_jumpable(-1) then
      ls.expand_or_jump(-1)
    end
  end, { silent = true })
end

return M
