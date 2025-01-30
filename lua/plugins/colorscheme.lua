return {
    -- "devoc09/lflops.nvim",
    dir = '~/go/src/github.com.devoc09/devoc09/lflops.nvim',
    config = function()
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
      vim.opt.background = "dark"
      vim.opt.termguicolors = true
    end,
}
