-- Language servers are installed with :Mason and enabled automatically.
return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		config = require("user.configs.lsp"),
	},
	{
		"mason-org/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
		lazy = true,
		opts = { ui = { border = "single" } },
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = require("user.configs.tiny-inline-diagnostic"),
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		lazy = true,
		event = { "InsertEnter", "CmdlineEnter" },
		config = require("user.configs.blink"),
	},
	{
		"stevearc/conform.nvim",
		cmd = "ConformInfo",
		keys = {
			{ "<A-S-f>", function() require("conform").format() end, desc = "formatter: Format buffer" },
		},
		config = require("user.configs.conform"),
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = require("user.configs.treesitter"),
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufNewFile" },
		opts = { max_lines = 3, trim_scope = "outer", mode = "cursor" },
	},
}
