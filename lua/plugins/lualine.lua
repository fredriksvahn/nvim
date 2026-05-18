return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'kyazdani42/nvim-web-devicons' },
  config = function()
    -- Show project/worktree dir basename so it's obvious which worktree we're in
    local function worktree_name()
      local out = vim.fn.systemlist 'git rev-parse --show-toplevel'
      if vim.v.shell_error ~= 0 or not out or not out[1] then
        return ''
      end
      local top = out[1]:gsub('\\', '/'):gsub('^([A-Za-z]):', function(d)
        return '/mnt/' .. d:lower()
      end)
      return vim.fn.fnamemodify(top, ':t')
    end

    require('lualine').setup {
      options = {
        icons_enabled = true,
        path = 1,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { 'NvimTree', 'Lazy', 'Mason', 'fugitive', 'lazygit', 'oil' },
          winbar = {},
        },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', { worktree_name, icon = '󰊢' } },
        lualine_c = { 'filename' },
        lualine_x = {
          'diagnostics',
          {
            'filetype',
            icon_only = true,
            colored = true,
          },
        },
        lualine_z = {
          function()
            return '%l:%c'
          end,
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = {
          function()
            return '%l:%c'
          end,
        },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = {},
    }
  end,
}
