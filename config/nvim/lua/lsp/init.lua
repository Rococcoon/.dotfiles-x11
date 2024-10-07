-- ~/.config/nvim/lua/lsp/init.lua

-- Load Lua LSP configuration
require('lsp.lua_ls')

-- Define a module table for LSP-related functionality
-- local M = {}

-- on_attach function to set up keymaps when the LSP attaches to a buffer
-- M.on_attach = function(client, bufnr)
  -- Load the LSP keymap configuration
  -- local lsp_keymaps = require('config.keymaps.lsp')

  -- Set up LSP keymaps for the current buffer
  -- lsp_keymaps.setup_lsp_keymaps(bufnr)
-- end

-- Return the module table
-- return M
