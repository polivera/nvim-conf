return {
	config = function(lua_lsp_server)
		lua_lsp_server.setup({
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
						missing_parameters = false,
					},
					completion = {
						callSnippet = "Replace",
					},
					workspace = {
						-- library setting is handle by neodev plugin
						-- Stop anoying luassert message
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
						},
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
}
