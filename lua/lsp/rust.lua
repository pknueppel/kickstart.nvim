-- rust.lua
--
-- Configures Lua lsp
vim.lsp.config['rust-analyzer'] = {
	cmd = { 'rust-analyzer' },
	filetypes = { 'rust' },
	root_markers = { '.git' },
	settings = { buildScripts = { enable = true }, procMacro = { enable = true } },
}
vim.lsp.enable('rust-analyzer');
