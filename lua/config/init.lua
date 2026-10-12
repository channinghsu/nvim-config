vim.g.mapleader = " "

-- Disable optional remote providers not used by this configuration.
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
