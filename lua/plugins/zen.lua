return {
  'folke/zen-mode.nvim',
  opts = (function()
    local function get_monitor_based_zen_size()
      if vim.fn.executable 'hyprctl' == 0 then
        return { width = 0.35, height = 0.83 }
      end

      local handle = io.popen 'hyprctl monitors -j 2>/dev/null'
      if handle == nil then
        return { width = 0.35, height = 0.83 }
      end

      local result = handle:read '*a'
      handle:close()

      local ok, data = pcall(vim.fn.json_decode, result)
      if not ok or not data or type(data) ~= 'table' or #data == 0 then
        return { width = 0.35, height = 0.83 }
      end

      local monitor_name = nil
      for _, mon in ipairs(data) do
        if mon.focused then
          monitor_name = mon.name
          break
        end
      end

      monitor_name = monitor_name or 'Unknown Monitor'

      local monitor_sizes = {
        ['DP-3'] = { width = 0.8, height = 0.9 },
        ['DP-2'] = { width = 0.35, height = 0.83 },
      }

      local size = monitor_sizes[monitor_name] or { width = 0.35, height = 0.83 }

      return size
    end

    local size = get_monitor_based_zen_size()

    return {
      window = {
        width = size.width,
        height = size.height,
        options = {
          signcolumn = 'no',
        },
      },
      plugins = {
        tmux = true,
        kitty = {
          enabled = false,
          font = '+4',
        },
      },
    }
  end)(),

  keys = {
    { '<leader>z', '<cmd>ZenMode<cr>', desc = 'Toggle [Z]en Mode' },
  },
}

