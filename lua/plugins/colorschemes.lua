-- Flexoxi colorscheme for nvim
-- https://github.com/kepano/flexoki-neovim
return {
	{
		'nyoom-engineering/oxocarbon.nvim',
		name = 'oxocarbon',
		config = function()
			vim.cmd.colorscheme 'oxocarbon'
			vim.opt.background = 'dark'
		end,
	},
}
