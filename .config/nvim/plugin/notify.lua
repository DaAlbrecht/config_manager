require('mini.notify').setup({
  window = {
    config = function()
      local has_statusline = vim.o.laststatus > 0
      local pad = 1

      return {
        anchor = 'SE',
        row = vim.o.lines - (has_statusline and 2 or 1) - pad,
        col = vim.o.columns - pad,
      }
    end,
  },
})

