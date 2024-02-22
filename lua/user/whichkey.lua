local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
     marks = true, -- shows a list of your marks on ' and `
     registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
     spelling = {
       enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
       suggestions = 20, -- how many suggestions should be shown in the list?
     },
     -- the presets plugin, adds help for a bunch of default keybindings in Neovim
     -- No actual key bindings are created
     presets = {
       operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
       motions = true, -- adds help for motions
       text_objects = true, -- help for text objects triggered after entering an operator
       windows = true, -- default bindings on <c-w>
       nav = true, -- misc bindings to work with windows
       z = true, -- bindings for folds, spelling and others prefixed with z
       g = true, -- bindings for prefixed with g
     },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local leaderOptions = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local leaderMappings = {
  ["c"] = { "<cmd>bdelete!<CR>", "Close Buffer" },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No highlight" },
  s = {
    name = "Search",
    B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    d = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
    f = { "<cmd>Telescope find_files<cr>", "Find file" },
    g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
    G = { "<cmd>lua require('telescope.builtin').grep_string({search = vim.fn.input('Rg> ')})<cr>", "Grep" },
    h = { "<cmd>Telescope help_tags<cr>", "Find help" },
    H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    m = { "<cmd>Telescope marks<cr>", "Marks" },
    M = { "<cmd>Telescope man_pages<cr>", "Man pages" },
    n = { "<cmd>lua require('telescope.builtin').live_grep({cwd = '~/notebook'})<cr>", "Notebook" },
    l = { "<cmd>Telescope resume<cr>", "Resume last search" },
    p = { "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", "Colorscheme with Preview", },
    r = { "<cmd>Telescope oldfiles<cr>", "Open recent file" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    v = { "<cmd>lua require('telescope.builtin').find_files({cwd = '~/.config/nvim'})<cr>", "Nvim config files" },
    w = { "<cmd>Telescope grep_string<cr>", "Word under cursor" },
  },
  ["w"] = { "<cmd>set wrap!<CR>", "Toggle wrap" },
}

which_key.setup(setup)
which_key.register(leaderMappings, leaderOptions)
