return {
  'xiyaowong/nvim-transparent',
  config = function()
    require('transparent').setup {
      extra_groups = {
        'NormalFloat',
        'OctoEditable',
        'OilNormal',
      },
    }
    vim.g.transparent_enabled = true
  end,
}
