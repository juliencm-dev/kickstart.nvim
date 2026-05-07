return {
  -- Detect tabstop and shiftwidth automatically
  'NMAC427/guess-indent.nvim',

  -- File explorer
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    priority = 1000,
    config = function()
      require('oil').setup {
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
          natural_sort = true,
          is_always_hidden = function(name, _)
            return name == '..' or name == '.git'
          end,
        },
        window_options = {
          wrap = true,
        },
      }
    end,
  },

  -- Flash motions
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      modes = {
        search = {
          enabled = true,
        },
        char = {
          jump_labels = true,
        },
      },
    },
  },

  -- Open URLs with gx
  {
    'chrishrb/gx.nvim',
    cmd = 'Browse',
    init = function()
      vim.g.netrw_nogx = 1
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true,
    submodules = false,
  },

  -- Surround text objects
  'tpope/vim-surround',

  -- Collection of various small independent plugins/modules
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      require('mini.ai').setup { n_lines = 500 }

      -- Simple and easy statusline
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },

  -- Highlight colors inline
  {
    'brenoprata10/nvim-highlight-colors',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      render = 'background',
      virtual_symbol = '■',
      enable_hex = true,
      enable_rgb = true,
      enable_hsl = true,
      enable_named_colors = true,
      enable_tailwind = true,
    },
    config = function(_, opts)
      require('nvim-highlight-colors').setup(opts)
    end,
  },
}
