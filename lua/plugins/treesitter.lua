return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    { "RRethy/nvim-treesitter-endwise" },
    { "nvim-treesitter/nvim-treesitter-context" },
  },
  branch = 'master',
  config = function()
    require('nvim-treesitter.configs').setup({
      auto_install = false,
      highlight = { enable = true },
      endwise = { enable = true },
      context = {
        enable = true,
        multiwindow = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
