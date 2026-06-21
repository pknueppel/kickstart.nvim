-- C3 plugin

return {
	"ManuLinares/nvim-c3",
	build = function() require("c3").update() end, -- (Optional) Auto-update binaries
	config = function()
		require("c3").setup({
			lsp = {
				enable = true,            -- Set to false to disable LSP
				cmd = "c3lsp",
				version = "latest",       -- (2)
				compiler_path = nil,      -- Custom path to c3c binary (3)
				stdlib_path = "/usr/lib/c3c/lib/std", -- Custom path to C3 standard library (3)
			},
			formatter = {
				enable = true, -- Set to false to disable formatter
				cmd = "c3fmt",
				format_on_save = false,
				config_file = nil, -- Path to .c3fmt file (1)
				version = "latest", -- (2)
			},
			highlighting = {
				enable_treesitter = true,
			}
		})
		--vim.keymap.set('n', '<leader>lf', '<cmd>C3Format<CR>', { desc = 'LSP [F]ormat' })
	end,
}
