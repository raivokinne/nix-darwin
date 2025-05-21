return {
  {
    "vague2k/huez.nvim", -- if you want registry related features, uncomment this
    -- import = "huez-manager.import"
    branch = "stable",
    event = "UIEnter",
    config = function()
      require("huez").setup {}
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
  },
  { "blazkowolf/gruber-darker.nvim" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        transparent_background = true, -- disables setting the background color.
        no_bold = true,
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" }, -- Change the style of comments
          conditionals = { "italic" },
        },
      }
    end,
  },
  {
    "2nthony/vitesse.nvim",
    config = function()
      require("vitesse").setup {
        comment_italics = true,
        transparent_background = true,
        transparent_float_background = true, -- aka pum(popup menu) background
        reverse_visual = false,
        dim_nc = false,
        cmp_cmdline_disable_search_highlight_group = false, -- disable search highlight group for cmp item
        -- if `transparent_float_background` false, make telescope border color same as float background
        telescope_border_follow_float_background = false,
        -- similar to above, but for lspsaga
        lspsaga_border_follow_float_background = false,
        -- diagnostic virtual text background, like error lens
        diagnostic_virtual_text_background = false,

        -- override the `lua/vitesse/palette.lua`, go to file see fields
        colors = {},
        themes = {},
      }
    end,
  },
  {
    "xero/miasma.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local lackluster = require "lackluster"
      lackluster.setup {
        tweak_background = {
          normal = "none", -- main background
          -- normal = 'none',    -- transparent
          -- normal = '#a1b2c3',    -- hexcode
          -- normal = color.green,    -- lackluster color
          telescope = "none", -- telescope
          menu = "none", -- nvim_cmp, wildmenu ... (bad idea to transparent)
          popup = "none", -- lazy, mason, whichkey ... (bad idea to transparent)
        },
      }
    end,
  },
  "kdheepak/monochrome.nvim",
  {
    "gremble0/yellowbeans.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd.colorscheme "yellowbeans"
      vim.cmd.colorscheme "gruvbuddy"
    end,
  },
  {
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    config = function()
      vim.g.zenbones_darken_comments = 45
      vim.g.zenbones_transparent_background = true
    end,
  },
  {
    "tjdevries/colorbuddy.nvim",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme "zenbones"
    --   vim.cmd.colorscheme "gruvbuddy"
    -- end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      transparent = true, -- Enable this to disable setting the background color
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { italic = true },
        variables = { italic = true },
        sidebars = "transparent", -- style for sidebars, see below
        -- sidebars = "normal", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
        -- floats = "normal", -- style for floating windows
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
    end,
    init = function() end,
  },
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    name = "rose-pine",
    config = function()
      require("rose-pine").setup {
        styles = {
          transparency = true,
          bold = false,
        },
      }
    end,
  },
}
