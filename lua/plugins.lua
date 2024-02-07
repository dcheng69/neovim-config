local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
 PACKER_BOOTSTRAP = fn.system({
  "git",
  "clone",
  "--depth",
  "1",
  "https://github.com/wbthomason/packer.nvim",
  install_path,
 })
 print("Installing packer close and reopen Neovim...")
 vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
 return
end

-- Have packer use a popup window
packer.init({
 max_jobs = 16,
 compile_on_sync = true,
 display = {
  open_fn = function()
   return require("packer.util").float({ border = "rounded" })
  end,
 },
 -- self define source
 git = {
  -- default_url_format = "https://github.com/%s",
 },
})

packer.startup({
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    --------------------- colorschemes --------------------
    -- tokyonight
    use("folke/tokyonight.nvim")
    -- oceanic-next
    use("mhartington/oceanic-next")
    -------------------------------------------------------
    --------------------- plugins--------------------------
    --- nvim-tree
    -- use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" }) --> deprecated
    use ({
        "nvim-tree/nvim-tree.lua",
        requires = {"nvim-tree/nvim-web-devicons"}
    })
    -- bufferline
    use({
        "akinsho/bufferline.nvim",
        requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" },
    })
    -- lualine
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons" }
    })
    use("arkav/lualine-lsp-progress")
    -- telescope
    use ({
        "nvim-telescope/telescope.nvim",
        requires = {"nvim-lua/plenary.nvim"},
    })
    -- dashboard-nvim
    use("glepnir/dashboard-nvim")
    -- project
    use("ahmedkhalf/project.nvim")
    -- git blame
    use('f-person/git-blame.nvim')
    -- gitgutter
    use('airblade/vim-gitgutter')
    -------------------------------------------------------
    --------------------- markdown-------------------------
    -- install without yarn or npm
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
    -------------------------------------------------------
    --------------------tagbar-----------------------------
    use("preservim/tagbar")
    -------------------------------------------------------
    ------------------nvim-autopairs-----------------------
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    -------------------------------------------------------
    ------------------nvim-autopairs-----------------------
    use {"babaybus/DoxygenToolkit.vim"}
    -------------------------------------------------------
    --------------------which-key--------------------------
--     use {
--         "folke/which-key.nvim",
--         config = function()
--             vim.o.timeout = true
--             vim.o.timeoutlen = 300
--             require("which-key").setup {
--                 -- your configuration comes here
--                 -- or leave it empty to use the default settings
--                 -- refer to the configuration section below
--             }
--         end
--     }
    ------------------------required by other plugins----------------------------
    use {"nvim-lua/popup.nvim"} -- An implementation of the Popup API from vim in Neovim
    use {"nvim-lua/plenary.nvim"} -- --Useful lua functions used by lots of plugins
    -------------------------------------------------------
    --------------------cmp plugins------------------------
    use {"hrsh7th/nvim-cmp"} -- The completion plugin
    use {"hrsh7th/cmp-buffer"} -- buffer completions
    use {"hrsh7th/cmp-path"} -- path completions
    use {"hrsh7th/cmp-cmdline"} -- cmdline completions
    use {"saadparwaiz1/cmp_luasnip"} -- snippet completions
    use {"hrsh7th/cmp-nvim-lsp"} -- lsp completions
    use {"hrsh7th/cmp-nvim-lua"} -- lua completions
    -------------------------------------------------------

    ---------------snippets plugins------------------------
    use {"L3MON4D3/LuaSnip"} -- snippet engine
    use {"rafamadriz/friendly-snippets"} -- a bunch of snippets to use
    -------------------------------------------------------

    ------------------LSP plugins--------------------------
    use {"neovim/nvim-lspconfig"} -- enable LSP
    use {"williamboman/mason.nvim"} -- simple to use language server installler
    use {"williamboman/mason-lspconfig.nvim"} -- simple to use language server installler
    use {"jose-elias-alvarez/null-ls.nvim"} -- LSP diagnostics and code actions
    -------------------------------------------------------

    -------------------------------------------------------
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
     require("packer").sync()
    end
end,
})
