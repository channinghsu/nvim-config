return function()
	-- Install and enable the language servers used by the previous profile.
	require("mason-lspconfig").setup({
		ensure_installed = { "bashls", "clangd", "gopls", "html", "jsonls", "lua_ls", "ruff", "pyrefly" },
		automatic_enable = true,
	})

	-- Completion capabilities for every server; errors are shown by tiny-inline-diagnostic.
	vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })
	vim.diagnostic.config({ virtual_text = false, signs = true, underline = true, update_in_insert = false })
end
