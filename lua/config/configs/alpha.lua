return function()
	local dashboard = require("alpha.themes.dashboard")
	require("config.util").gen_alpha_hl()

	local dashboard_config = require("config.dashboard")
	local design = dashboard_config.versions[dashboard_config.active]
	assert(design, "Unknown dashboard design: " .. tostring(dashboard_config.active))

	dashboard.section.header.val = design.header
	dashboard.section.header.opts.position = "center"
	dashboard.section.header.opts.hl = "AlphaHeader"

	local function footer()
		return design.footer
	end

	dashboard.section.footer.val = footer()
	dashboard.section.footer.opts.hl = "AlphaFooter"

	local header_padding = math.max(0, math.floor((vim.fn.winheight(0) - #dashboard.section.header.val - 3) / 2))

	dashboard.config.layout = {
		{ type = "padding", val = header_padding },
		dashboard.section.header,
		{ type = "padding", val = 1 },
		dashboard.section.footer,
	}

	require("alpha").setup(dashboard.opts)

end
