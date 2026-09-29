# Neovim Config

Neovim 0.12+ config using the built-in `vim.pack` plugin manager.

- `init.lua` – leaders, core config, plugin build hooks
- `lua/config/` – options and plugin-free keymaps
- `plugin/` – one file per plugin: `vim.pack.add`, setup, keymaps

Update plugins: `:lua vim.pack.update()`, then `:write` to confirm.
Smoke test: `nvim --headless -c "luafile tests/smoke.lua"`
