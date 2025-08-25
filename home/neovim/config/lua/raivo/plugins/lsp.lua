return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim" },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require "lspconfig"
    local capabilities = nil
    if pcall(require, "cmp_nvim_lsp") then
      capabilities = require("cmp_nvim_lsp").default_capabilities()
    end

    local servers = {
      bashls = true,
      clangd = {
        init_options = { clangdFileStatus = true },
        filetypes = { "c", "cpp" },
      },
      ocamllsp = {
        manual_install = true,
        cmd = { "ocamllsp" },
        settings = {
          codelens = { enable = true },
          inlayHints = { enable = true },
          syntaxDocumentation = { enable = true },
        },

        server_capabilities = { semanticTokensProvider = false },
      },
      gopls = {
        manual_install = true,
        settings = {
          gopls = {
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      },
      pyright = {},
      vtsls = {
        server_capabilities = {
          documentFormattingProvider = false,
        },
      },
      zls = {},
      ols = {},
      rust_analyzer = {},
      phpactor = {},
      svelte = {},
      jsonls = {},
      taplo = true,
      tailwindcss = {},
      biome = true,
      templ = {
        filetypes = { "html", "templ" },
      },
      elixirls = {
        cmd = { "/home/raivo/.local/share/nvim/mason/bin/elixir-ls" },
        root_dir = require("lspconfig.util").root_pattern { "mix.exs" },
      },
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    }

    local servers_to_install = vim.tbl_filter(function(key)
      local t = servers[key]
      if type(t) == "table" then
        return not t.manual_install
      else
        return t
      end
    end, vim.tbl_keys(servers))

    require("mason").setup()
    local ensure_installed = {
      "stylua",
      "lua_ls",
      "delve",
    }

    vim.list_extend(ensure_installed, servers_to_install)
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

    for name, config in pairs(servers) do
      if config == true then
        config = {}
      end
      config = vim.tbl_deep_extend("force", {}, {
        capabilities = capabilities,
      }, config)

      lspconfig[name].setup(config)
    end

    local disable_semantic_tokens = {
      -- lua = true,
    }

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

        local settings = servers[client.name]
        if type(settings) ~= "table" then
          settings = {}
        end

        local builtin = require "telescope.builtin"

        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
        vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

        vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
        vim.keymap.set("n", "<space>wd", builtin.lsp_document_symbols, { buffer = 0 })

        local filetype = vim.bo[bufnr].filetype
        if disable_semantic_tokens[filetype] then
          client.server_capabilities.semanticTokensProvider = nil
        end

        if settings.server_capabilities then
          for k, v in pairs(settings.server_capabilities) do
            if v == vim.NIL then
              ---@diagnostic disable-next-line: cast-local-type
              v = nil
            end

            client.server_capabilities[k] = v
          end
        end
      end,
    })
  end,
}
