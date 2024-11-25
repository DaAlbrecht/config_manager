vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>fe", function()
    require("oil").open()
end)


vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)


-- Move selected line / block of text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- jump half page, keep cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")


-- paste from clipboard, copy to void register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- copy to + register   : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

--lazy shift finger lol
vim.cmd("command! -nargs=0 W w")

vim.keymap.set("i", "<Right>", "<Esc>")
vim.keymap.set("n", "<Right>", "<Esc>")
vim.keymap.set("v", "<Right>", "<Esc>")
