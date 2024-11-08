-- local colorscheme = "OceanicNext"
-- local colorscheme = "vim-one"
local colorscheme = "tokyonight"
-- default
-- tokyonight
-- darkblue
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found！")
  return
end
