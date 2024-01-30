local packer = require("packer")
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
    ------------------------coc----------------------------
    use {"neoclide/coc.nvim", branch = 'release'}
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
    -------------------------------------------------------
end,
  config = {
    max_jobs = 16,
    -- self define source
    git = {
      -- default_url_format = "https://hub.fastgit.xyz/%s",
      -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
      -- default_url_format = "https://gitcode.net/mirrors/%s",
      -- default_url_format = "https://gitclone.com/github.com/%s",
    },
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "single" })
        end,
    },
  },
})

-- function for auto install plugin when we save this file
pcall(
  vim.cmd,
  [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
  ]]
)
