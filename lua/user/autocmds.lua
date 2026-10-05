local au = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("UserAutocmds", { clear = true })

au("BufWritePre", {
	group = group,
	pattern = { "*~", "/tmp/*", "*.tmp", "*.bak", "MERGE_MSG", "description", "COMMIT_EDITMSG" },
	command = "setlocal noundofile",
})
au("TextYankPost", { group = group, callback = function() vim.hl.on_yank({ timeout = 300 }) end })
au("FocusGained", { group = group, command = "checktime" })
au("VimResized", { group = group, command = "tabdo wincmd =" })
au("FileType", { group = group, command = "setlocal formatoptions-=cro" })
au("FileType", { group = group, pattern = "markdown", command = "setlocal wrap" })
au("FileType", {
	group = group,
	pattern = { "qf", "help", "man" },
	callback = function(e)
		vim.keymap.set("n", "q", "<Cmd>close<CR>", { buffer = e.buf, silent = true })
	end,
})
au("BufReadPost", {
	group = group,
	callback = function()
		local m = vim.api.nvim_buf_get_mark(0, '"')
		if m[1] > 0 and m[1] <= vim.api.nvim_buf_line_count(0) then
			pcall(vim.api.nvim_win_set_cursor, 0, m)
		end
	end,
})

au("LspAttach", {
	group = group,
	callback = function(e)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = e.buf, desc = "lsp: Goto definition" })
	end,
})
