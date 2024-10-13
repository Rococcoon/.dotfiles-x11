local M = {}

-- Helper function to collect all buffers and their names
local function collect_buffers(buffers)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local name = vim.api.nvim_buf_get_name(buf)
      -- Only add non-empty buffer names
      if name ~= "" then
        table.insert(buffers, name)
      end
    end
  end
end

-- Function to create a floating window displaying a list of all buffers
function M.open_buffer_list()
  -- Create a new buffer for the header
  local header_buf = vim.api.nvim_create_buf(false, true) -- Scratch buffer for header

  -- Prepare an empty table to hold the list of buffers
  local buffers = {}

  -- Collect all buffers
  collect_buffers(buffers)

  -- Set the content of the header buffer
  vim.api.nvim_buf_set_lines(header_buf, 0, -1, false, { "Buffer List (Press <Esc> to close)" })

  -- Create a new buffer for the floating window
  local buf = vim.api.nvim_create_buf(false, true) -- Scratch buffer for buffer list

  -- Set the content of the buffer (buffer list)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, buffers)

  -- Calculate the dimensions of the windows
  local width = math.ceil(vim.o.columns * 0.9) -- 90% of screen width
  local height = math.ceil(vim.o.lines * 0.6)  -- 60% of screen height
  local col = math.ceil((vim.o.columns - width) / 2) -- Center horizontally
  local row = math.ceil((vim.o.lines - height) / 2)  -- Center vertically

  -- Adjust heights for the floating windows
  local header_height = 1  -- Height for the header
  local content_height = height - header_height  -- Remaining height for the content window

  -- Create a floating window for the header
  local header_win_id = vim.api.nvim_open_win(header_buf, true, {
    relative = "editor",
    width = width, -- Full width for the header
    height = header_height,
    col = col,
    row = row - header_height, -- Position above the main windows
    style = "minimal",
    border = "rounded",
  })

  -- Create a floating window for the buffer list
  local win_id = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width, -- Adjusted width for the buffer list
    height = content_height, -- Use the full remaining height below the header
    col = col,
    row = row + header_height, -- Align vertically with the header's bottom
    style = "minimal",
    border = "rounded",
  })

  -- Set up key mapping for Escape to close all windows
  vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "", {
    noremap = true,
    silent = true,
    callback = function()
      M.close_windows(win_id)
      vim.api.nvim_win_close(header_win_id, true) -- Close the header window
    end,
  })

  -- Set up key mapping for Enter to open the selected buffer
  vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", "", {
    noremap = true,
    silent = true,
    callback = function()
      local cursor_line = vim.api.nvim_win_get_cursor(win_id)[1]
      local selected_buffer = buffers[cursor_line]

      if selected_buffer then
        -- Close the floating windows
        M.close_windows(win_id)
        vim.api.nvim_win_close(header_win_id, true) -- Close the header window
        -- Switch to the selected buffer
        vim.cmd("buffer " .. selected_buffer)
      end
    end,
  })
end

-- Function to close all windows (buffer list and header)
function M.close_windows(win_id)
  -- Close the buffer list window and its buffer
  vim.api.nvim_win_close(win_id, true)
end

return M
