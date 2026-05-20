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

    -- Detect .NET target framework from nearest .csproj. Cached per-buffer.
    local function find_csproj(start_dir)
      local dir = start_dir
      for _ = 1, 12 do
        if not dir or dir == '/' or dir == '' then return nil end
        local handle = vim.uv.fs_scandir(dir)
        if handle then
          while true do
            local name = vim.uv.fs_scandir_next(handle)
            if not name then break end
            if name:match '%.csproj$' then return dir .. '/' .. name end
          end
        end
        dir = vim.fn.fnamemodify(dir, ':h')
      end
      return nil
    end

    local function read_target_framework(path)
      local f = io.open(path, 'r')
      if not f then return nil end
      local content = f:read '*a'
      f:close()
      local tf = content:match '<TargetFramework>([^<]+)</TargetFramework>'
        or content:match '<TargetFrameworks>([^<]+)</TargetFrameworks>'
      if tf then return tf end
      local tfv = content:match '<TargetFrameworkVersion>v?([^<]+)</TargetFrameworkVersion>'
      if tfv then return 'net' .. tfv:gsub('%.', '') end
      return nil
    end

    local function dotnet_target()
      local ft = vim.bo.filetype
      if ft ~= 'cs' and ft ~= 'csproj' and ft ~= 'sln' then return '' end
      if vim.b.dotnet_target ~= nil then return vim.b.dotnet_target end
      local bufdir = vim.fn.expand '%:p:h'
      local csproj = find_csproj(bufdir)
      vim.b.dotnet_target = csproj and (read_target_framework(csproj) or '') or ''
      return vim.b.dotnet_target
    end

    local function dotnet_color()
      local tf = vim.b.dotnet_target or ''
      if tf == '' then return nil end
      -- net4x → legacy red; everything else (net6/8/10, netstandard, netcoreapp) → green
      if tf:match '^net4' or tf:match '^v?4%.' then
        return { fg = '#e67e80', gui = 'bold' }
      end
      return { fg = '#a7c080', gui = 'bold' }
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
          { dotnet_target, icon = '󰪮', color = dotnet_color },
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
