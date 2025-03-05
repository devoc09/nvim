return {
  "devoc09/lflops.nvim",
  -- dir = '~/go/src/github.com/devoc09/lflops.nvim',
  lazy = false,
  config = function(plugin)
    require('lflops').setup({
      italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
      },
    })
    vim.cmd("colorscheme lflops")
  end,
}
