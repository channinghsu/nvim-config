vim.g.mapleader = " "

-- Disable optional remote providers not used by this configuration.
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

require("user.options")
require("user.keymaps")
require("user.autocmds")
require("user.lazy")
