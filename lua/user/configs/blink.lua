return function()
	require("blink.cmp").setup({
		keymap = {
			preset = "none",
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
			["<C-d>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-w>"] = { "cancel", "fallback" },
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<CR>"] = { "accept", "fallback" },
		},
		appearance = { nerd_font_variant = "normal" },
		fuzzy = { implementation = "prefer_rust_with_warning" },
		sources = { default = { "lsp", "path", "snippets", "buffer" } },
		cmdline = { enabled = true },
		completion = {
			list = { max_items = 120, selection = { preselect = false, auto_insert = false } },
			menu = { border = "single", scrollbar = false },
			documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "single" } },
		},
		signature = { enabled = true, window = { border = "single" } },
	})
end
