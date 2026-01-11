-- plugins.lua
--
-- loads all plugins from the lua/plugins directory

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
	if vim.v.shell_error ~= 0 then
		error('Error cloning lazy.nvim:\n' .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Load all plugins
require('lazy').setup {

	-- Adds neat icons
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have__font and {} or {
			cmd = '⌘',
			config = '',
			event = '',
			ft = '',
			init = '',
			keys = '',
			plugin = '',
			runtime = '󰌢',
			require = '',
			source = '',
			start = '',
			task = '',
			lazy = '󰒲',
		},
	},

	-- Automatically detects shiftwidth/tabstop
	'tpope/vim-sleuth',

	-- Switches line number when in normal/visual mode
	'sitiom/nvim-numbertoggle',

	-- Automatically pairs braces/brackets
	require 'plugins.autopairs',

	-- Implements a debugger
	require 'plugins.debug',

	-- Implements a linter
	require 'plugins.lint',

	-- Automatically indents a line
	require 'plugins.indent_line',

	-- Implements a file tree
	require 'plugins.neo-tree',

	-- Implements gitsigns in the gutter
	require 'plugins.gitsigns',

	-- Shows keybinds
	require 'plugins.which-key',

	-- Implements a fuzzy finder
	require 'plugins.telescope',

	-- implements a lsp
	require 'plugins.lsp',

	-- Adds autoformat
	require 'plugins.conform',

	-- Adds autocomplete
	require 'plugins.nvim-cmp',

	-- Adds highlights to certain notes
	require 'plugins.todo-comments',

	-- Implements small independent plugins/modules
	require 'plugins.mini',

	-- Highlight, edit, and navigate code
	require 'plugins.treesitter',
}
