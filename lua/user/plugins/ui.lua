return {
	{
		"Jint-lzxy/nvim",
		name = "catppuccin",
		branch = "refactor/syntax-highlighting",
		lazy = false,
		priority = 1000,
		config = require("user.configs.catppuccin"),
	},
	{
		"goolord/alpha-nvim",
		event = "BufWinEnter",
		config = require("user.configs.alpha"),
	},
	{
		"akinsho/bufferline.nvim",
		event = { "BufReadPre", "BufAdd", "BufNewFile" },
		cmd = { "BufferLineCycleNext", "BufferLineCyclePrev", "BufferLineMoveNext", "BufferLineMovePrev", "BufferLineGoToBuffer" },
		config = require("user.configs.bufferline"),
	},
	{
		"mrjones2014/smart-splits.nvim",
		cmd = { "SmartCursorMoveLeft", "SmartCursorMoveDown", "SmartCursorMoveUp", "SmartCursorMoveRight" },
		opts = {
			default_amount = 3,
			ignored_buftypes = { "nofile", "quickfix", "prompt" },
			ignored_filetypes = { "NvimTree" },
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = require("user.configs.indent-blankline"),
	},
	{
		"smoka7/hop.nvim",
		version = "*",
		cmd = { "HopWordMW" },
		config = require("user.configs.hop"),
	},
	{
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		config = require("user.configs.lualine"),
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "CursorHold", "CursorHoldI" },
		config = require("user.configs.gitsigns"),
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		config = require("user.configs.render-markdown"),
	},
}
