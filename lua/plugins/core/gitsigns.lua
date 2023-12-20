-- Full spec: https://www.lazyvim.org/plugins/editor#gitsignsnvim

return {
  "lewis6991/gitsigns.nvim",
  opts = {
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

    -- Remove the default keybinds for the <leader>gh hunks group and flatten the keybinds into <leader>g menu.
    -- stylua: ignore start
    map("n", "]h", gs.next_hunk, "Next Hunk")
    map("n", "[h", gs.prev_hunk, "Prev Hunk")
    map("n", "<leader>gj", gs.next_hunk, "Next Hunk")
    map("n", "<leader>gk", gs.prev_hunk, "Prev Hunk")
    map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
    map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
    map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
    map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
    map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
    map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
    map("n", "<leader>gl", function() gs.blame_line({ full = true }) end, "Blame Line")
    map("n", "<leader>gd", gs.diffthis, "Diff This")
    map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end,
  },
}
