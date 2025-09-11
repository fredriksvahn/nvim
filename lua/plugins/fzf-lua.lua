return {
  'ibhagwan/fzf-lua',
  event = 'VimEnter',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }, -- Optional icons
    { 'nvim-lua/plenary.nvim' }, -- Optional, but useful
  },
  config = function()
    local fzf = require 'fzf-lua'

    -- Setup
    fzf.setup {
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.5,
        col = 0.5,
        preview = { border = 'rounded', wrap = false, horizontal = 'right:50%', title = true, title_pos = 'center' },
      },
      files = { -- file picker options
        previewer = true,
      },
      grep = {
        rg_opts = '--column --line-number --no-heading --color=always --smart-case --max-columns=512',
        previewer = true,
      },
      keymap = {
        builtin = {
          ['<C-f>'] = 'toggle-fullscreen',
          ['<C-c>'] = 'abort',
        },
      },
    }

    vim.keymap.set('n', '<leader>fo', function()
      local function git_actions_menu()
        local actions = {
          'git_bcommits',
          'git_blame',
          'git_branches',
          'git_commits',
          'git_files',
          'git_stash',
          'git_status',
          'git_tags',
        }

        fzf.fzf_exec(actions, {
          previewer = false,
          actions = {
            -- Default: run the command
            ['default'] = function(selected)
              local cmd = selected[1]:match '^(%S+)'
              if cmd and fzf[cmd] then
                fzf[cmd]()
              else
                vim.notify('Unknown command: ' .. (cmd or 'nil'), vim.log.levels.ERROR)
              end
            end,
          },
        })
      end

      git_actions_menu()
    end, { desc = '[F]zf [O]pen Git actions' })

    vim.keymap.set('n', '<leader>f/', fzf.blines, { desc = '[F]ind in current buffer' })

    vim.keymap.set('n', '<leader>fs/', fzf.grep_curbuf, { desc = '[F]ind [S]earch in Open Files' })

    vim.keymap.set('n', '<leader>fn', function()
      fzf.files { cwd = vim.fn.stdpath 'config', options = '--hidden' }
    end, { desc = '[F]ind [N]eovim files' })

    vim.keymap.set('n', '<leader>fG', fzf.live_grep, { desc = '[F]ind with [A]rgs (live grep)' })
    vim.keymap.set('n', '<leader>fg', function()
      require('fzf-lua').live_grep { cwd = vim.fn.expand '%:p:h', options = '--hidden' }
    end)

    vim.keymap.set('n', '<leader>fC', fzf.colorschemes, { desc = '[F]ind [C]olorschemes' })
    vim.keymap.set('n', '<leader>ff', function()
      local cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
      cwd = vim.fn.trim(cwd)

      if cwd == '' then
        cwd = vim.fn.expand '%:p:h'
      end

      require('fzf-lua').files { cwd = cwd, options = '--hidden' }
    end)

    vim.keymap.set('n', '<leader>fz', fzf.grep, { desc = '[F]ind with Args' })

    vim.keymap.set('n', '<leader>ghr', fzf.git_commits, { desc = '[G]it [H]istory (commits)' })
    vim.keymap.set('n', '<leader>ghp', fzf.git_branches, { desc = '[G]it [P]ull Requests (branches)' }) -- Needs customization for PRs
  end,
}
