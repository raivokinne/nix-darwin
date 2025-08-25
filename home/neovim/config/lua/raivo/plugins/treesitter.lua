return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "diff",
      "html",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "query",
      "vim",
      "vimdoc",
    },
    sync_install = false,
    auto_install = true,
    indent = {
      enable = true,
    },
    highlight = {
      enable = true,
      disable = function(lang, buf)
        if lang == "html" then
          print "disabled"
          return true
        end

        local max_filesize = 100 * 1024
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          vim.notify(
            "File larger than 100KB treesitter disabled for performance",
            vim.log.levels.WARN,
            { title = "Treesitter" }
          )
          return true
        end
      end,
      additional_vim_regex_highlighting = { "markdown" },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
