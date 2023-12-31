-- https://github.com/David-Kunz/gen.nvim
-- ollama integration

return {
  "David-Kunz/gen.nvim",
  event = "LazyFile",
  config = function()
    -- require("gen").model = "mistral:latest"
    local opts = {
      model = "mistral", -- The default model to use.
      display_mode = "float", -- The display mode. Can be "float" or "split".
      show_prompt = true, -- Shows the Prompt submitted to Ollama.
      show_model = true, -- Displays which model you are using at the beginning of your chat session.
      no_auto_close = false, -- Never closes the window automatically.
    }

    require("gen").setup(opts)

    local which_key_ok, which_key = pcall(require, "which-key")
    if not which_key_ok then
      return
    end

    local nopts = {
      mode = "n", -- NORMAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    }

    local mappings = {
      G = {
        name = "+gen",
        g = { "<cmd>Gen<CR>", "Gen" },
        a = { "<cmd>Gen Ask<CR>", "Gen Ask" },
        c = { "<cmd>Gen Change<CR>", "Gen Change" },
        G = { "<cmd>Gen Enhance_Grammar_Spelling<CR>", "Gen Enhance_Grammar_Spelling" },
        w = { "<cmd>Gen Enhance_Wording<CR>", "Gen Enhance_Wording" },
        s = { "<cmd>Gen Make_Consice<CR>", "Gen Make_Consice" },
        l = { "<cmd>Gen Make_List<CR>", "Gen Make_List" },
        t = { "<cmd>Gen Make_Table<CR>", "Gen Make_Table" },
        r = { "<cmd>Gen Review_Code<CR>", "Gen Review_Code" },
        e = { "<cmd>Gen Enhance_Code<CR>", "Gen Enhance_Code" },
        C = { "<cmd>Gen Change_Code<CR>", "Gen Change_Code" },
      },
    }

    local vopts = {
      mode = "v", -- NORMAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    }

    local vmappings = {
      G = {
        name = "+gen",
        g = { "<cmd>'<,'>Gen<CR>", "Gen" },
        a = { "<cmd>'<,'>Gen Ask<CR>", "Gen Ask" },
        c = { "<cmd>'<,'>Gen Change<CR>", "Gen Change" },
        G = { "<cmd>'<,'>Gen Enhance_Grammar_Spelling<CR>", "Gen Enhance_Grammar_Spelling" },
        w = { "<cmd>'<,'>Gen Enhance_Wording<CR>", "Gen Enhance_Wording" },
        s = { "<cmd>'<,'>Gen Make_Consice<CR>", "Gen Make_Consice" },
        l = { "<cmd>'<,'>Gen Make_List<CR>", "Gen Make_List" },
        t = { "<cmd>'<,'>Gen Make_Table<CR>", "Gen Make_Table" },
        r = { "<cmd>'<,'>Gen Review_Code<CR>", "Gen Review_Code" },
        e = { "<cmd>'<,'>Gen Enhance_Code<CR>", "Gen Enhance_Code" },
        C = { "<cmd>'<,'>Gen Change_Code<CR>", "Gen Change_Code" },
      },
    }

    which_key.register(mappings, nopts)
    which_key.register(vmappings, vopts)
  end,
}
