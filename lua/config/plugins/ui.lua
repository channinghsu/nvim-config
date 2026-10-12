return {
    {
        "karb94/neoscroll.nvim",
        keys = { "<C-d>", "<C-u>"},
        opts = {},
    },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = require("config.configs.catppuccin"),
	},
	{
		"goolord/alpha-nvim",
        event = { "VimEnter", "BufEnter" },
		config = require("config.configs.alpha"),
	},
	{
		"akinsho/bufferline.nvim",
		event = { "BufReadPre", "BufAdd", "BufNewFile" },
		cmd = { "BufferLineCycleNext", "BufferLineCyclePrev", "BufferLineMoveNext", "BufferLineMovePrev", "BufferLineGoToBuffer" },
		config = require("config.configs.bufferline"),
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = require("config.configs.indent-blankline"),
	},
	{
		"smoka7/hop.nvim",
		version = "*",
		cmd = { "HopWordMW" },
		config = require("config.configs.hop"),
	},
	{
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		config = require("config.configs.lualine"),
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "CursorHold", "CursorHoldI" },
		config = require("config.configs.gitsigns"),
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		config = require("config.configs.render-markdown"),
	},
}
