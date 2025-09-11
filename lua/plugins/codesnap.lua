return {
  'mistricky/codesnap.nvim',
  build = 'make',
  keys = {
    { '<leader>cp', '<cmd>CodeSnap<cr>', mode = 'x', desc = 'Save selected code snapshot into clipboard' },
    { '<leader>cx', '<cmd>CodeSnapSave<cr>', mode = 'x', desc = '[C]odesnap [X]ave into dir' },
  },
  opts = {
    save_path = '~/Desktop/Codesnap',
    has_breadcrumbs = true,
    mac_window_bar = false,
    has_line_numbers = true,
    bg_color = '#293136',
    bg_padding = 0,

    watermark = '',
  },
}
