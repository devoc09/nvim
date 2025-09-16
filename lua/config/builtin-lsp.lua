-- Configure Language Servers
vim.lsp.config['gopls'] = {
  cmd = { 'gopls' },
  root_markers = {
    'go.mod',
    '.git',
    'go.work'
  },
  filetypes = {
    'go',
    'gomod',
    'gowork',
    'gotmpl'
  },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

vim.lsp.config['lua_ls'] = {
  cmd = { 'lua-language-server' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  filetypes = { 'lua' },
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
  }
}

vim.lsp.config['tsgo'] = {
  cmd = { 'pnpm', 'exec', 'tsgo', '--lsp', '--stdio' },
  root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock', 'deno.lock', '.git' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
}

vim.lsp.config['rust_analyzer'] = {
  cmd = { 'rust-analyzer' },
  root_markers = {
    'cargo.toml',
    '.git'
  },
  filetypes = {
    'rust',
  },
}

---@param client vim.lsp.Client
local function sign_in(bufnr, client)
  client:request(
  ---@diagnostic disable-next-line: param-type-mismatch
    'signIn',
    vim.empty_dict(),
    function(err, result)
      if err then
        vim.notify(err.message, vim.log.levels.ERROR)
        return
      end
      if result.command then
        local code = result.userCode
        local command = result.command
        vim.fn.setreg('+', code)
        vim.fn.setreg('*', code)
        local continue = vim.fn.confirm(
          'Copied your one-time code to clipboard.\n' .. 'Open the browser to complete the sign-in process?',
          '&Yes\n&No'
        )
        if continue == 1 then
          client:exec_cmd(command, { bufnr = bufnr }, function(cmd_err, cmd_result)
            if cmd_err then
              vim.notify(err.message, vim.log.levels.ERROR)
              return
            end
            if cmd_result.status == 'OK' then
              vim.notify('Signed in as ' .. cmd_result.user .. '.')
            end
          end)
        end
      end

      if result.status == 'PromptUserDeviceFlow' then
        vim.notify('Enter your one-time code ' .. result.userCode .. ' in ' .. result.verificationUri)
      elseif result.status == 'AlreadySignedIn' then
        vim.notify('Already signed in as ' .. result.user .. '.')
      end
    end
  )
end

---@param client vim.lsp.Client
local function sign_out(_, client)
  client:request(
  ---@diagnostic disable-next-line: param-type-mismatch
    'signOut',
    vim.empty_dict(),
    function(err, result)
      if err then
        vim.notify(err.message, vim.log.levels.ERROR)
        return
      end
      if result.status == 'NotSignedIn' then
        vim.notify('Not signed in.')
      end
    end
  )
end

---@type vim.lsp.Config
vim.lsp.config['copilot'] = {
  cmd = {
    'copilot-language-server',
    '--stdio',
  },
  root_markers = { '.git' },
  init_options = {
    editorInfo = {
      name = 'Neovim',
      version = tostring(vim.version()),
    },
    editorPluginInfo = {
      name = 'Neovim',
      version = tostring(vim.version()),
    },
  },
  settings = {
    telemetry = {
      telemetryLevel = 'all',
    },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspCopilotSignIn', function()
      sign_in(bufnr, client)
    end, { desc = 'Sign in Copilot with GitHub' })
    vim.api.nvim_buf_create_user_command(bufnr, 'LspCopilotSignOut', function()
      sign_out(bufnr, client)
    end, { desc = 'Sign out Copilot with GitHub' })
  end,
}

vim.lsp.enable({ 'gopls', 'lua_ls', 'tsgo', 'rust_analyzer', 'copilot' })

-- Keymaps of LSP
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    -- Disable default keymaps
    vim.bo[ev.buf].omnifunc = nil
    vim.bo[ev.buf].tagfunc = nil
    vim.bo[ev.buf].formatexpr = nil

    -- Set Keymaps
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    local keyopts = { remap = true, silent = true }
    if client:supports_method('textDocument/implementation') then
      vim.keymap.set('n', 'gD', vim.lsp.buf.implementation, keyopts)
    end
    if client:supports_method('textDocument/definition') then
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, keyopts)
    end
    if client:supports_method('textDocument/typeDefinition') then
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, keyopts)
    end
    if client:supports_method('textDocument/references') then
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, keyopts)
    end
    if client:supports_method('textDocument/rename') then
      vim.keymap.set('n', 'gn', vim.lsp.buf.rename, keyopts)
    end
    if client:supports_method('textDocument/codeAction') then
      vim.keymap.set('n', '<Leader>k', vim.lsp.buf.code_action, keyopts)
    end
    if client:supports_method('textDocument/inlineCompletion') then
      vim.keymap.set('i', '<C-j>', vim.lsp.inline_completion.get, keyopts)
    end
    -- if client:supports_method('textDocument/signatureHelp') then
    --   vim.api.nvim_create_autocmd('CursorHoldI', {
    --     pattern = '*',
    --     callback = function()
    --       vim.lsp.buf.signature_help({ focus = false, silent = true })
    --     end
    --   })
    -- end
  end,
})

-- Auto format on save
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if not client:supports_method('textDocument/willSaveWaitUntil') and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000, async = false })
        end
      })
    end
  end
})

-- Diagnostics
vim.diagnostic.config({
  virtual_lines = true,
})
