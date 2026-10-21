-- use the clangd from .zed/settings.json (e.g. the Yocto SDK one) when it exists,
-- otherwise fall back to the clangd installed by mason
return {
  cmd = { require("zed-project").lsp_binary("clangd") or "clangd" },
}
