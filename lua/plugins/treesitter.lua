-- treesitter.lua
--
-- Allows highlighting, editing, and navigating code

return {
	'nvim-treesitter/nvim-treesitter',
	branch = 'main',
	lazy = false,
	build = ':TSUpdate'
}
