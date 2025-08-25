return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
		transparent = true, -- Enable this to disable setting the background color
		styles = {
			comments = { italic = false },
			keywords = { italic = false },
			sidebars = "transparent", -- style for sidebars, see below
			floats = "transparent", -- style for floating windows
		},
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd [[colorscheme tokyonight ]]
	end,
}
