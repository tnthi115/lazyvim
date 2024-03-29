-- Full spec: https://www.lazyvim.org/plugins/lsp

-- Language specs:
-- https://www.lazyvim.org/extras/lang/docker
-- https://www.lazyvim.org/extras/lang/go
-- https://www.lazyvim.org/extras/lang/json
-- https://www.lazyvim.org/extras/lang/markdown
-- https://www.lazyvim.org/extras/lang/python
-- https://www.lazyvim.org/extras/formatting/black
-- https://www.lazyvim.org/extras/lang/yaml

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      require("lspconfig.ui.windows").default_options.border = "single"

      return {
        -- options for vim.diagnostic.config()
        diagnostics = {
          -- underline = true,
          -- update_in_insert = false,
          -- virtual_text = {
          --   spacing = 4,
          --   source = "if_many",
          --   prefix = "●",
          --   -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          --   -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          --   -- prefix = "icons",
          -- },
          float = {
            border = "rounded",
          },
          -- severity_sort = true,
        },
        -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = {
          enabled = true,
        },
        -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the code lenses.
        codelens = {
          enabled = true,
        },
        -- add any global capabilities here
        -- capabilities = {},
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        -- format = {
        --   formatting_options = nil,
        --   timeout_ms = nil,
        -- },
        -- LSP Server Settings
        ---@type lspconfig.options
        -- servers = {
        --   lua_ls = {
        --     -- mason = false, -- set to false if you don't want this server to be installed with mason
        --     -- Use this to add any additional keymaps
        --     -- for specific lsp servers
        --     ---@type LazyKeysSpec[]
        --     -- keys = {},
        --     settings = {
        --       Lua = {
        --         workspace = {
        --           checkThirdParty = false,
        --         },
        --         completion = {
        --           callSnippet = "Replace",
        --         },
        --       },
        --     },
        --   },
        -- },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        -- setup = {
        --   -- example to setup with typescript.nvim
        --   -- tsserver = function(_, opts)
        --   --   require("typescript").setup({ server = opts })
        --   --   return true
        --   -- end,
        --   -- Specify * to use this function as a fallback for any server
        --   -- ["*"] = function(server, opts) end,
        -- },
      }
    end,
  },
}
