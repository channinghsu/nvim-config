local function search(collection)
	return function()
		require("search").open({ collection = collection })
	end
end

return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile", "NvimTreeRefresh" },
		keys = {
			{ "<C-n>", "<Cmd>NvimTreeToggle<CR>", desc = "filetree: Toggle" },
			{ "<leader>e", "<Cmd>NvimTreeToggle<CR>", desc = "filetree: Toggle" },
			{ "<leader>nf", "<Cmd>NvimTreeFindFile<CR>", desc = "filetree: Find file" },
			{ "<leader>nr", "<Cmd>NvimTreeRefresh<CR>", desc = "filetree: Refresh" },
		},
		config = require("user.configs.nvim-tree"),
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"jvgrootveld/telescope-zoxide",
			"nvim-telescope/telescope-live-grep-args.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "ayamir/search.nvim", config = require("user.configs.search") },
		},
		keys = {
			{ "<leader>fc", function()
				local tabs = require("search.tabs")
				local actions = require("telescope.actions")
				local state = require("telescope.actions.state")
				local theme = require("telescope.themes").get_dropdown()
				require("telescope.pickers").new(theme, {
					prompt_title = "Telescope Collections",
					finder = require("telescope.finders").new_table({ results = vim.tbl_keys(tabs.collections) }),
					sorter = require("telescope.config").values.generic_sorter(theme),
					attach_mappings = function(bufnr)
						actions.select_default:replace(function()
							actions.close(bufnr)
							require("search").open({ collection = state.get_selected_entry()[1] })
						end)
						return true
					end,
				}):find()
			end, desc = "tool: Open Telescope collections" },
			{ "<leader>ff", search("file"), desc = "tool: Find files" },
			{ "<leader>fp", search("pattern"), desc = "tool: Find patterns" },
			{ "<leader>fg", search("git"), desc = "tool: Locate Git objects" },
			{ "<leader>fd", search("dossier"), desc = "tool: Retrieve dossiers" },
			{ "<leader>fm", search("misc"), desc = "tool: Miscellaneous" },
			{ "<leader>fw", function() require("telescope").extensions.live_grep_args.live_grep_args() end, desc = "find: Word in project" },
			{ "<leader>fs", "<Cmd>Telescope grep_string<CR>", desc = "tool: Find word under cursor" },
			{ "<leader>fe", "<Cmd>Telescope oldfiles<CR>", desc = "find: File by history" },
			{ "<leader>fz", "<Cmd>Telescope zoxide list<CR>", desc = "edit: Change current directory by zoxide" },
			{ "<leader>fr", "<Cmd>Telescope resume<CR>", desc = "tool: Resume last search" },
			{ "<C-p>", "<Cmd>Telescope keymaps<CR>", desc = "tool: Toggle command panel" },
		},
		config = require("user.configs.telescope"),
	},
	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm" },
		config = function()
			require("toggleterm").setup({ size = 20, shade_terminals = false, float_opts = { border = "curved" } })
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = require("user.configs.which-key"),
	},
}
