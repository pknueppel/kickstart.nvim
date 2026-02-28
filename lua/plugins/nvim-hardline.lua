return {
	'ojroques/nvim-hardline',
	config = function()
		require('hardline').setup {
			theme = vim.g.colors_name or 'default',
		}
	end,
}
