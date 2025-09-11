return {
  {
    'sainnhe/everforest',
    priority = 1000,
    config = function()
      -- Everforest options
      vim.g.everforest_background = 'hard' -- Options: 'hard', 'medium', 'soft'
      vim.g.everforest_enable_italic = 0 -- Italics for comments/keywords

      -- Load colorscheme
      vim.cmd.colorscheme 'everforest'

      -- Override highlights (example: darker background)
      vim.api.nvim_set_hl(0, 'Normal', { bg = '#111111', fg = '#d3c6aa' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#111111' })
      vim.api.nvim_set_hl(0, 'SignColumn', { bg = '#111111' })
    end,
  },

  {
    'aktersnurra/no-clown-fiesta.nvim',
    lazy = false, -- load at startup (set to true if you want lazy-load by event/cmd)
    priority = 1000, -- make sure it loads before other UI plugins
    config = function()
      require('no-clown-fiesta').setup {
        transparent = false, -- Enable this to disable the bg color
        styles = {
          -- You can set any of the style values specified for `:h nvim_set_hl`
          comments = {},
          functions = {},
          keywords = {},
          lsp = {},
          match_paren = {},
          type = {},
          variables = {},
        },
      }
      --      vim.cmd.colorscheme 'no-clown-fiesta'
    end,
  },
  {
    'xero/miasma.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd 'colorscheme miasma'
    end,
  },
  {
    'catppuccin/nvim',
    event = 'VimEnter',
    name = 'catppuccin',
    cond = function()
      return not vim.g.vscode
    end,
    opts = {
      term_colors = true,
      transparent_background = true,
      transparent_panel = true,
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = false,
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        treesitter = true,
        which_key = true,
        nvimtree = {
          enabled = true,
          transparent_panel = true,
        },
      },
    },
  },

  -- Theme collection
  { 'rose-pine/neovim', name = 'rose-pine' },
  'jesseleite/nvim-noirbuddy',
  'RRethy/base16-nvim',
  'ricardoraposo/gruvbox-minor.nvim',
}
