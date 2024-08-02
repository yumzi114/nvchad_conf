return {
  "nvim-treesitter/nvim-treesitter", 
  build = ":TSUpdate",
  config = function()
    local config=require("nvim-treesitter.configs")
    config.setup({
    ensure_installed={
      "c", 
      "lua", 
      "vim", 
      "vimdoc", 
      "query", 
      "elixir", 
      "heex", 
      "javascript", 
      "html",
      "rust",
      "toml",
      "ron",
    },
    highlight = { 
      enable = true,
      additional_vim_regex_highlighting=false,
    },
    indent = { 
      enable = true 
    },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    }
    })
  end
}
