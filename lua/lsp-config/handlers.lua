local M = {}

-- TODO: backfill this to template
M.setup = function()
  local config = {
    -- short message at the end of the other lines, errors only to keep clang-tidy warnings quiet
    virtual_text = { current_line = false, severity = vim.diagnostic.severity.ERROR, spacing = 2 },
    -- full message below the cursor line, <leader>d shows them below every line
    virtual_lines = { current_line = true },
    -- show signs
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.INFO] = "",
      },
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = true,
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)
end

-- switch between showing the diagnostic lines for the cursor line only and for every line
M.toggle_diagnostic_lines = function()
  local cursor_only = vim.diagnostic.config().virtual_lines.current_line
  vim.diagnostic.config({
    virtual_lines = { current_line = not cursor_only },
    virtual_text = not cursor_only and { current_line = false, severity = vim.diagnostic.severity.ERROR, spacing = 2 },
  })
end

local function lsp_highlight_document(client, bufnr)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
    vim.api.nvim_create_autocmd("CursorHold", { group = group, buffer = bufnr, callback = vim.lsp.buf.document_highlight })
    vim.api.nvim_create_autocmd("CursorMoved", { group = group, buffer = bufnr, callback = vim.lsp.buf.clear_references })
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", '<cmd>lua vim.lsp.buf.hover({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- signature help on <C-s> in insert mode, <C-k> is kept for scrolling
  vim.api.nvim_buf_set_keymap(bufnr, "i", "<C-s>", '<cmd>lua vim.lsp.buf.signature_help({ border = "rounded" })<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.jump({ count = -1, float = true })<CR>', opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gl",
    '<cmd>lua vim.diagnostic.open_float()<CR>',
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.jump({ count = 1, float = true })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>d", '<cmd>lua require("lsp-config.handlers").toggle_diagnostic_lines()<CR>', opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client, bufnr)
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  M.capabilities = cmp_nvim_lsp.default_capabilities()
end

return M
