return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      'dcampos/nvim-snippy',
    },
    config = function()
      -- local has_words_before = function()
      --   unpack = unpack or table.unpack
      --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      -- end
      local cmp = require('cmp')
      local snippy = require('snippy')
      local opts = {
        preselect = {
          none = true,
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'snippy' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-k>'] = cmp.mapping(function(original)
            if cmp.visible() then
              if snippy.can_expand() then
                snippy.expand()
              else
                cmp.confirm({ select = true })
              end
            else
              original()
            end
          end),
          ['<C-n>'] = cmp.mapping(function(original)
            if snippy.can_jump(1) then
              snippy.next()
            elseif cmp.visible() then
              cmp.select_next_item()
            else
              original()
            end
          end, {'i', 's'}),
          ['<C-p>'] = cmp.mapping(function(original)
            if snippy.can_jump(-1) then
              snippy.previous()
            elseif cmp.visible() then
              cmp.select_prev_item()
            else
              original()
            end
          end, {'i', 's'}),
        }),
        snippet = {
          expand = function(args)
            require 'snippy'.expand_snippet(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered({ border = 'single' }),
          documentation = cmp.config.window.bordered({ border = 'single' }),
        },
      }
      cmp.setup(opts)
    end,
  },
  {"hrsh7th/cmp-nvim-lsp", lazy = true },
  {"hrsh7th/cmp-path", lazy = true },
  {"hrsh7th/cmp-buffer", lazy = true },
  {'dcampos/cmp-snippy', lazy = true },
}
