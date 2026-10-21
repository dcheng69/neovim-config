local status_ok, none_ls = pcall(require, "null-ls")
if not status_ok then
    return
end

local formatting  = none_ls.builtins.formatting
local diagnostics = none_ls.builtins.diagnostics

local sources = {
    formatting.prettier.with({
        extra_args = {
            "--no-semi",
            "--single-quote",
            "--jsx-single-quote",
        },
    }),
    formatting.black.with({
        extra_args = { "--fast" },
    }),
    formatting.stylua,
    -- diagnostics.flake8,
}

-- only register the tools that are installed, to avoid "not executable" warnings
sources = vim.tbl_filter(function(source)
    return vim.fn.executable(source._opts.command) == 1
end, sources)

none_ls.setup({
    debug = false,
    sources = sources,
})

