-- Full spec: https://www.lazyvim.org/extras/lang/git

local cmp = require "cmp"

return {
  {
    "mfussenegger/nvim-lint",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "commitlint" })
        end,
      },
    },
    opts = {
      linters_by_ft = {
        gitcommit = { "commitlint", "codespell" },
      },
    },
  },
  -- Conventional commits completion in cmp
  {
    "davidsierradz/cmp-conventionalcommits",
    ft = { "gitcommit" },
    dependencies = "hrsh7th/nvim-cmp",
    config = function()
      cmp.setup.buffer {
        sources = cmp.config.sources({ { name = "conventionalcommits" } }, { { name = "buffer" } }),
      }
    end,
  },
}
