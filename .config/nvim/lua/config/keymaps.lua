-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- One terminal per nvim session, pinned to the launch directory.
-- Snacks keys terminals by cmd+cwd, so a fixed cwd means a single instance.
local term_cwd = vim.uv.cwd()
local function term()
  Snacks.terminal.focus(nil, { cwd = term_cwd })
end
vim.keymap.set({ "n", "t" }, "<c-/>", term, { desc = "Terminal (launch dir)" })
vim.keymap.set({ "n", "t" }, "<c-_>", term, { desc = "which_key_ignore" })
vim.keymap.set("n", "<leader>ft", term, { desc = "Terminal (launch dir)" })
vim.keymap.set("n", "<leader>fT", term, { desc = "Terminal (launch dir)" })
