return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    'hrsh7th/cmp-nvim-lsp',
    'ibhagwan/fzf-lua',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local fzf_lua = require 'fzf-lua'

        -- Helper for mapping keys
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          if func then
            vim.keymap.set(mode, keys, func, { buffer = 0, desc = 'LSP: ' .. desc })
          else
            print('Error: function for keymap "' .. keys .. '" is nil.')
          end
        end

        map('gd', fzf_lua.lsp_definitions, '[G]oto [D]efinition')
        map('gr', fzf_lua.lsp_references, '[G]oto [R]eferences')
        map('gI', fzf_lua.lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>ds', fzf_lua.lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', fzf_lua.lsp_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', fzf_lua.lsp_code_actions, '[C]ode [A]ction', { 'n', 'x' })
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('<leader>cw', ':noautocmd w<CR>', '[C]ode [Write] Buffer without formatting')
        -- Inlay hints toggle if supported
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end

        -- Highlight symbol under cursor if supported
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_group = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })

          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = highlight_group,
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            group = highlight_group,
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            buffer = event.buf,
            callback = function()
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = highlight_group, buffer = event.buf }
            end,
          })
        end
      end,
    })

    -- LSP capabilities for autocompletion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- List of language servers to install and configure
    -- Note: C# is handled by roslyn.nvim (see lsp-roslyn.lua), not here
    local servers = {
      -- SQL language server
      sqlls = {
        cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
      },
      -- Lua language server with customized settings
      lua_ls = {
        on_init = function(client)
          -- stylua via conform handles Lua formatting; disable lua_ls formatting to avoid conflict
          client.server_capabilities.documentFormattingProvider = false
        end,
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
            format = { enable = false },
            -- diagnostics = { disable = { 'missing-fields' } }, -- Uncomment to suppress specific warnings
          },
        },
      },
      -- TypeScript / JavaScript
      ts_ls = {},
      -- Go
      gopls = {},
      -- Python
      pyright = {},
    }

    -- Mason setup and tools installer.
    -- Crashdummyy registry is required for the `roslyn` package (Microsoft.CodeAnalysis.LanguageServer)
    -- — not yet in mason's main registry as of 2026.
    require('mason').setup {
      registries = {
        'github:mason-org/mason-registry',
        'github:Crashdummyy/mason-registry',
      },
    }

    -- Automatically ensure listed LSP servers and tools are installed
    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, {
      'stylua', -- Lua formatter
      'prettierd', -- JS/TS formatter
      'goimports', -- Go formatter/import organiser
      'black', -- Python formatter
      'isort', -- Python import sorter
      'markdownlint', -- Markdown linter
      'roslyn', -- C# language server (consumed by roslyn.nvim, not mason-lspconfig)
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    -- Setup LSP servers with capabilities and settings
    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
