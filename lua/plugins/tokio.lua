return {
  {
    "folke/tokyonight.nvim",
    {
      "stevearc/conform.nvim",
      config = function()
        require("conform").setup({
          log_level = vim.log.levels.DEBUG,
          -- add your config here
        })
      end,
    },
  },
}
