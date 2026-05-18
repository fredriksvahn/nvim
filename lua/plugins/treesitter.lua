return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    { 'nushell/tree-sitter-nu', build = ':TSUpdate nu' },
    {
      'nvim-treesitter/nvim-treesitter-textobjects', -- ⬅ adds af/if, ac/ic, etc.
      opts = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
          },
        },
      },
    },
  },
  build = ':TSUpdate',
  main = 'nvim-treesitter', -- nvim-treesitter.configs was removed in the rewrite
  opts = {
    ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'go' },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
}
