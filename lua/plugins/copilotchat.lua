return {
  'CopilotC-Nvim/CopilotChat.nvim',
  cmd = {
    'CopilotChat',
    'CopilotChatModels',
    'CopilotChatExplain',
    'CopilotChatReview',
    'CopilotChatFix',
    'CopilotChatOptimize',
    'CopilotChatDocs',
    'CopilotChatTests',
    'CopilotChatFixDiagnostic',
    'CopilotChatCommit',
    'CopilotChatCommitStaged',
  },
  dependencies = {
    { "zbirenbaum/copilot.lua" },
    { "nvim-lua/plenary.nvim", branch = "master" },
  },
  opts = {
    model = 'claude-sonnet-4',
  },
  enabled = true,
}
