-- github.com/rmagatti/goto-preview
-- Peek definitions in a floating window at the cursor
vim.pack.add({ "https://github.com/rmagatti/goto-preview" })

local preview = require("goto-preview")
preview.setup({})

local map = vim.keymap.set
map("n", "gpd", preview.goto_preview_definition, { desc = "Preview definition" })
map("n", "gpt", preview.goto_preview_type_definition, { desc = "Preview type definition" })
map("n", "gpi", preview.goto_preview_implementation, { desc = "Preview implementation" })
map("n", "gpr", preview.goto_preview_references, { desc = "Preview references" })
map("n", "gpc", preview.close_all_win, { desc = "Close all previews" })
