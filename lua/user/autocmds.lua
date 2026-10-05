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
		local function map(modes, lhs, rhs, desc, extra)
			vim.keymap.set(modes, lhs, rhs, vim.tbl_extend("force", {
				buffer = e.buf,
				silent = true,
				desc = desc,
			}, extra or {}))
		end

		map("n", "K", "<Cmd>Lspsaga hover_doc<CR>", "lsp: Show doc")
		map("n", "gd", "<Cmd>Lspsaga peek_definition<CR>", "lsp: Preview definition")
		map("n", "gD", "<Cmd>Lspsaga goto_definition<CR>", "lsp: Goto definition")
		map("n", "gr", "<Cmd>Lspsaga rename<CR>", "lsp: Rename", { nowait = true })
		map("n", "gR", "<Cmd>Lspsaga rename ++project<CR>", "lsp: Rename in project")
		map({ "n", "v" }, "ga", "<Cmd>Lspsaga code_action<CR>", "lsp: Code action")
		map("n", "g[", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", "lsp: Prev diagnostic")
		map("n", "g]", "<Cmd>Lspsaga diagnostic_jump_next<CR>", "lsp: Next diagnostic")
		map("n", "<leader>lx", "<Cmd>Lspsaga show_line_diagnostics ++unfocus<CR>", "lsp: Line diagnostic")
		map("n", "gs", vim.lsp.buf.signature_help, "lsp: Signature help")
		map("n", "<leader>li", "<Cmd>LspInfo<CR>", "lsp: Info")
		map("n", "<leader>lr", "<Cmd>LspRestart<CR>", "lsp: Restart")
		map("n", "<leader>r", "<Cmd>make<CR>", "which_key_ignore")
		map("n", "<leader>c", "<Cmd>make clean<CR>", "which_key_ignore")
	end,
})
