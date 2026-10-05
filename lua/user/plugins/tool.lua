local function search(collection)
	return function()
		require("search").open({ collection = collection })
	end
end

local function chat_key(key, command, desc, mode)
	return { "<leader>" .. key, "<Cmd>CopilotChat" .. command .. "<CR>", desc = desc, mode = mode }
end

local function dap_key(key, method, desc)
	return { key, function() require("dap")[method]() end, desc = desc }
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
		"monaqa/dial.nvim",
		keys = {
			{ "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "dial: Increment" },
			{ "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "dial: Decrement" },
		},
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
					augend.semver.alias.semver,
					augend.constant.new({ elements = { "let", "const" } }),
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mason-org/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
		},
		keys = {
			dap_key("<leader>dd", "continue", "debug: Run/Continue"),
			dap_key("<leader>dj", "terminate", "debug: Stop"),
			dap_key("<leader>db", "toggle_breakpoint", "debug: Toggle breakpoint"),
			dap_key("<M-l>", "step_into", "debug: Step into"),
			dap_key("<M-k>", "step_out", "debug: Step out"),
			dap_key("<M-j>", "step_over", "debug: Step over"),
			dap_key("<F6>", "continue", "debug: Run/Continue"),
			dap_key("<F7>", "terminate", "debug: Stop"),
			dap_key("<F8>", "toggle_breakpoint", "debug: Toggle breakpoint"),
			dap_key("<F9>", "step_into", "debug: Step into"),
			dap_key("<F10>", "step_out", "debug: Step out"),
			dap_key("<F11>", "step_over", "debug: Step over"),
			dap_key("<leader>dc", "run_to_cursor", "debug: Run to cursor"),
			dap_key("<leader>dl", "run_last", "debug: Run last"),
			{ "<leader>do", function() require("dap").repl.open() end, desc = "debug: Open REPL" },
			{ "<leader>dC", function() require("dapui").close() end, desc = "debug: Close debug UI" },
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "codelldb", "delve", "python" },
				automatic_installation = true,
				handlers = {},
			})
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
			dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
			dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		build = "make tiktoken",
		cmd = {
			"CopilotChat", "CopilotChatOpen", "CopilotChatClose", "CopilotChatToggle", "CopilotChatStop",
			"CopilotChatReset", "CopilotChatSave", "CopilotChatLoad", "CopilotChatPrompts", "CopilotChatModels",
			"CopilotChatExplain", "CopilotChatReview", "CopilotChatFix", "CopilotChatOptimize", "CopilotChatDocs",
			"CopilotChatTests", "CopilotChatFixDiagnostic", "CopilotChatCommit", "CopilotChatCommitStaged",
		},
		keys = {
			chat_key("av", "Toggle", "AI: Toggle Copilot Chat"),
			chat_key("ar", "Reset", "AI: Reset conversation"),
			chat_key("as", "Stop", "AI: Stop response"),
			chat_key("al", "Load", "AI: Load conversation history"),
			chat_key("aS", "Save", "AI: Save conversation"),
			chat_key("aP", "Models", "AI: Select model"),
			chat_key("ap", "Prompts", "AI: Select prompt"),
			chat_key("ae", "Explain", "AI: Explain selection", "n"),
			chat_key("ae", "Explain", "AI: Explain selection", "v"),
			chat_key("aR", "Review", "AI: Review selection", "n"),
			chat_key("aR", "Review", "AI: Review selection", "v"),
			chat_key("af", "Fix", "AI: Fix selection", "n"),
			chat_key("af", "Fix", "AI: Fix selection", "v"),
			chat_key("ao", "Optimize", "AI: Optimize selection", "n"),
			chat_key("ao", "Optimize", "AI: Optimize selection", "v"),
			chat_key("ad", "Docs", "AI: Generate documentation", "n"),
			chat_key("ad", "Docs", "AI: Generate documentation", "v"),
			chat_key("at", "Tests", "AI: Write tests", "n"),
			chat_key("at", "Tests", "AI: Write tests", "v"),
			chat_key("ac", "Commit", "AI: Generate commit message"),
			chat_key("aC", "CommitStaged", "AI: Generate staged commit message"),
			chat_key("aF", "FixDiagnostic", "AI: Fix diagnostics"),
			{
				"<leader>aq",
				function()
					local question = vim.fn.input("Ask Copilot: ")
					if question ~= "" then
						require("CopilotChat").ask(question, { selection = require("CopilotChat.select").buffer })
					end
				end,
				desc = "AI: Ask about buffer",
			},
			{
				"<leader>aq",
				function()
					local question = vim.fn.input("Ask Copilot: ")
					if question ~= "" then
						require("CopilotChat").ask(question, { selection = require("CopilotChat.select").visual })
					end
				end,
				mode = "v",
				desc = "AI: Ask about selection",
			},
		},
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "zbirenbaum/copilot.lua" },
		config = require("user.configs.copilot-chat"),
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = require("user.configs.which-key"),
	},
}
