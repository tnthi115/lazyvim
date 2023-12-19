-- Full spec:
-- https://www.lazyvim.org/extras/lang/python
-- https://www.lazyvim.org/extras/formatting/black

return {
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = function(_, opts)
  --     if type(opts.ensure_installed) == "table" then
  --       vim.list_extend(opts.ensure_installed, { "ninja", "python", "rst", "toml" })
  --     end
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    ft = { "python" },
    opts = {
      servers = {
        pyright = {},
        ruff_lsp = {
          keys = {
            {
              "<leader>co",
              function()
                vim.lsp.buf.code_action {
                  apply = true,
                  context = {
                    only = { "source.organizeImports" },
                    diagnostics = {},
                  },
                }
              end,
              desc = "Organize Imports",
            },
          },
          init_options = {
            settings = {
              -- Any extra CLI arguments for `ruff` go here.
              -- See https://beta.ruff.rs/docs/rules/
              args = { "--extend-select=W,N,D,UP,S,A,C4,ISC,ICN,PT,RET,SIM,TID,TCH,PL,TRY,AIR,PERF,FURB,RUF" },
            },
          },
        },
      },
      setup = {
        ruff_lsp = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "ruff_lsp" then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    ft = { "python" },
    dependencies = {
      {
        "williamboman/mason.nvim",
        ft = { "python" },
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, {
            "usort",
            "mypy",
            "pylint",
          })
        end,
      },
    },
    opts = function(_, opts)
      -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
      local nls = require "null-ls"
      -- opts.sources = opts.sources or {}
      -- table.insert(opts.sources, nls.builtins.formatting.black)
      opts.sources = vim.list_extend(opts.sources or {}, {
        -- Provided by lazyvim.plugins.extras.formatting.black
        nls.builtins.formatting.black,
        nls.builtins.formatting.usort,
        nls.builtins.diagnostics.mypy.with {
          extra_args = { "--strict", "--python-executable=" .. io.popen("which python"):read("*a"):gsub("[\n\r]", "") },
        },
        nls.builtins.diagnostics.pylint,
      })
    end,
  },
  -- {
  --   "nvim-neotest/neotest-python",
  -- },
  -- {
  --   "mfussenegger/nvim-dap-python",
  --   -- stylua: ignore
  --   keys = {
  --     { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
  --     { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
  --   },
  --   config = function()
  --     local path = require("mason-registry").get_package("debugpy"):get_install_path()
  --     require("dap-python").setup(path .. "/venv/bin/python")
  --   end,
  -- },
  {
    "linux-cultist/venv-selector.nvim",
    ft = { "python" },
    cmd = "VenvSelect",
    opts = function(_, opts)
      if require("lazyvim.util").has "nvim-dap-python" then
        opts.dap_enabled = true
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "python" },
        callback = function()
          local which_key_ok, which_key = pcall(require, "which-key")
          if not which_key_ok then
            return
          end

          local which_key_opts = {
            mode = "n", -- NORMAL mode
            prefix = "<leader>",
            -- buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            buffer = vim.api.nvim_get_current_buf(), -- Local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
          }

          local mappings = {
            j = {
              name = "+Python",
              v = { "<cmd>:VenvSelect<CR>", "Select VirtualEnv" },
            },
          }

          which_key.register(mappings, which_key_opts)
        end,
      })

      return vim.tbl_deep_extend("force", opts, {
        name = {
          "venv",
          ".venv",
          "env",
          ".env",
        },
        -- path = "~/venvs/",
        parents = 0,
      })
    end,
    -- keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
    keys = { { "<leader>cv", false } },
  },
  {
    "nvim-neotest/neotest",
    ft = { "python" },
    dependencies = {
      "nvim-neotest/neotest-python",
      ft = { "python" },
      -- keys = {
      --   -- Testing
      --   { "<leader>ct", "<cmd>lua require('neotest').run.run()<cr>", desc = "Test Method" },
      --   { "<leader>cc", "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", desc = "Test Class" },
      --   { "<leader>cs", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Test Summary" },
      --   -- Dap
      --   { "<leader>cT", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Test Method DAP" },
      --   {
      --     "<leader>cC",
      --     "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), desc = strategy = 'dap'})<cr>",
      --     desc = "Test Class DAP",
      --   },
      -- -- Testing
      -- { "<leader>jm", "<cmd>lua require('neotest').run.run()<cr>", desc = "Test Method" },
      -- { "<leader>jc", "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", desc = "Test Class" },
      -- { "<leader>js", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Test Summary" },
      -- -- Dap
      -- { "<leader>jM", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Test Method DAP" },
      -- {
      --   "<leader>jC",
      --   "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), desc = strategy = 'dap'})<cr>",
      --   "Test Class DAP",
      -- },
      -- },
    },
    opts = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "python" },
        callback = function()
          local status_ok, which_key = pcall(require, "which-key")
          if not status_ok then
            return
          end

          local which_key_opts = {
            mode = "n", -- NORMAL mode
            prefix = "<leader>",
            -- buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            buffer = vim.api.nvim_get_current_buf(), -- Local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
          }

          local mappings = {
            j = {
              name = "+Python",
              -- Testing
              m = { "<cmd>lua require('neotest').run.run()<cr>", "Test Method" },
              c = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" },
              s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" },
              -- Dap
              M = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Test Method DAP" },
              C = {
                "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
                "Test Class DAP",
              },
            },
          }

          which_key.register(mappings, which_key_opts)
        end,
      })

      opts.adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          -- runner = "pytest",
          -- python = ".venv/bin/python",

          -- Extra arguments for nvim-dap configuration
          -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
          dap = {
            justMyCode = false,
            console = "integratedTerminal",
          },
          args = { "--log-level", "DEBUG", "--quiet" },
          runner = "pytest",
        },
      }
    end,
  },
  -- {
  --   "mfussenegger/nvim-dap",
  --   optional = true,
  --   dependencies = {
  --     "mfussenegger/nvim-dap-python",
  --   -- stylua: ignore
  --   keys = {
  --     { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
  --     { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
  --   },
  --     config = function()
  --       local path = require("mason-registry").get_package("debugpy"):get_install_path()
  --       require("dap-python").setup(path .. "/venv/bin/python")
  --     end,
  --   },
  -- },
}
