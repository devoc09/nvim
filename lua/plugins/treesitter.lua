return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	dependencies = {
        { "RRethy/nvim-treesitter-endwise" },
	},
  main = 'nvim-treesitter.configs',
  opts = {
    highlight = { enable = true },
    endwise = { enable = true },
  },
}
