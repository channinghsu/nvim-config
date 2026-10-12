return function()
	require("nvim-treesitter").setup({})
	require("nvim-treesitter").install({
		"bash", "c", "cpp", "css", "go", "html", "javascript", "json", "lua", "make",
		"markdown", "markdown_inline", "python", "rust", "toml", "typescript", "vim", "vimdoc", "yaml",
	})

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
		callback = function(args)
			if pcall(vim.treesitter.start, args.buf) then
				vim.wo[0][0].foldmethod = "expr"
				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end,
	})
end
