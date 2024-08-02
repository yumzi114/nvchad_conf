return {
    {
        "neovim/nvim-lspconfig",
        opts = {
          servers = {
            taplo = {
              keys = {
                {
                  "K",
                  function()
                    if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                      require("crates").show_popup()
                    else
                      vim.lsp.buf.hover()
                    end
                  end,
                  desc = "Show Crate Documentation",
                },
              },
            },
          },
        },
        config = function()
          local lspconfig = require("lspconfig")
          local util = require("lspconfig/util")
          local capabilities = require("cmp_nvim_lsp").default_capabilities()
    
          -- Rust Analyzer configuration
          lspconfig.rust_analyzer.setup({
            cmd = { "/home/yum/.local/bin/rust-analyzer" },
            capabilities = capabilities,
            filetypes = { "rust" },
            root_dir = util.root_pattern("Cargo.toml"),
            default_settings = {
              ['rust-analyzer'] = {
                cargo = {
                  allFeatures = true,
                  loadOutDirsFromCheck = true,
                  buildScripts = {
                    enable = true,
                  },
                },
                checkOnSave = true,
                procMacro = {
                  enable = true,
                  ignored = {
                    ["async-trait"] = { "async_trait" },
                    ["napi-derive"] = { "napi" },
                    ["async-recursion"] = { "async_recursion" },
                  },
                },
                inlayHints = {
                  enable = true, -- Enable inlay hints
                  parameterHints = true,
                  typeHints = true,
                  reborrowHints = true,
                },
              },
            },
            on_attach = function(_, bufnr)
              local opts = { noremap=true, silent=true }
              local ok = pcall(vim.lsp.inlay_hint.enable, vim.lsp.inlay_hint.is_enabled())
              if ok then
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr }), { bufnr })
              else
                -- vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr }), { bufnr })
              end
              -- lsp_keymaps(bufnr)
    
              -- vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr }), { bufnr })
              
              -- lua vim.lsp.inlay_hint.enable()
    
              vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
              vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
              vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
              vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            end,
          })
          
          -- Global key mappings
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
          vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
        end
      },
}