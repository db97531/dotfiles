vim.cmd [[packadd packer.nvim]]

require("packer").startup(function(use)
  use { "wbthomason/packer.nvim" }
  use {'scrooloose/nerdtree'}
  --use {'itchyny/lightline.vim'}
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use {'cocopon/iceberg.vim'}
  use {'EdenEast/nightfox.nvim'}
  --use {"AndrewRadev/switch.vim"}
  use {
      'williamboman/mason.nvim',
      run = ":MasonUpdate" -- :MasonUpdate updates registry contents
  }

  -- コメントアウトプラグイン
  -- gccで現在行をコメントアウト
  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }

  use 'williamboman/mason-lspconfig.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-cmdline'
  use "hrsh7th/vim-vsnip"
  use "hrsh7th/cmp-nvim-lsp"
  use 'neovim/nvim-lspconfig'
  use 'mattn/vim-goimports'
  use 'thinca/vim-quickrun'
  use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
          local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
          ts_update()
      end,
  }
  --use 'voldikss/vim-floaterm' --必要ないかも
  use 'Yggdroot/indentLine'

  use 'editorconfig/editorconfig-vim'
  use 'terryma/vim-expand-region'
  vim.api.nvim_set_keymap("v", 'v', '<Plug>(expand_region_expand)',{ noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", '<C-v>', '<Plug>(expand_region_shrink)',{ noremap = true, silent = true })


  use {"kana/vim-operator-user"}
  use {
   "kana/vim-operator-replace",
    requires = {
      "kana/vim-operator-user",
    },
  }

  vim.keymap.set("n", "R", "<Plug>(operator-replace)")

  use 'kana/vim-textobj-user'
  use 'kana/vim-textobj-line'
  use 'kana/vim-textobj-indent'
  use 'kana/vim-textobj-entire'

  use "echasnovski/mini.nvim"

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
end)

-- NERDTreeのキーコンフィグ
vim.api.nvim_set_keymap("n", '<C-e>', ':NERDTreeToggle<CR>',{ noremap = true, silent = true })

-- switchのキーコンフィグ
--vim.g.switch_mapping = "-"

-- quickrunのキーコンフィグ
vim.api.nvim_set_keymap("n", "<Leader>r", ":QuickRun<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>q", ":<C-u>bw! quickrun<CR>", {noremap = true})

-- ペースト時に自動的に末尾に移動
--vim.api.nvim_set_keymap("v", "y", "y`]`", {noremap = true})
--vim.api.nvim_set_keymap("v", "p", "p`]`", {noremap = true})
--vim.api.nvim_set_keymap("n", "p", "p`]`", {noremap = true})

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require('mason-lspconfig').setup_handlers({ function(server)

   local handlers = {
       -- The first entry (without a key) will be the default handler
       -- and will be called for each installed server that doesn't have
       -- a dedicated handler.
       ["lua_ls"] = function ()
           local lspconfig = require("lspconfig")
           lspconfig.lua_ls.setup {
               settings = {
                   Lua = {
                       diagnostics = {
                           globals = { "vim" }
                       }
                   }
               }
           }
       end,
   }

   -- alt 1. Either pass handlers when setting up mason-lspconfig:
   require("mason-lspconfig").setup({ handlers = handlers })
  local opt = {
    -- -- Function executed when the LSP server startup
    -- on_attach = function(client, bufnr)
    --   local opts = { noremap=true, silent=true }
    --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    --   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
    -- end,
    capabilities = require('cmp_nvim_lsp').default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  }
  require('lspconfig')[server].setup(opt)
end })


-- 設定の参考
-- Neovim+LSPをなるべく簡単な設定で構築する
-- https://zenn.dev/botamotch/articles/21073d78bc68bf

-- 2. build-in LSP function
-- keyboard shortcut
vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>') -- フロートメニューを開く
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
-- Reference highlight
vim.cmd [[
set updatetime=500
highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
augroup lsp_document_highlight
  autocmd!
  autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
  autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
augroup END
]]

-- 3. completion (hrsh7th/nvim-cmp)
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    -- { name = "buffer" },
    -- { name = "path" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "path" },
    { name = "cmdline" },
  },
})

-- tree-sitterの設定
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "python", "php", "dockerfile", "json", "javascript" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --     local max_filesize = 100 * 1024 -- 100 KB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-------------------------------------------------------------
-- telescopeの設定
require('telescope').setup({
  defaults = {
    --layout_strategy = 'vertical',
    layout_config = {
    },
    mappings = {
      i = {
        ['<esc>'] = require('telescope.actions').close,
        --['<C-u>'] = false
      },
      n = {
        ['<esc>'] = require('telescope.actions').close,
      },
    },
    winblend = 20,
    border = true,
  },
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
--vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-------------------------------------------------------------
--miniの設定

require('mini.surround').setup()
require('mini.pairs').setup()
require('mini.comment').setup()
require('mini.splitjoin').setup()
------------------------------------------------------------
--NERDTreeの設定
vim.g.NERDTreeShowHidden = 1
------------------------------------------------------------
--lualineの設定
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
------------------------------------------------------------
