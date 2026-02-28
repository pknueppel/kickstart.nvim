-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
	'mfussenegger/nvim-dap',
	dependencies = {
		-- Creates a beautiful debugger UI
		'rcarriga/nvim-dap-ui',

		-- Required dependency for nvim-dap-ui
		'nvim-neotest/nvim-nio',

		-- For virtual text
		'theHamsta/nvim-dap-virtual-text',

		-- Installs the debug adapters for you
		'williamboman/mason.nvim',
		'jay-babu/mason-nvim-dap.nvim',
	},
	keys = {
		-- Basic debugging keymaps, feel free to change to your liking!
		{
			'<F5>',
			function()
				require('dap').continue()
			end,
			desc = 'Debug: Start/Continue',
		},
		{
			'<F11>',
			function()
				require('dap').step_into()
			end,
			desc = 'Debug: Step Into',
		},
		{
			'<F10>',
			function()
				require('dap').step_over()
			end,
			desc = 'Debug: Step Over',
		},
		{
			'<A-S-F11>',
			function()
				require('dap').step_out()
			end,
			desc = 'Debug: Step Out',
		},
		{
			'<A-S-F9>',
			function()
				local condition = vim.fn.input 'Breakpoint condition (optional): '
				local hit_condition = vim.fn.input 'Hit count (optional): '

				-- Convert empty strings to nil
				condition = condition ~= '' and condition or nil
				hit_condition = hit_condition ~= '' and hit_condition or nil

				require('dap').toggle_breakpoint(condition, hit_condition)
			end,
			desc = 'Debug: Set Condtional Breakpoint',
		},
		{
			'<F9>',
			function()
				require('dap').toggle_breakpoint()
			end,
			desc = 'Debug: Set Breakpoint',
		},
		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		{
			'<F8>',
			function()
				require('dapui').toggle()
			end,
			desc = 'Debug: See last session result.',
		},
	},
	config = function()
		local dap = require 'dap'
		local dapui = require 'dapui'
		local dap_virtual_text = require 'nvim-dap-virtual-text'

		require('mason-nvim-dap').setup {
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				'cppdbg',
				'debugpy',
			},
		}

		dap_virtual_text.setup {}

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup {
			controls = {
				enabled = vim.g.have_font,
				icons = {
					pause = '',
					play = '',
					step_into = '',
					step_over = '',
					step_out = '',
					step_back = '',
					run_last = '',
					terminate = '',
					disconnect = '⏏',
				},
			},
		}

		-- Change breakpoint icons
		vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
		vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
		local breakpoint_icons = vim.g.have_nerd_font
				and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
			or { Breakpoint = 'B', BreakpointCondition = 'B+', BreakpointRejected = 'B-', LogPoint = 'L', Stopped = 'S' }
		for type, icon in pairs(breakpoint_icons) do
			local tp = 'Dap' .. type
			local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
			vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
		end

		dap.listeners.after.event_initialized['dapui_config'] = dapui.open
		dap.listeners.before.event_terminated['dapui_config'] = dapui.close
		dap.listeners.before.event_exited['dapui_config'] = dapui.close
	end,
}
