return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  ft = { 'markdown', 'codecompanion' },
  opts = {
    file_types = { 'markdown', 'codecompanion' },
  },
}
