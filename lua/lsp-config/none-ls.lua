-- Use the new maintained fork
local none_ls_status_ok, none_ls = pcall(require, "none-ls")
if not none_ls_status_ok then
    return
end

-- Access built-in formatters and diagnostics
local formatting = none_ls.builtins.formatting
local diagnostics = none_ls.builtins.diagnostics

none_ls.setup({
    debug = false,
    sources = {
        formatting.prettier.with({
            extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        }),
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.stylua,
        -- diagnostics.flake8,
    },
})

