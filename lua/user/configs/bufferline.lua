return function()
	local icons = { ui = require("user.icons").get("ui") }

	local opts = {
		options = {
			always_show_bufferline = true,
			close_command = "bdelete! %d",
			right_mouse_command = "bdelete! %d",
			tab_size = 20,
			separator_style = "thin",
			show_buffer_icons = true,
			show_tab_indicators = true,
			show_buffer_close_icons = true,
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count)
				return "(" .. count .. ")"
			end,
			numbers = nil,
			max_name_length = 20,
			max_prefix_length = 13,
			buffer_close_icon = icons.ui.Close,
			left_trunc_marker = icons.ui.Left,
			right_trunc_marker = icons.ui.Right,
			modified_icon = icons.ui.Modified_alt,
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "center",
					padding = 0,
				},
			},
		},
		-- Change bufferline's highlights here! See `:h bufferline-highlights`.
		highlights = {},
	}

	require("bufferline").setup(opts)
end
