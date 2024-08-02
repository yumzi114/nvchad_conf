vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },
  -- {
  --   "tpope/vim-dispatch",
  --   config = function()
  --     vim.cmd [[
  --       autocmd FileType rust nnoremap <buffer> <F5> :cargo run<CR>
  --     ]]
  --   end,
  -- },
  -- -- vim-rust 플러그인 설치
  -- {
  --   "rust-lang/rust.vim",
  --   config = function()
  --     vim.cmd [[
  --       let g:rustfmt_autosave = 1
  --     ]]
  --   end,
  -- },
  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
