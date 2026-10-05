-- Buffer-local git keymaps (gitsigns on_attach), same keys as before.
local M = {}

function M.gitsigns(bufnr)
	local gs = require("gitsigns")
	local function o(desc, extra)
		return vim.tbl_extend("force", { buffer = bufnr, desc = desc }, extra or {})
	end
	local function nav(key, dir)
		return function()
			if vim.wo.diff then
				return key
			end
			vim.schedule(function()
				gs.nav_hunk(dir)
			end)
			return "<Ignore>"
		end
	end
	vim.keymap.set("n", "]g", nav("]g", "next"), o("git: Goto next hunk", { expr = true }))
	vim.keymap.set("n", "[g", nav("[g", "prev"), o("git: Goto prev hunk", { expr = true }))
	vim.keymap.set("n", "<leader>gs", gs.stage_hunk, o("git: Toggle staging of hunk"))
	vim.keymap.set("v", "<leader>gs", function()
		gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, o("git: Toggle staging of selected hunk"))
	vim.keymap.set("n", "<leader>gr", gs.reset_hunk, o("git: Reset hunk"))
	vim.keymap.set("v", "<leader>gr", function()
		gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, o("git: Reset hunk"))
	vim.keymap.set("n", "<leader>gR", gs.reset_buffer, o("git: Reset buffer"))
	vim.keymap.set("n", "<leader>gp", gs.preview_hunk, o("git: Preview hunk"))
	vim.keymap.set("n", "<leader>gb", function()
		gs.blame_line({ full = true })
	end, o("git: Blame line"))
	vim.keymap.set({ "o", "x" }, "ih", gs.select_hunk, o())
end

return M
