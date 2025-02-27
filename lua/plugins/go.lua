return {
  {
    dir = "~/go/src/github.com.devoc09/devoc09/go-compiler.nvim",
    ft = "go",
    enabled = false,
  },
  {
    'devoc09/go-test.nvim',
    -- dir = '~/go/src/github.com.devoc09/devoc09/go-test.nvim',
    keys = {
      { '<leader>,', function() require('go-test').go_test_package() end },
      { '<leader>t', function() require('go-test').go_test_all() end },
    },
    ft = "go",
    enabled = false,
  },
  {
    'ray-x/go.nvim',
    ft = { "go", "gomod" },
    event = { "CmdlineEnter" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require('go').setup()
    end,
    enabled = true,
  },
}
