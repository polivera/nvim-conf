local M = {}

M.setup_eventer = function(opts)
  opts = opts or {}

  local conf = {
    -- TODO: I should do a merge here instead of replacing
    ["*.c"] = { "clang-format -i --style=LLVM ###file###" },
    ["*.h"] = { "clang-format -i --style=LLVM ###file###" },
    ["*.zig"] = { "zig fmt ###file###" },
    ["*.lua"] = { "stylua ###file###" },
    ["*.go"] = { "goimports-reviser -rm-unused -set-alias -format ###file###" },
    ["*.templ"] = { "templ fmt ###file### && templ generate -f ###file###" },
    ["*.json"] = { "prettier -w ###file###" },
    ["*.js"] = { "prettier -w ###file###" },
    ["*.css"] = { "prettier -w ###file###" },
    ["*.scss"] = { "prettier -w ###file###" },
    ["*.html"] = { "prettier -w ###file###" },
    ["*.yaml"] = { "prettier -w ###file###" },
    ["*.vue"] = { "prettier -w ###file###" },
    ["*.sh"] = { "shfmt -l -w ###file###" },
    ["*.php"] = { "php-cs-fixer fix ###file### --rules=@PSR12" },
    ["*.proto"] = { "clang-format -i ###file###" },
  }
  conf = vim.tbl_extend("force", conf, opts)
  require("eventer").setup(conf)
end

return M
