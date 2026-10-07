-- Keymaps
-- leader = <Space>

local map = vim.keymap.set

local opts = function(desc)
	return {
		silent = true,
		desc = desc,
	}
end


-----------------------------------------------------------
-- Save / Quit
-----------------------------------------------------------

map("n", "<leader>q", "<Cmd>qa!<CR>", opts("Quit all without saving"))

map("i", "jk", "<Esc>:w<CR>", {
	silent = true,
	nowait = true,
	desc = "Save and leave insert",
})


-----------------------------------------------------------
-- Editing
-----------------------------------------------------------

-- Move selected lines
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Keep selection after indent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Better defaults
map("n", "Y", "y$")
map("n", "D", "d$")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")

-- Fold
map("n", "<S-Tab>", "za", opts("Toggle fold"))

-- Clear search
map("n", "<Esc>", "<Cmd>nohlsearch<CR>", opts("Clear search"))

-- Select all
map("n", "<leader>i", "ggVG", opts("Select all"))


-----------------------------------------------------------
-- Buffer
-----------------------------------------------------------

map(
	"n",
	"L",
	"<Cmd>BufferLineCycleNext<CR>",
	opts("Buffer next")
)

map(
	"n",
	"H",
	"<Cmd>BufferLineCyclePrev<CR>",
	opts("Buffer previous")
)

map(
	"n",
	"<leader>x",
	"<Cmd>bp<CR><Cmd>bd#<CR>",
	opts("Delete buffer")
)


-----------------------------------------------------------
-- Window
-----------------------------------------------------------

map("n", "<A-H>", "<Cmd>wincmd h<CR>", opts("Focus left"))
map("n", "<A-J>", "<Cmd>wincmd j<CR>", opts("Focus down"))
map("n", "<A-K>", "<Cmd>wincmd k<CR>", opts("Focus up"))
map("n", "<A-L>", "<Cmd>wincmd l<CR>", opts("Focus right"))


-----------------------------------------------------------
-- Navigation
-----------------------------------------------------------

map(
	{ "n", "v" },
	"<leader>w",
	"<Cmd>HopWordMW<CR>",
	opts("Hop word")
)


-----------------------------------------------------------
-- LSP
-----------------------------------------------------------

map("v", "<A-=>", function()
	vim.api.nvim_feedkeys(
		vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
		"n",
		false
	)

	vim.lsp.buf.format({
		async = true,
		range = {
			start = vim.api.nvim_buf_get_mark(0, "<"),
			["end"] = vim.api.nvim_buf_get_mark(0, ">"),
		},
	})
end, opts("Format selected code"))


-----------------------------------------------------------
-- Git
-----------------------------------------------------------

local lazygit

map("n", "<leader>gg", function()
	if vim.fn.executable("lazygit") ~= 1 then
		return vim.notify(
			"lazygit not found",
			vim.log.levels.ERROR
		)
	end

	lazygit = lazygit
		or require("toggleterm.terminal").Terminal:new({
			cmd = "lazygit",
			direction = "float",
			close_on_exit = true,
			hidden = true,
		})

	lazygit:toggle()
end, opts("Toggle lazygit"))


-----------------------------------------------------------
-- Lazy.nvim
-----------------------------------------------------------

map("n", "<leader>pp", "<Cmd>Lazy<CR>", opts("Open Lazy"))
map("n", "<leader>pu", "<Cmd>Lazy update<CR>", opts("Update Lazy"))
map("n", "<leader>pP", "<Cmd>Lazy profile<CR>", opts("Profile Lazy"))
