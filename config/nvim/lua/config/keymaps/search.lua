-- Mapping for searching the current file

-- Require the window module
local window = require("search.search")

-- Mapping to open the centered floating window
vim.api.nvim_set_keymap(
	"n",
	"<leader>sw",
	':lua require("search.search").open_centered_window()<CR>',
	{ noremap = true, silent = true }
)
