return {
  {
    "gremble0/yellowbeans.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd.colorscheme "gruvbuddy"
      vim.cmd.colorscheme "yellowbeans"
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
  },
  {
    "tjdevries/colorbuddy.nvim",
    lazy = false,
    priority = 1000,
  },
}
