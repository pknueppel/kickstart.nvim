-- which-key.lua
--
-- Plugin to show pending keybinds

return {
	'folke/which-key.nvim',

	event = 'VimEnter', -- Sets the loading event to 'VimEnter'

	opts = {
		icons = {
			-- set icon mappings to true if you have a Nerd Font
			mappings = vim.g.have__font,
			separator = '',
			-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
			-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
			keys = vim.g.have__font and {} or {
				Up = '<Up> ',
				Down = '<Down> ',
				Left = '<Left> ',
				Right = '<Right> ',
				C = '<C-…> ',
				M = '<M-…> ',
				D = '<D-…> ',
				S = '<S-…> ',
				CR = '<CR> ',
				Esc = '<Esc> ',
				ScrollWheelDown = '<ScrollWheelDown> ',
				ScrollWheelUp = '<ScrollWheelUp> ',
				NL = '<NL> ',
				BS = '<BS> ',
				Space = '<Space> ',
				Tab = '<Tab> ',
				F1 = '<F1>',
				F2 = '<F2>',
				F3 = '<F3>',
				F4 = '<F4>',
				F5 = '<F5>',
				F6 = '<F6>',
				F7 = '<F7>',
				F8 = '<F8>',
				F9 = '<F9>',
				F10 = '<F10>',
				F11 = '<F11>',
				F12 = '<F12>',
			},
		},

		-- Document existing key chains
		spec = {
			{ '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
			{ '<leader>o', group = 'D[o]cument' },
			{ '<leader>t', group = '[T]oggle' },
			{ '<leader>s', group = '[S]earch' },
			{ '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
			{ '<leader>l', group = '[L]SP' },
			{ 'g', group = 'Junk' },
			{ 'z', group = 'Folds' },
			{ 's', group = '[S]urrounding' },
			{ '[', group = 'Previous' },
			{ ']', group = 'Next' },
			{ 'W', group = '[W]indow' },
		},
	},
}
