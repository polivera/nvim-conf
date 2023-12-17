return {
  config = function(go_lsp_server)
    go_lsp_server.setup({
      settings = {
        ui = {
          completion = {
            usePlaceholders = true,
          },
        },
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
        },
      },
    })
  end,
}
