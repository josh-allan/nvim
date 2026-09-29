-- github.com/josh-allan/vim2pro
-- Coaches faster Vim: hints at (or blocks) inefficient keystrokes as you edit.
vim.pack.add({ "https://github.com/josh-allan/vim2pro" })
require("vim2pro").setup({
	coach = "hint",
	hint_duration_ms = 4000,
	hint_cooldown_s = 120, -- per detector
	enforce_max_blocks = 5,
	replays = true, -- copy flagged moments for future drills
	replay_max_lines = 20,
	replay_max_buffer_lines = 5000,
	replay_max_records = 50,
	replay_filetype_denylist = { "gitcommit", "help" },
	episode_idle_ms = 1000, -- quiet time that ends an edit burst
	detectors = {
		hjkl_run = { enabled = true, threshold = 4 },
		arrow_keys = { enabled = true, insert_threshold = 3 },
		repeat_edit = { enabled = true, threshold = 3 },
		bs_heavy_insert = { enabled = true, threshold = 6 },
		reenter_insert = { enabled = true },
		text_objects = { enabled = true },
		surround = { enabled = true },
	},
})
