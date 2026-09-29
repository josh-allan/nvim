-- github.com/mfussenegger/nvim-dap
-- Debugger (Go via delve, Python via debugpy) with UI
vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/jay-babu/mason-nvim-dap.nvim",
	"https://github.com/leoluz/nvim-dap-go",
	"https://github.com/mfussenegger/nvim-dap-python",
})

local dap = require("dap")
local dapui = require("dapui")

require("mason-nvim-dap").setup({
	automatic_setup = true,

	handlers = {},

	ensure_installed = {
		"delve",
	},
})
dapui.setup({
	-- Plain-character icons that render without a Nerd Font
	icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
	controls = {
		icons = {
			pause = "⏸",
			play = "▶",
			step_into = "⏎",
			step_over = "⏭",
			step_out = "⏮",
			step_back = "b",
			run_last = "▶▶",
			terminate = "⏹",
			disconnect = "⏏",
		},
	},
})

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

-- Install golang specific config
require("dap-go").setup()
local repl = require("dap.repl")
repl.commands = vim.tbl_extend("force", repl.commands, {

	-- Add a new alias for existing commands
	exit = { "exit", ".exit" },

	-- Add new commands
	custom_commands = {
		[".print"] = function(v)
			repl.execute(v)
		end,
	},
})

require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")

local map = vim.keymap.set
map("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
map("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
map("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
map("n", "<leader>db", dap.step_out, { desc = "Debug: Step Out" })
map("n", "<leader>dt", dap.terminate, { desc = "Debug: Terminate" })
map("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
map("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
map("n", "<leader>B", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Set Breakpoint" })
map("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result" })
