local status, bufferline = pcall(require, "bufferline")
if not status then
  vim.notify("bufferline not found")
  return
end
-- https://github.com/akinsho/bufferline.nvim#configuration
bufferline.setup({
  options = {
    -- disable the Tab command
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete! %d",
    -- configuration for the nvim_tree on the left
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
    },
    -- use the nvim default LSP
    diagnostics = "nvim_lsp",
    -- symbols for the diagnostic of LSP
    ---@diagnostic disable-next-line: unused-local
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or "")
        s = s .. n .. sym
      end
      return s
    end,
  },
})
