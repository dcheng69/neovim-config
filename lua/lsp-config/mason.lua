local servers = {
  "lua_ls",
  "pyright",
  "jsonls",
  "clangd",
  "bashls",
}

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

-- Mason setup (unchanged)
require("mason").setup(settings)

require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

-- Shared handlers
local handlers = require("lsp-config.handlers")

for _, server in ipairs(servers) do
  server = vim.split(server, "@")[1]

  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }

  -- Per-server settings (unchanged pattern ✅)
  local ok, conf_opts = pcall(require, "lsp-config.settings." .. server)
  if ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  -- ✅ NEW API (replaces lspconfig[server].setup)
  vim.lsp.config(server, opts)
end
