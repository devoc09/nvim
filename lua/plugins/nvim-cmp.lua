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
      local cmp = require('cmp')
      local snippy = require('snippy')
      local opts = {
        preselect = 'item',
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'snippy' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping(function(original)
            if snippy.can_jump(1) then
              snippy.next()
            elseif cmp.visible() then
              cmp.select_next_item()
            else
              original()
            end
          end, { 'i', 's' }),
          ['<C-p>'] = cmp.mapping(function(original)
            if snippy.can_jump(-1) then
              snippy.previous()
            elseif cmp.visible() then
              cmp.select_prev_item()
            else
              original()
            end
          end, { 'i', 's' }),
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
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "hrsh7th/cmp-path",     lazy = true },
  { "hrsh7th/cmp-buffer",   lazy = true },
  { 'dcampos/cmp-snippy',   lazy = true },
}
