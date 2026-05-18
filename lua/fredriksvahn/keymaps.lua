local keymap = vim.keymap

keymap.set('n', '<leader>r', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', { desc = '[R]eplace word under cursor' })

keymap.set('n', '<C-a>', '<C-w>p', { silent = true, desc = 'Switch to Last Window' })
keymap.set('n', '<space><space>i', ':e ~/.config/nvim/<CR>', { desc = 'Open [I]nit config' })
keymap.set('n', '<leader>ss', ':!tmux popup -E bash ~/.tmux/scripts/tmux-sessionizer.sh<CR>', { desc = '[S]ession [S]essionizer' })
keymap.set("n", "<leader>sk", function()
  local in_tmux = os.getenv("TMUX") ~= nil
  if in_tmux then
    -- Popup inside tmux
    vim.fn.system({ "tmux", "display-popup", "-E",
      'tmux choose-tree -s "kill-session -t %%"' })
  else
    -- Fallback outside tmux (fzf in a terminal split)
    vim.cmd([[split | terminal bash -lc 'tmux ls -F "#S" | fzf --multi | xargs -r -n1 tmux kill-session -t']])
  end
end, { silent = true, desc = '[S]ession [K]ill tmux session' })

keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected line [J]own' })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected line [K]up' })
keymap.set('n', '<space>"', 'ciw"<C-r>""', { desc = 'Replace word in quotes ["' })
keymap.set('n', "<space>'", "ciw'<C-r>\"'", { desc = "Replace word in single quotes [']" })
keymap.set('n', '<space>}', 'ciw{<C-r>"}', { desc = 'Replace word in curly braces [}]' })
keymap.set('n', '<space>]', 'ciw[<C-r>"]', { desc = 'Replace word in square brackets []' })
keymap.set('n', '<space>)', 'ciw(<C-r>")', { desc = 'Replace word in parentheses [)]' })
keymap.set('v', '<space>"', 'c"<C-r>""', { desc = 'Replace selection with quotes ["' })
keymap.set('v', "<space>'", "c'<C-r>\"'", { desc = "Replace selection with single quotes [']" })
keymap.set('v', '<space>}', 'c{<C-r>"}', { desc = 'Replace selection with curly braces [}]' })
keymap.set('v', '<space>]', 'c[<C-r>"]', { desc = 'Replace selection with square brackets []' })
keymap.set('v', '<space>)', 'c(<C-r>")', { desc = 'Replace selection with parentheses [)]' })

-- Buffer keymaps
keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = '[B]uffer [P]revious' })
keymap.set('n', '<leader>bp', '<cmd>bprevious<cr>', { desc = '[B]uffer [P]revious' })
keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = '[B]uffer [N]ext' })
keymap.set('n', '<leader>bn', '<cmd>bnext<cr>', { desc = '[B]uffer [N]ext' })
keymap.set('n', '<leader>bb', '<cmd>b#<cr>', { desc = '[B]uffer toggle between [B]uffers' }) -- Fixed single purpose for <leader>bb
keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = '[B]uffer [D]elete' })
keymap.set('n', '<leader>ba', '<cmd>%bd|e#|bd#<cr>', { desc = '[B]uffer delete [A]ll' })
keymap.set('n', '<leader>bo', '<cmd>%bd|e#|bd#<cr>', { desc = '[B]uffer [O]nly keep current' })
keymap.set('n', '<leader>bh', '<cmd>BufferLineMovePrev<cr>', { desc = '[B]uffer move [L]eft' })
keymap.set('n', '<leader>bj', '<cmd>BufferLineMoveNext<cr>', { desc = '[B]uffer move [R]ight' }) -- Changed from bl to bj to avoid conflict
keymap.set('n', '<leader>bt', '<cmd>BufferLineTogglePin<cr>', { desc = '[B]uffer [T]oggle pin' })
keymap.set('n', '<leader>bc', '<cmd>BufferLinePickClose<cr>', { desc = '[B]uffer [C]lose pick' })
keymap.set('n', '<leader>bf', '<cmd>BufferLineGoToBuffer 1<cr>', { desc = '[B]uffer [F]irst' })
keymap.set('n', '<leader>bl', '<cmd>BufferLineGoToBuffer -1<cr>', { desc = '[B]uffer [L]ast' })

-- Resize with arrows
keymap.set('n', '<C-S-Down>', ':resize +2<CR>', { desc = 'Resize horizontal split [Down]' })
keymap.set('n', '<C-S-Up>', ':resize -2<CR>', { desc = 'Resize horizontal split [Up]' })
keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Resize vertical split [Left]' })
keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Resize vertical split [Right]' })

keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode shortcut
keymap.set('t', '<C-t>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>', { desc = 'Discourage using [Left] arrow' })
-- keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>', { desc = 'Discourage using [Right] arrow' })
-- keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>', { desc = 'Discourage using [Up] arrow' })
-- keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>', { desc = 'Discourage using [Down] arrow' })

-- Window navigation (<C-h/j/k/l>) handled by nvim-tmux-navigation plugin

-- Copy text to " register
keymap.set('n', '<leader>y', '"+y', { desc = '[Y]ank selected text into " register in normal mode' })
keymap.set('v', '<leader>y', '"+y', { desc = '[Y]ank selected text into " register in visual mode' })
keymap.set('n', '<leader>Y', '"+Y', { desc = '[Y]ank entire line into " register in normal mode' })
keymap.set('n', '<leader>ya', 'gg"+yG', { noremap = true, silent = true, desc = '[Y]ank entire file into " register in normal mode' })
keymap.set('v', '<leader>ya', 'gg"+yG', { noremap = true, silent = true, desc = '[Y]ank entire file into " register in visual mode' })

-- Delete text to " register
keymap.set('n', '<leader>_', '"_dd', { desc = '[D]elete into " register' })
keymap.set('v', '<leader>_', '"_dd', { desc = '[D]elete into " register' })

-- Stay in indent mode
keymap.set('v', '<', '<gv', { desc = 'Indent left and stay in indent mode' })
keymap.set('v', '>', '>gv', { desc = 'Indent right and stay in indent mode' })

-- Search for highlighted text in buffer
keymap.set('v', '//', 'y/<C-R>"<CR>', { desc = 'Search for highlighted text in buffer' })

-- Claude Code: open `claude` in a tmux pane next to nvim (or a vsplit terminal if not in tmux)
keymap.set('n', '<leader>cl', function()
  if os.getenv 'TMUX' then
    vim.fn.system { 'tmux', 'split-window', '-h', '-c', vim.fn.getcwd(), 'claude' }
  else
    vim.cmd 'vsplit | terminal claude'
  end
end, { silent = true, desc = '[C]laude code in pane' })

-- Worktree picker (uses fzf-lua over `git worktree list`)
keymap.set('n', '<leader>gw', function()
  local raw = vim.fn.systemlist 'git worktree list'
  if vim.v.shell_error ~= 0 or #raw == 0 then
    vim.notify('Not in a git repo or no worktrees', vim.log.levels.WARN)
    return
  end
  require('fzf-lua').fzf_exec(raw, {
    prompt = 'Worktrees> ',
    actions = {
      ['default'] = function(selected)
        local path = selected[1]:match '^(%S+)'
        path = path and path:gsub('\\', '/'):gsub('^([A-Za-z]):', function(d)
          return '/mnt/' .. d:lower()
        end)
        if path and vim.fn.isdirectory(path) == 1 then
          vim.cmd('cd ' .. vim.fn.fnameescape(path))
          vim.notify('cwd → ' .. path)
        end
      end,
    },
  })
end, { desc = '[G]it [W]orktree picker' })

-- Jira: extract SVD-NNNN ticket from current branch and run ji commands
local function current_ticket()
  local branch = vim.fn.trim(vim.fn.systemlist('git rev-parse --abbrev-ref HEAD')[1] or '')
  return branch:match 'SVD%-%d+'
end

keymap.set('n', '<leader>jv', function()
  local t = current_ticket()
  if not t then
    vim.notify('No SVD-NNNN ticket found in branch name', vim.log.levels.WARN)
    return
  end
  vim.cmd('split | terminal ji get ' .. t)
end, { desc = '[J]ira [V]iew ticket for current branch' })

keymap.set('n', '<leader>jl', function()
  vim.cmd 'split | terminal ji last'
end, { desc = '[J]ira [L]ast viewed ticket' })

