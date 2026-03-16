-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      local opts = {
        enable = true,
      }
      require('treesitter-context').setup(opts)
      vim.keymap.set('n', '<leader>tc', '<cmd>TSContext toggle<cr>', { desc = '[T]oggle Treesitter [C]ontext' })
    end,
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function() require('flash').jump() end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function() require('flash').treesitter() end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function() require('flash').remote() end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function() require('flash').treesitter_search() end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function() require('flash').toggle() end,
        desc = 'Toggle Flash Search',
      },
    },
  },
  {
    'natecraddock/sessions.nvim',
    opts = {
      -- events = {"VimLeavePre"}, -- default
      session_filepath = '.nvim/session',
    },
  },
  {
    'natecraddock/workspaces.nvim',
    dependencies = { 'natecraddock/sessions.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      local opts = {
        hooks = {
          auto_open = true,

          open_pre = { 'SessionsStop', 'silent %bdelete' },
          open = { 'SessionsLoad' },
          -- open = function()
          --   require('sessions').load(nil, { silent = true })
          -- end,
        },
      }
      require('workspaces').setup(opts)
      pcall(require('telescope').load_extension, 'workspaces')
    end,
  },
  {
    'vhyrro/luarocks.nvim',
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    rocks = { 'luaposix' },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    -- ft = { 'markdown', 'quarto' },
    opts = {
      latex = { enabled = false },
      yaml = { enabled = false },
    },
  },
}
