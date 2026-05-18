return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>e',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = { 'n', 'v' },
      desc = '[F]ormat buffer',
    },
    {
      '<leader>cf',
      function()
        local start_line = vim.fn.line 'v'
        local end_line = vim.fn.line '.'
        if start_line > end_line then
          start_line, end_line = end_line, start_line
        end
        require('conform').format {
          range = { start = { start_line - 1, 0 }, ['end'] = { end_line - 1, 0 } },
        }
      end,
      mode = 'v',
      desc = '[C]onform [F]ormat selected lines',
    },
    {
      '<leader>ts',
      function()
        vim.g.conform_format_on_save = not vim.g.conform_format_on_save
      end,
      mode = 'n',
      desc = 'Toggle [T]emporary [S]ave Format',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      if vim.g.conform_format_on_save == false then
        return nil
      end

      local mode = vim.fn.visualmode()
      if mode and mode ~= '' then
        local start_line = vim.fn.line 'v'
        local end_line = vim.fn.line '.'
        if start_line > end_line then
          start_line, end_line = end_line, start_line
        end
        return {
          timeout_ms = 500,
          range = { start = { start_line - 1, 0 }, ['end'] = { end_line - 1, 0 } },
        }
      end

      local disable_filetypes = { c = true, cpp = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      rust = { 'rustfmt' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      go = { 'goimports' },
      terraform = { 'terraform' },
      dockerfile = { 'dockfmt' },
      -- cs: handled by roslyn LSP via lsp_format fallback
      sql = { 'sql_formatter' },
      json = { 'prettierd', 'prettier', stop_after_first = true },
      jsonc = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
}
