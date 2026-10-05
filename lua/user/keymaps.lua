-- Keymaps (leader = <Space>).
local map = vim.keymap.set
local o = function(desc) return { silent = true, desc = desc } end

-- Save & quit
map("n", "<C-s>", "<Cmd>write<CR>", o("Save file"))
map("n", "<C-q>", "<Cmd>wq<CR>", o("Save and quit"))
map("n", "<A-S-q>", "<Cmd>q!<CR>", o("Force quit"))
map("n", "<leader>q", "<Cmd>qa!<CR>", o("Quit all without saving"))
map("i", "jk", "<Esc>:w<CR>", { silent = true, nowait = true, desc = "Save and leave insert" })
map("i", "<C-s>", "<Esc>:w<CR>", o("Save file"))
map("i", "<C-q>", "<Esc>:wq<CR>", o("Save and quit"))

-- Insert / command line
map("i", "<C-u>", "<C-G>u<C-U>")
map("i", "<C-b>", "<Left>")
map("i", "<C-a>", "<ESC>^i")
map("c", "<C-b>", "<Left>")
map("c", "<C-f>", "<Right>")
map("c", "<C-a>", "<Home>")
map("c", "<C-e>", "<End>")
map("c", "<C-d>", "<Del>")
map("c", "<C-h>", "<BS>")
map("c", "<C-t>", [[<C-R>=expand("%:p:h") . "/" <CR>]])

-- Visual
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Normal
map("n", "Y", "y$")
map("n", "D", "d$")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")
map("n", "<S-Tab>", "za", o("Toggle fold"))
map("n", "<Esc>", "<Cmd>nohlsearch<CR>", o("Clear search highlight"))
map("n", "<leader>i", "ggVG", o("Select all"))
map("n", "<leader>o", "<Cmd>setlocal spell! spelllang=en_us<CR>", o("Toggle spell check"))
map("n", "<leader>v", "<Cmd>vsplit<CR>", o("Vertical split"))

-- Tabs
map("n", "tn", "<Cmd>tabnew<CR>")
map("n", "tk", "<Cmd>tabnext<CR>")
map("n", "tj", "<Cmd>tabprevious<CR>")
map("n", "to", "<Cmd>tabonly<CR>")

-- Terminal
map("t", "<Esc><Esc>", [[<C-\><C-n>]])

-- Buffers
map("n", "L", "<Cmd>BufferLineCycleNext<CR>", { silent = true, nowait = true, desc = "buffer: Switch to next" })
map("n", "H", "<Cmd>BufferLineCyclePrev<CR>", { silent = true, nowait = true, desc = "buffer: Switch to prev" })
map("n", "<leader>x", "<Cmd>bdelete<CR>", o("which_key_ignore"))

-- Windows
map("n", "<A-H>", "<Cmd>wincmd h<CR>", o("window: Focus left"))
map("n", "<A-J>", "<Cmd>wincmd j<CR>", o("window: Focus down"))
map("n", "<A-K>", "<Cmd>wincmd k<CR>", o("window: Focus up"))
map("n", "<A-L>", "<Cmd>wincmd l<CR>", o("window: Focus right"))

-- Hop
map({ "n", "v" }, "<leader>w", "<Cmd>HopWordMW<CR>", o("jump: Goto word"))

-- Format selection with LSP
map("v", "<A-=>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
	vim.lsp.buf.format({
		async = true,
		range = { ["start"] = vim.api.nvim_buf_get_mark(0, "<"), ["end"] = vim.api.nvim_buf_get_mark(0, ">") },
	})
end, o("formatter: Format selected code"))

-- Git: lazygit in a floating terminal
local lazygit
map("n", "<leader>gg", function()
	if vim.fn.executable("lazygit") ~= 1 then
		return vim.notify("lazygit not found", vim.log.levels.ERROR)
	end
	lazygit = lazygit
		or require("toggleterm.terminal").Terminal:new({
			cmd = "lazygit",
			direction = "float",
			close_on_exit = true,
			hidden = true,
		})
	lazygit:toggle()
end, o("git: Toggle lazygit"))
