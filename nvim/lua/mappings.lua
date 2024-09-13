require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

--NAVIGATION IN TEXT EDITOR COMMANDS --
-- Set goto end of line to gl
vim.keymap.set("n", "gl", "$", { noremap = true, silent = true })
vim.keymap.set("v", "gl", "$h", { noremap = true, silent = true })
-- Set goto start of line to gh
vim.keymap.set("n", "gh", "0", { noremap = true, silent = true })
vim.keymap.set("v", "gh", "0", { noremap = true, silent = true })

-- Close Window
-- vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })

-- Close Buffer
vim.api.nvim_set_keymap("n", "<leader>bd", ":bdelete<CR>", { noremap = true, silent = true })

-- Buffer navigation
vim.api.nvim_set_keymap("n", "<leader>p", ":bprevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>n", ":bnext<CR>", { noremap = true, silent = true })

-- Split pane shortcut
vim.keymap.set("n", "<leader>sh", ":split<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { noremap = true, silent = true })

-- Pane navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true }) -- navigate left
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true }) -- navigate down
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true }) -- navigate up
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true }) -- navigate right

-- map keys for numeric navigation between tabs
vim.api.nvim_set_keymap("n", "<Leader>1", ":tabnext 1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>2", ":tabnext 2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>3", ":tabnext 3<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>4", ":tabnext 4<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>5", ":tabnext 5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>6", ":tabnext 6<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>7", ":tabnext 7<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>8", ":tabnext 8<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>9", ":tabnext 9<CR>", { noremap = true, silent = true })

-- Indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- cut text to new lines at 80, parse text
-- vim.keymap.set("v", "<leader>pt", ":'<,'>s/.\\{80}/&\\r/g<CR>",
--  { noremap = true, silent = true })

-- Comment plugin
vim.api.nvim_set_keymap("n", "<leader>ac", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<leader>ac", "gcc", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>bc", "gbc", { noremap = false })
vim.api.nvim_set_keymap("v", "<leader>bc", "gbc", { noremap = false })

-- work around to format on save for javascript
vim.api.nvim_set_keymap(
  "n",
  "<leader>jsf",
  ":!npx semistandard --fix %<CR>:set autoread<<CR>",
  { noremap = true, silent = true }
)
