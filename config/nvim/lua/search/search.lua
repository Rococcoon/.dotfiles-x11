local M = {}

-- Function to create a centered floating window
function M.open_centered_window()
	-- Create a new buffer
	-- false: non-listed, true: scratch
	local buf = vim.api.nvim_create_buf(false, true)

	-- Calculate the dimensions of the window
	-- 70% of screen width
	local width = math.ceil(vim.o.columns * 0.7)
	-- 50% of screen height
	local height = math.ceil(vim.o.lines * 0.5)
	-- Center horizontally
	local col = math.ceil((vim.o.columns - width) / 2)
	-- Center vertically
	local row = math.ceil((vim.o.lines - height) / 2)

	-- Create a floating window with the calculated dimensions
	local win_id = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		-- You can change this to 'none', 'single', 'double', etc.
		border = "rounded",
	})

	-- Set up key mapping for Escape to close the window
	-- When Escape is pressed, the buffer is closed, which closes the floating window
	vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "<cmd>bd!<CR>", { noremap = true, silent = true })
end

return M
