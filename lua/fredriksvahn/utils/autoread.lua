-- Auto-reload buffers when files change outside nvim
-- (e.g. Claude Code editing in the adjacent tmux pane via <leader>cl).
-- Combined with updatetime = 250, reloads feel instant in practice.

vim.opt.autoread = true

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  group = vim.api.nvim_create_augroup('auto-checktime', { clear = true }),
  callback = function()
    if vim.fn.mode() ~= 'c' and vim.fn.getcmdwintype() == '' then
      vim.cmd 'checktime'
    end
  end,
})

vim.api.nvim_create_autocmd('FileChangedShellPost', {
  group = vim.api.nvim_create_augroup('file-changed-shell-post', { clear = true }),
  callback = function()
    vim.notify('File reloaded — changed outside nvim', vim.log.levels.INFO)
  end,
})
