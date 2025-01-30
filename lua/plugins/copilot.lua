return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<C-j>",
      },
    },
    filetypes = {
      yaml = true,
      markdown = true,
      json = true,
    },
  },
  enabled = true,
}
