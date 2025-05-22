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
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = function()
            require("gruvbox").setup({
                transparent_mode = true,
            })
        end,
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
