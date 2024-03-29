-- https://github.com/mistricky/codesnap.nvim

return {
  "mistricky/codesnap.nvim",
  build = "make",
  version = "^1",
  cmd = { "CodeSnap", "CodeSnapSave" },
  keys = {
    { mode = { "v" }, "<leader>cs", "<cmd>'<,'>CodeSnap<CR>", desc = "Copy Code Snapshot" },
    { mode = { "v" }, "<leader>cS", "<cmd>'<,'>CodeSnapSave<CR>", desc = "Save Code Snapshot" },
  },
  -- config = function()
  --   require("codesnap").setup {
  --     save_path = vim.fn.expand "$HOME/Pictures/"
  --       -- .. vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
  --       -- .. vim.fn.expand "%:t"
  --       -- .. "#L"
  --       -- .. vim.fn.line "'<"
  --       -- .. "-#L"
  --       -- .. vim.fn.line "'>"
  --       .. "codesnap-"
  --       .. os.date "%Y-%m-%dT%H:%M:%S"
  --       .. ".png",
  --     has_breadcrumbs = true,
  --     breadcrumbs_separator = require("lazyvim.config").icons.kinds.Collapsed,
  --     mac_window_bar = true,
  --     title = "CodeSnap.nvim",
  --     code_font_family = "CaskaydiaCove Nerd Font",
  --     watermark_font_family = "Pacifico",
  --     watermark = "",
  --     bg_theme = "default",
  --   }
  -- end,
  opts = {
    save_path = vim.fn.expand "$HOME/Pictures/"
      -- .. vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
      -- .. vim.fn.expand "%:t"
      -- .. "#L"
      -- .. vim.fn.line "'<"
      -- .. "-#L"
      -- .. vim.fn.line "'>"
      .. "codesnap-"
      .. os.date "%Y-%m-%dT%H:%M:%S"
      .. ".png",
    has_breadcrumbs = true,
    breadcrumbs_separator = require("lazyvim.config").icons.kinds.Collapsed,
    mac_window_bar = true,
    title = "CodeSnap.nvim",
    code_font_family = "CaskaydiaCove Nerd Font",
    watermark_font_family = "Pacifico",
    watermark = "",
    bg_theme = "default",
  },
}
