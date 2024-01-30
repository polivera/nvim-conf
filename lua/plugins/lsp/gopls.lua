return {
	config = function(go_lsp_server)
		go_lsp_server.setup({
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
					buildFlags = { "-tags=unit,integration,e2e" },
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
