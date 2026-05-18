return {
  'pwntester/octo.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'ibhagwan/fzf-lua',
    'nvim-tree/nvim-web-devicons',
  },
  cmd = 'Octo',
  keys = {
    { '<leader>op', '<cmd>Octo pr list<cr>', desc = '[O]cto [P]R list' },
    { '<leader>oP', '<cmd>Octo pr create<cr>', desc = '[O]cto [P]R create' },
    { '<leader>oc', '<cmd>Octo pr changes<cr>', desc = '[O]cto PR [C]hanges (browse files)' },
    { '<leader>or', '<cmd>Octo review start<cr>', desc = '[O]cto [R]eview start' },
    { '<leader>os', '<cmd>Octo review submit<cr>', desc = '[O]cto review [S]ubmit' },
    { '<leader>oi', '<cmd>Octo issue list<cr>', desc = '[O]cto [I]ssue list' },
  },
  config = function()
    require('octo').setup {
      picker = 'fzf-lua',
      picker_config = {
        mappings = {
          open_in_browser = { lhs = '<C-b>', desc = 'open in browser' },
          copy_url = { lhs = '<C-y>', desc = 'copy URL' },
          checkout_pr = { lhs = '<C-o>', desc = 'checkout PR' },
          merge_pr = { lhs = '<C-r>', desc = 'merge PR' },
        },
      },
    }
  end,
}
