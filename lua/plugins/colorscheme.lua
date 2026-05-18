return {
  {
    'sainnhe/everforest',
    priority = 1000,
    config = function()
      vim.g.everforest_background = 'hard'
      vim.g.everforest_enable_italic = 0
      -- Override everforest's bg palette to match Delirium Everforest-darken.
      -- These apply to every highlight group everforest generates, not just Normal.
      vim.g.everforest_colors_override = {
        bg0       = { '#181819', '235' }, -- editor bg      (#272e33 → near-black)
        bg1       = { '#1e1e20', '235' }, -- cursorline etc
        bg2       = { '#242426', '236' }, -- statusline / popups
        bg3       = { '#29292b', '236' }, -- inactive areas
        bg4       = { '#313133', '237' }, -- borders / selection
        bg5       = { '#3f3f3f', '238' }, -- subtle elements
        bg_dim    = { '#131313', '232' }, -- NormalNC / sidebar
        bg_visual = { '#434a38', '22'  }, -- visual selection (keep green tint)
      }
      vim.cmd.colorscheme 'everforest'
      require('fredriksvahn.theme')
    end,
  },

  -- Inactive themes — lazy = true so they don't interfere with everforest
  { 'aktersnurra/no-clown-fiesta.nvim', lazy = true },
  { 'xero/miasma.nvim', lazy = true },
  { 'catppuccin/nvim', name = 'catppuccin', lazy = true },
  { 'rose-pine/neovim', name = 'rose-pine', lazy = true },
  { 'jesseleite/nvim-noirbuddy', lazy = true },
  { 'RRethy/base16-nvim', lazy = true },
  { 'ricardoraposo/gruvbox-minor.nvim', lazy = true },
}
