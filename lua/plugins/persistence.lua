return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {},
  keys = {
    { '<leader>ps', function() require('persistence').load() end, desc = '[P]ersistence: restore [S]ession (cwd)' },
    { '<leader>pl', function() require('persistence').load { last = true } end, desc = '[P]ersistence: restore [L]ast session' },
    { '<leader>pd', function() require('persistence').stop() end, desc = "[P]ersistence: [D]on't save current" },
  },
}
