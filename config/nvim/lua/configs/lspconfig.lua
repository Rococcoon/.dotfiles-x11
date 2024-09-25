-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

-- EXAMPLE
local servers = { "html", "cssls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.tsserver.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

-- Configure LSP for golang
lspconfig.gopls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = {"gopls"},
  filetypes = { "go", "gomod", "gowo=rk", "gotmpl", },
  root_dir = util.root_pattern("go.mod", "go.work", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

-- Configure LSP for Javascript (ts_ls)
lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "Javascript" },
  root_dir = util.root_pattern("package.json", ".git"),
  settings = {
    javascript = {
      format = {
        enable = true,
      },
      lint = true,
    },
  },
}

-- Configure LSP for CSS (css-lsp)
lspconfig.cssls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "css", "scss", "less" },
  root_dir = lspconfig.util.root_pattern(".git", "package.json"),
  settings = {
    css = {
      validate = true,
    },
    scss = {
      validate = true,
    },
    less = {
      validate = true,
    },
  },
}


-- Configure LSP for HTML (html-lsp)
lspconfig.html.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "html" },
  root_dir = lspconfig.util.root_pattern(".git", "package.json"),
  settings = {
    html = {
      format = {
        enable = true,
      },
      validate = true,
    },
  },
}
