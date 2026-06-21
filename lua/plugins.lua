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
		icons = vim.g.have_font and {} or {
			cmd = '',
			config = '',
			event = '',
			ft = '󰉋',
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

	-- Tresitter
	require 'plugins.treesitter',

	-- Telescope
	require 'plugins.telescope',

	-- Automatically pairs braces/brackets
	require 'plugins.autopairs',

	-- Implements a debugger
	require 'plugins.debug',

	-- Implements gitsigns in the gutter
	require 'plugins.gitsigns',

	-- Shows keybinds
	require 'plugins.which-key',

	-- Adds autocomplete
	require 'plugins.nvim-cmp',

	-- Implements small independent plugins/modules
	require 'plugins.mini',

	-- VSCode like winbar
	require 'plugins.barbecue',

	-- Diagflow
	require 'plugins.diagflow',

	-- LSP manager
	require 'plugins.mason',

	-- File manager
	require 'plugins.neo-tree',

	-- C3 plugin
	require 'plugins.c3',

	-- Latex
	require 'plugins.vimtext',
}
