require "nvchad.options"

-- Tabs / Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- Search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

-- Appearance
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.colorcolumn = '80'
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 1
vim.opt.scrolloff = 11
vim.opt.completeopt = "menuone,noinsert,noselect"

-- Add transparency where desired
vim.cmd([[
	hi Normal guibg=NONE ctermbg=NONE
	hi NormalNC guibg=NONE ctermbg=NONE
	hi NormalSB guibg=NONE ctermbg=NONE
	hi NormalFloat guibg=NONE ctermbg=NONE
	hi FloatBorder guibg=NONE ctermbg=NONE
	hi SignColumn guibg=NONE ctermbg=NONE
]])

-- Behavior
vim.opt.hidden = true -- Hide buffer when abandoned
vim.opt.errorbells = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.autochdir = false
vim.opt.clipboard:append("unnamedplus") -- synchronize nvim clipboard with system clipboard
vim.opt.modifiable = true
vim.opt.encoding = "UTF-8"
vim.opt.inccommand = "split" -- add window while using commands

