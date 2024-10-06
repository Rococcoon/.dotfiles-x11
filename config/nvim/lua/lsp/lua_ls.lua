-- CONFIGURE LUA LANGUAGE SERVER

-- ~/.config/nvim/lua/lsp/lua_ls.lua

-- Update this with the actual path to lua-language-server
local lsp_path = "/path/to/lua-language-server"  

-- You can find out the command to start the server 
-- by referring to the lua-language-server documentation
local cmd = { lsp_path .. "/bin/Linux/lua-language-server", 
  "-E", lsp_path .. "/main.lua" }

-- Start the Lua LSP server
vim.lsp.start({
  name = "lua-language-server",
  cmd = cmd,
  root_dir = vim.fn.getcwd(),
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = { 'vim' },  -- Recognize Neovim's global 'vim'
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
})
