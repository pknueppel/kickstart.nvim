-- mini.lua
--
-- Adds smaller plugins/modules

return {
	'nvim-mini/mini.nvim',
	config = function()
		-- Start screen
		require('mini.starter').setup()

		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require('mini.ai').setup { n_lines = 500 }

		if vim.g.have_font then
			require('mini.icons').setup()
		end

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require('mini.surround').setup()

		-- Simple and easy statusline.
		--  You could remove this setup call if you don't like it,
		--  and try some other statusline plugin
		local statusline = require 'mini.statusline'
		-- set use_icons to true if you have a Nerd Font
		statusline.setup { use_icons = vim.g.have_font }

		-- You can configure sections in the statusline by overriding their
		-- default behavior. For example, here we set the section for
		-- cursor location to LINE:COLUMN
		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return '%2l:%-2v'
		end

		-- A tabline showing open buffers
		require('mini.tabline').setup()

		-- Better commenting tools
		require('mini.comment').setup()

		-- Snippets
		require('mini.snippets').setup()

		-- Better completion
		require('mini.completion').setup()

		-- Autopairs
		require('mini.pairs').setup()

		-- Include math operators
		require('mini.operators').setup()

		-- Session management
		require('mini.sessions').setup()

		-- Indentscope
		require('mini.indentscope').setup()

		-- Highlight certain patterns in text
		require('mini.hipatterns').setup()

		-- Picker
		require('mini.pick').setup()
	end,
}
