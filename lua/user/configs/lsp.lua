return function()
	require("mason").setup({ ui = { border = "single" } })

	-- Servers installed through Mason are enabled automatically.
	require("mason-lspconfig").setup({ automatic_enable = true })

	-- Completion capabilities for every server; errors are shown by tiny-inline-diagnostic.
	vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })
	vim.diagnostic.config({ virtual_text = false, signs = true, underline = true, update_in_insert = false })
end
