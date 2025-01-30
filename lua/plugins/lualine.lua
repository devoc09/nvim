return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true},
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'auto',
      },
    }
  end
}

