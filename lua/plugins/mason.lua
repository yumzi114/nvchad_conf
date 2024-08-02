return {
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = { ensure_installed = { "codelldb" } },
    config = function()
      require("mason").setup(opts)
    end
  },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   config = function()
  --     require("mason-lspconfig").setup({
  --       ensure_installed = { "rust_analyzer" }
  --     })
  --   end
  -- },
  {
    "simrat39/rust-tools.nvim",
    requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
    config = function()
      local rust_tools = require("rust-tools")
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
      if vim.fn.executable("rust-analyzer") == 0 then
        LazyVim.error(
          "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
          { title = "rustaceanvim" }
        )
      end
      -- Setup rust-tools.nvim with inlay hints enabled
      rust_tools.setup({
        server = {
          on_attach = function(_, bufnr)
            local bufopts = { noremap=true, silent=true, buffer=bufnr }
            vim.keymap.set('n', '<Leader>rr', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', '<Leader>gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', '<Leader>h', vim.lsp.buf.hover, bufopts)
          end,
        },
        tools = {
          inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "-> ",
            highlight = "LspInlayHint",
          },
        },
      })
    end
  }
}