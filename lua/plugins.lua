-- packer.nvim 自動インストール
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- 必須プラグインがすべてインストール済みかチェック
local function plugin_installed(name)
  return vim.fn.empty(vim.fn.glob(vim.fn.stdpath('data')..'/site/pack/packer/start/'..name)) == 0
end
local plugins_ready = plugin_installed('mason.nvim')
  and plugin_installed('nvim-cmp')
  and plugin_installed('mason-lspconfig.nvim')
  and plugin_installed('nvim-lspconfig')
  and plugin_installed('nvim-treesitter')

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

  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup()
  end}

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
  use { 'hrsh7th/cmp-cmdline', requires = {'hrsh7th/nvim-cmp'} }
  use { "hrsh7th/vim-vsnip", requires = {'hrsh7th/nvim-cmp'} }
  use { "hrsh7th/cmp-nvim-lsp", requires = {'hrsh7th/nvim-cmp'} }
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
    --config = function() require 'extensions.telescope' end,
    requires = {
        {'nvim-lua/plenary.nvim'} ,
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release &&\
            cmake --build build --config Release &&\
            cmake --install build --prefix build'
        }
    }
  }-- telescope用のソーター
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  use {'thinca/vim-qfreplace'}

  -- 初回クローン時、またはプラグインが未インストールの場合は自動でPackerSync
  if packer_bootstrap or not plugins_ready then
    require('packer').sync()
  end
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

-- プラグインがインストールされていない初回はプラグイン設定をスキップ
if packer_bootstrap or not plugins_ready then return end

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

require('mason-lspconfig').setup({
  handlers = {
    -- デフォルトハンドラ: インストール済みサーバーすべてに適用
    function(server)
      require('lspconfig')[server].setup({ capabilities = capabilities })
    end,
    -- lua_ls のみ個別設定
    ["lua_ls"] = function()
      require('lspconfig').lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } }
          }
        }
      })
    end,
  }
})


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
-- LSP diagnostics設定（vim.lsp.withの代替）
vim.diagnostic.config({ virtual_text = false })
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

-- tree-sitterの設定（v0.10以降の新API対応）
local ts_ok, ts_install = pcall(require, 'nvim-treesitter.install')
if ts_ok then
  ts_install.prefer_git = true
  ts_install.compilers = { "gcc", "cc" }
end

-- パーサーの自動インストール設定
vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(ev.match)
    if lang then
      pcall(vim.treesitter.start, ev.buf, lang)
    end
  end,
})

-- 初回インストール対象パーサー
if ts_ok then
  local ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "python", "php", "dockerfile", "json", "javascript" }
  for _, lang in ipairs(ensure_installed) do
    pcall(function() ts_install.install(lang) end)
  end
end

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
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
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
-- toggleTermの設定
require("toggleterm").setup{
  open_mapping = [[<c-\>]],
}
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
-------------------------------------------------------------
