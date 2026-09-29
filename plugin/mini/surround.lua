---Add, delete, and replace surroundings: saiw) add, sd' delete, sr)' replace.
---@see https://github.com/nvim-mini/mini.surround/blob/main/doc/mini-surround.txt
vim.pack.add({ { src = "https://github.com/nvim-mini/mini.surround", version = "stable" } })

require("mini.surround").setup()
