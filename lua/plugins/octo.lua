return {
  'pwntester/octo.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'ibhagwan/fzf-lua',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('octo').setup {
      picker = 'fzf-lua', -- <-- use fzf-lua for all Octo pickers
      picker_config = {
        -- optional: custom keybinds for Octo actions inside the picker
        mappings = {
          open_in_browser = { lhs = '<C-b>', desc = 'open in browser' },
          copy_url = { lhs = '<C-y>', desc = 'copy URL' },
          checkout_pr = { lhs = '<C-o>', desc = 'checkout PR' },
          merge_pr = { lhs = '<C-r>', desc = 'merge PR' },
        },
      },
    }
  end
}
