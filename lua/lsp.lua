-- Imports all LSPs (Language sever protocols)

require 'lsp.lua'
require 'lsp.clangd'
require 'lsp.rust'

-- LSP Setup
-- Most stuff should be setup on their own - this configures keybinds and such
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

		-- If client supports goto implementation, create keymap for it
		if client:supports_method('textDocument/implementation') then
			vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = '[G]oto LSP Symbol Implementation' })
		end

		-- If client supports goto definition, create keymap for it
		if client:supports_method('textDocument/declaration') then
			vim.keymap.set('n', 'gD', vim.lsp.buf.definition, { desc = '[G]oto LSP Symbol Definition' })
		end

		-- If client supports goto declaration, create keymap for it
		if client:supports_method('textDocument/declaration') then
			vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, { desc = '[G]oto LSP Symbol Declaration' })
		end

		-- If client supports goto type definition, create keymap for it
		if client:supports_method('textDocument/typeDefinition') then
			vim.keymap.set('n', 'gt', vim.lsp.buf.declaration, { desc = '[G]oto LSP Symbol Type Definition' })
		end

		-- If client supports find references, create keymap for it
		if client:supports_method('textDocument/references') then
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = '[G]oto LSP Symbol References' })
		end

		-- Enable auto-completion.
		if client:supports_method('textDocument/completion') then
			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end

		-- If client supports document highlights, create groups
		if client:supports_method('textDocument/documentHighlight') then
			-- Create highlight groups
			vim.api.nvim_set_hl(0, 'hl-LspReferenceText', {})
			vim.api.nvim_set_hl(0, 'hl-LspReferenceRead', {})
			vim.api.nvim_set_hl(0, 'hl-LspReferenceWrite', {})
			vim.api.nvim_set_hl(0, 'hl-LspReferenceTarget', {})
			vim.api.nvim_set_hl(0, 'hl-LspInlayHint', {})
			vim.api.nvim_set_hl(0, 'lsp-highlight-codelens', {})
			vim.api.nvim_set_hl(0, 'hl-LspCodeLens', {})
			vim.api.nvim_set_hl(0, 'hl-LspCodeSeparator', {})
			vim.api.nvim_set_hl(0, 'lsp-highlight-signature', {})
			vim.api.nvim_set_hl(0, 'hl-LspSignatureActiveParameter', {})
			-- Define autocommands
			vim.api.nvim_create_autocmd('CursorHold', {
				desc = 'Sends request to server to resolve LSP document highlights',
				pattern = { '<buffer>' },
				callback = function()
					vim.lsp.buf.document_highlight()
				end,
			})

			vim.api.nvim_create_autocmd('CursorHoldI', {
				desc = 'Sends request to server to resolve LSP document highlights',
				pattern = { '<buffer>' },
				callback = function()
					vim.lsp.buf.document_highlight()
				end,
			})

			vim.api.nvim_create_autocmd('CursorMoved', {
				desc = 'Sends request to server to clear LSP document highlights',
				pattern = { '<buffer>' },
				callback = function()
					vim.lsp.buf.clear_references()
				end,
			})
		end

		-- If client supports hover
		if client:supports_method('textDocument/hover') then
			vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, { desc = 'LSP [H]over' })
		end

		-- If client supports codeLens
		if client:supports_method('textDocument/codeLens') then
			vim.lsp.codelens.enable()
			vim.keymap.set('n', '<leader>lc', vim.lsp.codelens.run, { desc = 'LSP [C]odelens Run' })
		end

		if client:supports_method('textDocument/foldingRange') then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
		end

		if client:supports_method('textDocument/documentSymbols') then
			vim.keymap.set('n', '<leader>ld', vim.lsp.buf.document_symbol, { desc = 'LSP [D]ocument Symbols' })
		end

		if client:supports_method('textDocument/semanticTokens') then
			vim.lsp.semantic_tokens.enable()
			vim.lsp.semantic_tokens.force_refresh()
		end

		if client:supports_method('textDocument/rename') then
			vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'LSP [R]ename' })
		end

		if client:supports_method('textDocument/codeAction') then
			vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'LSP [A]ction' })
		end

		if client:supports_method('textDocument/formatting') then
			vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'LSP [F]ormat' })
		end


		-- Auto-format ("lint") on save.
		-- Usually not needed if server supports "textDocument/willSaveWaitUntil".
		if not client:supports_method('textDocument/willSaveWaitUntil')
			and client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
				buffer = ev.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,

})
