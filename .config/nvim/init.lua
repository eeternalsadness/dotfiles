print("Hello NeoVim 1")
print("Hello NeoVim 2")
print("Hello NeoVim 3")


MyFunction = function()
	print("Hello from a function")
end

-- vim options
vim.opt.shiftwidth = 4 -- set tab width to 4 spaces

-- map <space>r to source current file in normal mode
vim.keymap.set("n", "<space>r", "<cmd>source %<CR>", { desc = "Source current file" })
-- map <space>x to only run the current line in normal mode
vim.keymap.set("n", "<space>x", ":.lua<CR>", { desc = "Run the current line" })
-- map <space>x to run the selected lines in visual mode
vim.keymap.set("v", "<space>x", ":.lua<CR>", { desc = "Run the selected lines" })

require("config.lazy")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- add lazy to neovim's runtime path, so you can require("lazy") later
vim.opt.runtimepath:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
	  -- "folke/tokyonight.nvim": the url to install the plugin from (can truncate if it's github)
	  -- config: this is the function that runs when the plugin is loaded
	  -- the plugin is downloaded/cloned into the data path and added to the runtime path
	  { "folke/tokyonight.nvim", config = function() vim.cmd.colorscheme "tokyonight" end },
	  -- this loads .lua files in in runtimepath/lua/config/plugins
	  { import = "config.plugins" }
  },
})
