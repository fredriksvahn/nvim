return {
  'folke/which-key.nvim',
  opts = {
    preset = 'helix',
    delay = 0,
    win = {
      height = {
        max = math.huge,
      },
    },
    plugins = {
      spelling = {
        enabled = false,
      },
    },
    icons = {
      rules = false,
      breadcrumb = ' ',
      separator = '󱦰 ',
      group = '󰹍 ',
    },
    spec = {
      { '<leader>b', group = '[B]uffer' },
      { '<leader>c', group = '[C]ode / CodeCompanion', mode = { 'n', 'x' } },
      { '<leader>f', group = '[F]ind' },
      { '<leader>g', group = '[G]it' },
      { '<leader>gh', group = '[G]it [H]istory' },
      { '<leader>j', group = '[J]ira' },
      { '<leader>o', group = '[O]cto / PRs' },
      { '<leader>p', group = '[P]ersistence' },
      { '<leader>r', group = '[R]ename / Roslyn' },
      { '<leader>s', group = '[S]ession' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>x', group = 'Trouble / Diagnostics' },
      { '<leader>y', group = '[Y]ank' },
    },
  },
}
