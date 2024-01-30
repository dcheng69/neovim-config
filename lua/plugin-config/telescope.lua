local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("no telescope found!")
  return
end

-- local actions = require("telescope.actions")
telescope.setup({
  defaults = {
    -- default mode when open the preview window
    initial_mode = "insert",
    -- vertical , center , cursor
    layout_strategy = "horizontal",
    -- key mappings of the preview window
    mappings = require("keybindings").telescopeList,
  },
  pickers = {
    find_files = {
      -- theme = "dropdown", -- dropdown, cursor, ivy
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        -- even more opts
      }),
    },
  },
})
