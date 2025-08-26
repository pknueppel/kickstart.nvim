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
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- Optional image support for file preview: See `# Preview Mode` for more information.
      -- {"3rd/image.nvim", opts = {}},
      -- OR use snacks.nvim's image module:
      -- "folke/snacks.nvim",
    },
    lazy = false, -- neo-tree will lazily load itself
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
      -- add options here
    },
  },
  {
    'mcauley-penney/techbase.nvim',
    config = function()
      vim.cmd.colorscheme 'techbase'
    end,
    priority = 1000,
  },
}
