-- lsp-config/init.lua
-- Central entry point for LSP configuration (Neovim 0.11+)

require "lsp-config.mason"
require("lsp-config.handlers").setup()
require "lsp-config.none-ls"
