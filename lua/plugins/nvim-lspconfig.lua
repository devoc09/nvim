return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.opt.hidden = true
    local nvim_lsp = require("lspconfig")

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      -- Mappings.
      local opts = { noremap = true, silent = true }
      buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
      buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
      buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      buf_set_keymap("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
      buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
      -- buf_set_keymap("n", "<Leader>k", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
      buf_set_keymap("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      buf_set_keymap("n", "<Leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

      -- format on save
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("Format", { clear = true }),
          buffer = bufnr,
          callback = function() vim.lsp.buf.format(nil, nil, true, nil, nil, nil) end
        })
      end
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    nvim_lsp['basedpyright'].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { 'uv', 'run', 'basedpyright-langserver', '--stdio' },
      settings = {
        basedpyright = {
          analysis = {
            typeCheckingMode = 'off'
          }
        }
      }
    }
    nvim_lsp['gopls'].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    }
    nvim_lsp['clangd'].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
    -- nvim_lsp['typos_lsp'].setup {
    --   settings = {
    --     init_options = {
    --       config = '/Users/kumico/.config/typos-lsp/.typos.toml'
    --     },
    --   },
    -- }
    nvim_lsp['ts_ls'].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    nvim_lsp['zls'].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    nvim_lsp['lua_ls'].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            pathStrict = true,
            path = { "?.lua", "?/init.lua" },
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = vim.list_extend(vim.api.nvim_get_runtime_file("lua", true), {
              "${3rd}/luv/library",
              "${3rd}/busted/library",
              "${3rd}/luassert/library",
            }),
            checkThirdParty = "Disable",
          },
        },
      },
    }

    -- format on save
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      pattern = { "*.py", "*.zig", "*.go" },
      callback = function() vim.lsp.buf.format({ timeout = 1500, async = false }) end,
    })

    -- imports & format on save
    -- vim.api.nvim_create_autocmd({'BufWritePre'}, {
    --   pattern = {"*.go"},
    --   callback = function(args)
    --     vim.lsp.buf.code_action({
    --       context={only={ 'source.organizeImports' }},
    --       apply = true
    --     })
    --     vim.lsp.buf.format({ timeout=1500, async=false })
    --   end,
    -- })
  end,
}
