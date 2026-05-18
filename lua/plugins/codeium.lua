return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function()
    vim.keymap.set('i', '<C-g>', function()
      return vim.fn['codeium#Accept']()
    end, { expr = true, silent = true, desc = '[C]odeium Accept' })

    vim.keymap.set('i', '<C-x>', function()
      return vim.fn['codeium#Clear']()
    end, { expr = true, silent = true, desc = '[C]odeium [X]it' })

    vim.g.codeium_filetypes = {
      markdown = false,
    }
  end,
}
