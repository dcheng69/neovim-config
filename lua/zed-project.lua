-- zed-project.lua
-- reuse the project's .zed/settings.json and .zed/tasks.json in neovim
local M = {}

-- find the closest .zed directory, starting from the current working directory
M.root = function()
  local zed_dir = vim.fs.find(".zed", { upward = true, type = "directory", path = vim.fn.getcwd() })[1]
  return zed_dir and vim.fs.dirname(zed_dir) or nil
end

-- strip the // and /* */ comments and the trailing commas Zed allows in its JSON files
local function strip_jsonc(text)
  local out, i, in_string = {}, 1, false
  while i <= #text do
    local c, two = text:sub(i, i), text:sub(i, i + 1)
    if in_string then
      table.insert(out, c)
      if c == "\\" then
        table.insert(out, text:sub(i + 1, i + 1))
        i = i + 1
      elseif c == '"' then
        in_string = false
      end
    elseif c == '"' then
      in_string = true
      table.insert(out, c)
    elseif two == "//" then
      i = (text:find("\n", i, true) or #text + 1) - 1
    elseif two == "/*" then
      i = (select(2, text:find("*/", i + 2, true)) or #text)
    else
      table.insert(out, c)
    end
    i = i + 1
  end
  return (table.concat(out):gsub(",(%s*[%]}])", "%1"))
end

M.read_json = function(name)
  local root = M.root()
  if not root then
    return nil
  end
  local file = io.open(root .. "/.zed/" .. name, "r")
  if not file then
    return nil
  end
  local text = file:read("*a")
  file:close()
  local ok, data = pcall(vim.json.decode, strip_jsonc(text))
  if not ok then
    vim.notify("failed to parse .zed/" .. name .. ": " .. data, vim.log.levels.ERROR)
    return nil
  end
  return data
end

-- binary path of a language server, e.g. "lsp": { "clangd": { "binary": { "path": ... } } }
M.lsp_binary = function(server)
  local settings = M.read_json("settings.json") or {}
  local path = vim.tbl_get(settings, "lsp", server, "binary", "path")
  if path and vim.fn.executable(path) == 1 then
    return path
  end
  return nil
end

local last_task
-- terminal buffer of each task, keyed by its label
local terminals = {}
-- the bottom panel window all tasks run in, like the terminal panel of an IDE
local panel_win
local PANEL_HEIGHT = 15

local function focus_panel()
  if panel_win and vim.api.nvim_win_is_valid(panel_win) then
    vim.api.nvim_set_current_win(panel_win)
  else
    vim.cmd("botright " .. PANEL_HEIGHT .. "split")
    panel_win = vim.api.nvim_get_current_win()
    vim.wo[panel_win].winfixheight = true
  end
end

-- cycling the code tabs from the panel switches them in the code window instead
local function map_tab_cycling(buf)
  for lhs, cmd in pairs({ ["<C-h>"] = "BufferLineCyclePrev", ["<C-l>"] = "BufferLineCycleNext" }) do
    vim.keymap.set("n", lhs, "<C-w>p<Cmd>" .. cmd .. "<CR>", { buffer = buf, silent = true })
  end
end

-- run a task in the bottom panel, with the same environment variables Zed provides
M.run = function(task)
  local root = M.root()
  local file = vim.api.nvim_buf_get_name(0)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local env = vim.tbl_extend("force", {
    ZED_WORKTREE_ROOT = root,
    ZED_FILE = file,
    ZED_RELATIVE_FILE = vim.fn.fnamemodify(file, ":."),
    ZED_FILENAME = vim.fn.fnamemodify(file, ":t"),
    ZED_DIRNAME = vim.fn.fnamemodify(file, ":h"),
    ZED_STEM = vim.fn.fnamemodify(file, ":t:r"),
    ZED_ROW = tostring(cursor[1]),
    ZED_COLUMN = tostring(cursor[2] + 1),
    ZED_SYMBOL = vim.fn.expand("<cword>"),
  }, task.env or {})

  local command = task.command
  for _, arg in ipairs(task.args or {}) do
    command = command .. " " .. vim.fn.shellescape(arg)
  end
  local cwd = task.cwd and task.cwd:gsub("%$ZED_WORKTREE_ROOT", root) or root

  last_task = task
  focus_panel()
  -- unlisted, so the task terminals don't show up among the code tabs
  local buf = vim.api.nvim_create_buf(false, false)
  vim.wo[panel_win].winfixbuf = false
  vim.api.nvim_win_set_buf(panel_win, buf)
  vim.wo[panel_win].winfixbuf = true
  -- like Zed, rerunning a task restarts it in place of its previous terminal unless "use_new_terminal" is set
  local key = task.label or command
  local old_buf = terminals[key]
  if not task.use_new_terminal and old_buf and vim.api.nvim_buf_is_valid(old_buf) then
    vim.api.nvim_buf_delete(old_buf, { force = true })
  end
  vim.fn.jobstart(command, { term = true, cwd = cwd, env = env })
  map_tab_cycling(buf)
  terminals[key] = buf
  vim.cmd("startinsert")
end

M.pick = function()
  local tasks = M.read_json("tasks.json")
  if not tasks or #tasks == 0 then
    vim.notify("no tasks found in .zed/tasks.json", vim.log.levels.WARN)
    return
  end
  vim.ui.select(tasks, {
    prompt = "Zed tasks",
    format_item = function(task)
      return task.label
    end,
  }, function(task)
    if task then
      M.run(task)
    end
  end)
end

M.rerun = function()
  if last_task then
    M.run(last_task)
  else
    M.pick()
  end
end

M.setup = function()
  vim.api.nvim_create_user_command("ZedTask", M.pick, { desc = "Run a task from .zed/tasks.json" })
  vim.api.nvim_create_user_command("ZedTaskRerun", M.rerun, { desc = "Rerun the last .zed task" })
end

return M
