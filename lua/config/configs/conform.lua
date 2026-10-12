return function()
	require("conform").setup({
		-- Use these when installed (:Mason); otherwise fall back to the LSP formatter.
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			sh = { "shfmt" },
		},
		default_format_opts = { lsp_format = "fallback", timeout_ms = 1000 },
	})
end
