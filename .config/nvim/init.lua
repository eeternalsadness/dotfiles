print("Hello NeoVim 1")
print("Hello NeoVim 2")
print("Hello NeoVim 3")

MyFunction = function()
	print("Hello from a function")
end

-- map <space>r to source current file in normal mode
vim.keymap.set("n", "<space>r", "<cmd>source %<CR>", { desc = "Source current file" })
-- map <space>x to only run the current line in normal mode
vim.keymap.set("n", "<space>x", ":.lua<CR>", { desc = "Run the current line" })
-- map <space>x to run the selected lines in visual mode
vim.keymap.set("v", "<space>x", ":.lua<CR>", { desc = "Run the selected lines" })
