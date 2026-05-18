return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp", -- Optional: for autocompletion
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        http = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "ANTHROPIC_API_KEY" -- This tells CodeCompanion to look for this env var
              },
              schema = {
                model = {
                  default = "claude-sonnet-4-20250514", -- Updated to Claude Sonnet 4
                },
              },
            })
          end,
        },
      },
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "anthropic",
        },
        agent = {
          adapter = "anthropic",
        },
      },
      display = {
        action_palette = {
          width = 95,
          height = 10,
        },
        chat = {
          window = {
            layout = "vertical", -- vertical|horizontal|buffer
            width = 0.45,
            height = 0.8,
            opts = {
              breakindent = true,
              cursorcolumn = false,
              foldcolumn = "0",
              linebreak = true,
              list = false,
              signcolumn = "no",
              spell = false,
              wrap = true,
            },
          },
        },
      },
      opts = {
        log_level = "ERROR", -- TRACE|DEBUG|ERROR
        send_code = true, -- Send code context with requests
        use_default_actions = true,
        use_default_chat_prompts = true,
      },
      -- Key mappings
      keymaps = {
        ["<C-s>"] = "keymaps.send",
        ["<C-c>"] = "keymaps.close",
        ["q"] = "keymaps.cancel_request",
        ["gr"] = "keymaps.regenerate",
        ["ga"] = "keymaps.codeblock_action",
      },
    })

    -- Set up key mappings
    local keymap = vim.keymap.set
    local function map_opts(desc)
      return { noremap = true, silent = true, desc = desc }
    end

    keymap({ 'n', 'v' }, '<leader>cc', '<cmd>CodeCompanionActions<cr>', map_opts 'CodeCompanion actions')
    keymap('n', '<leader>co', '<cmd>CodeCompanion<cr>', map_opts 'CodeCompanion open')
    keymap('n', '<leader>ct', '<cmd>CodeCompanionChat Toggle<cr>', map_opts 'CodeCompanion chat toggle')
    keymap({ 'n', 'v' }, '<leader>ci', '<cmd>CodeCompanionCmd<cr>', map_opts 'CodeCompanion inline cmd')
    keymap('v', '<leader>cg', '<cmd>CodeCompanionChat Add<cr>', map_opts 'CodeCompanion add selection to chat')
  end,
}
