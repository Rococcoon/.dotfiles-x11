-- Update this with the actual path to the TypeScript Language Server
local tsserver_path = "~/.local/share/lsp/vscode-language-server/node_modules/typescript/lib/tsserver.js"
tsserver_path = vim.fn.expand(tsserver_path)

-- Command to start the TypeScript Language Server
local cmd = { "node", tsserver_path }

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" }, -- Attach to JavaScript and TypeScript file types
	callback = function(args)
		vim.lsp.start({
			name = "typescript-language-server",
			cmd = cmd,
			root_dir = vim.fs.root(args.buf, { "package.json", "tsconfig.json", ".git" }), -- Define root directory
			settings = {
				typescript = {
					tsserver = {
						-- TypeScript-specific settings can be added here
						diagnostics = true,
					},
				},
			},
		})
	end,
})
