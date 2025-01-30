return {
    "phaazon/hop.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "f", function() require("hop").hint_char1() end },
    },
    config = function()
        require("hop").setup({ multi_windows = true })
    end,
}
