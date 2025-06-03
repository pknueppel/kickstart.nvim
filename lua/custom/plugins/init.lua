-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'jay-babu/mason-nvim-dap.nvim' },
  { 'sitiom/nvim-numbertoggle' },
  {
    'OXY2DEV/markview.nvim',
    lazy = false,
    dependencies = {
      'Saghen/blink.cmp',
    },
  },
  {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'jay-babu/mason-nvim-dap.nvim',
      'theHamsta/nvim-dap-virtual-text',
    },
  },
}
