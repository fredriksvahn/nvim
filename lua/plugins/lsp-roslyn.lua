return {
  'seblyng/roslyn.nvim',
  ft = { 'cs' },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, cmp = pcall(require, 'cmp_nvim_lsp')
    if ok then
      capabilities = vim.tbl_deep_extend('force', capabilities, cmp.default_capabilities())
    end

    vim.lsp.config('roslyn', {
      capabilities = capabilities,
      settings = {
        ['csharp|inlay_hints'] = {
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_implicit_variable_types = true,
        },
        -- openFiles (not fullSolution) on WSL ↔ /mnt/c — full-solution analysis
        -- across the WSL boundary is extremely slow on large 4.8 solutions
        ['csharp|background_analysis'] = {
          dotnet_analyzer_diagnostics_scope = 'openFiles',
          dotnet_compiler_diagnostics_scope = 'openFiles',
        },
      },
    })

    require('roslyn').setup {
      -- inotify across /mnt/c is unreliable; disable to prevent hangs / missed events
      filewatching = 'off',
      -- Disable razor extension: mason's stable `roslyn` binary doesn't recognise
      -- the razor CLI args, and classic MVC .cshtml views aren't supported by it anyway
      extensions = {
        razor = { enabled = false },
      },
    }

    vim.keymap.set('n', '<leader>rt', '<cmd>Roslyn target<CR>', { desc = '[R]oslyn pick [T]arget solution' })
    vim.keymap.set('n', '<leader>rR', '<cmd>Roslyn restart<CR>', { desc = '[R]oslyn [R]estart' })
  end,
}
