-- lazy.nvim bootstrap. Add plugins as specs in lua/user/plugins/*.lua
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazy_path) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", "https://github.com/folke/lazy.nvim.git", lazy_path })
end
vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({ import = "user.plugins" }, {
	change_detection = { notify = false },
	install = {
		colorscheme = { "catppuccin-mocha" },
	},
})
