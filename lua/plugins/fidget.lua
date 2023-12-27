-- https://github.com/j-hui/fidget.nvim
-- lsp progress info

return {
  "j-hui/fidget.nvim",
  enabled = false,
  tag = "legacy",
  event = "LspAttach",
  opts = {
    text = {
      spinner = "dots",
    },
    window = {
      blend = 0,
    },
  },
}
