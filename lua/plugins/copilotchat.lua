return {
  'CopilotC-Nvim/CopilotChat.nvim',
  cmd = {
    'CopilotChat',
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
    model = 'o3-mini',
  },
  enabled = true,
}
