return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = {} },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'lflops',
      },
    }
  end,
  enabled = false,
}
