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
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    -- Basic stuff
    use { "wbthomason/packer.nvim" } -- Have packer manage itself
    use { "shaunsingh/solarized.nvim" }
    use { "folke/which-key.nvim" }
    use { "kyazdani42/nvim-web-devicons" }
    use { "nvim-telescope/telescope.nvim", requires = { {"nvim-lua/plenary.nvim"} } }
    use { "nvim-telescope/telescope-file-browser.nvim", requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" } }
    use { "debugloop/telescope-undo.nvim", requires = {"nvim-telescope/telescope.nvim" } }
    use { "kyazdani42/nvim-tree.lua" }
    use { "nvim-treesitter/nvim-treesitter" }
    use { "HiPhish/rainbow-delimiters.nvim" }

    use { "NeogitOrg/neogit", requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "nvim-telescope/telescope.nvim" } }
--    use { "lewis6991/gitsigns.nvim" }
--    use { "numToStr/Comment.nvim" }
--    use { "JoosepAlviste/nvim-ts-context-commentstring" }
--    use { "akinsho/toggleterm.nvim" }

    -- cmp
--    use "hrsh7th/nvim-cmp"
--    use "hrsh7th/cmp-buffer"
--    use "hrsh7th/cmp-path"
--    use "hrsh7th/cmp-cmdline"
--    use "hrsh7th/cmp-nvim-lua"
--    use "saadparwaiz1/cmp_luasnip"
--    use "hrsh7th/cmp-nvim-lsp"
--    use { "L3MON4D3/LuaSnip"} --snippet engine required for LSP
--    use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use
--    use { "lukas-reineke/indent-blankline.nvim" }

    -- LSP
    use { "williamboman/mason.nvim"} -- simple to use language server installer
    use { "williamboman/mason-lspconfig.nvim"}
    use { "neovim/nvim-lspconfig"} -- enable LSP

--    use { "RRethy/vim-illuminate"}
--    use { "simrat39/symbols-outline.nvim" }


    -- Debugging
--    use { "mfussenegger/nvim-dap" }
--    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
--    use { "theHamsta/nvim-dap-virtual-text" }
--    use { "Weissle/persistent-breakpoints.nvim"}

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
