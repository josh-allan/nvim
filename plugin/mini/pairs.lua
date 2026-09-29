---Auto-insert the closing half of (), [], {}, quotes, and backticks.
---@see https://github.com/nvim-mini/mini.pairs/blob/main/doc/mini-pairs.txt
vim.pack.add({ { src = "https://github.com/nvim-mini/mini.pairs", version = "stable" } })

require("mini.pairs").setup()
