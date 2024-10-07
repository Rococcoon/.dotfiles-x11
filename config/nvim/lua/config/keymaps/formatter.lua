-- nvim/init.lua or nvim/lua/setup.lua

-- Set up a keybinding to format the current Lua file
vim.api.nvim_set_keymap(
	"n",
	"<leader>fl",
	':lua require("formatter.stylua").format()<CR>',
	{ noremap = true, silent = true }
)

-- Key binding to format javascript with js-semi-standard
vim.api.nvim_set_keymap(
	"n",
	"<leader>fjs",
	":!npx semistandard --fix %<CR>:set autoread<<CR>",
	{ noremap = true, silent = true }
)