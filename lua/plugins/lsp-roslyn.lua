return {
  'seblyng/roslyn.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {},
  config = function(_, opts)
    require('roslyn').setup(opts)
  end,
}
