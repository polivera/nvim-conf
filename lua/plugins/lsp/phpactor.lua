return {
  config = function(php_lsp_server)
    php_lsp_server.setup({
      init_options = {
        ["language_server_phpstan.enabled"] = false,
        ["language_server_psalm.enabled"] = false,
        ["xdebug_disable"] = false,
      }
    })
  end
}
