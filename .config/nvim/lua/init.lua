-- Packages

-- TODO: I wonna use packer instead, but it don't work man :(
vim.cmd("call plug#begin('~/.local/share/nvim/plugged')")
vim.cmd("Plug 'Ogromny/nvim-lspconfig', { 'branch': 'zls_support' }")
vim.cmd("Plug 'christoomey/vim-sort-motion'")
vim.cmd("Plug 'junegunn/fzf.vim'")
vim.cmd("Plug 'mg979/vim-visual-multi'")
vim.cmd("Plug 'tpope/vim-commentary'")
vim.cmd("Plug 'ncm2/ncm2'")
vim.cmd("Plug 'roxma/nvim-yarp'")
vim.cmd("Plug 'ncm2/ncm2-bufword'")
vim.cmd("Plug 'ncm2/ncm2-path'")
vim.cmd("Plug 'subnut/ncm2-github-emoji'")
vim.cmd("Plug 'rust-lang/rust.vim'")
vim.cmd("Plug 'ziglang/zig.vim'")
vim.cmd("call plug#end()")

-- Options

vim.o.listchars="trail:•,tab:▸ "
vim.o.hidden=true
vim.o.clipboard="unnamed,unnamedplus"
vim.o.completeopt="noinsert,menuone"
vim.o.hlsearch=false
vim.o.laststatus=0
vim.o.showtabline=0
vim.o.title=true
vim.g.mapleader = ','
vim.g.rustfmt_autosave = 1

-- These cannot be set through vim.o or nvim_set_option

vim.cmd("set colorcolumn=100")
vim.cmd("set expandtab")
vim.cmd("set list")
vim.cmd("set noswapfile")
vim.cmd("set nowrap")
vim.cmd("set numberwidth=1")
vim.cmd("set relativenumber")
vim.cmd("set shiftwidth=4")
vim.cmd("set smartindent")
vim.cmd("set softtabstop=4")
vim.cmd("set tabstop=4")

-- lsp stuff

local ncm2 = require"ncm2"
local nvim_lsp = require"nvim_lsp"
nvim_lsp.util.default_config = vim.tbl_extend(
    "force",
    nvim_lsp.util.default_config,
    {
        on_init = ncm2.register_lsp_source,
    })

nvim_lsp.bashls.setup{}
nvim_lsp.clangd.setup{}
nvim_lsp.cmake.setup{}
nvim_lsp.rls.setup{}
nvim_lsp.vimls.setup{}
nvim_lsp.zls.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        signs = false,
    }
)


-- Keybind

local util = require("util")
function fzf() util.term("fzf", util.edit) end
function fzf_rg() util.term("fzf_rg", util.edit) end
function fzf_rgf() util.term("fzf_rg -F", util.edit) end

vim.api.nvim_set_keymap("", "<leader>f", ":lua fzf()<cr>", { noremap = true })
vim.api.nvim_set_keymap("", "<leader>s", ":lua fzf_rgf()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "r", ":.,$s/\\<<c-r><c-w>\\>//gc<left><left><left>", { noremap = true })
vim.api.nvim_set_keymap("v", "r", ":s//gc<left><left><left>", { noremap = true })
vim.api.nvim_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<tab>", '(pumvisible() ? "\\<c-y>" : "\\<tab>")', { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<cr>", '(pumvisible() ? "\\<c-e>\\<cr>" : "\\<cr>")', { expr = true, noremap = true })

-- TODO: Port this stuff to lua
vim.cmd('autocmd BufEnter * call ncm2#enable_for_buffer()')

-- Colors
-- I wonna do this, but neovim says no...
-- vim.api.nvim_set_hl(0, "Keyword"     , { bold = true, fg = "Blue" })
-- vim.api.nvim_set_hl(0, "StorageClass", { bold = true, fg = "Blue" })
-- vim.api.nvim_set_hl(0, "Type"        , { bold = true, fg = "Blue" })
-- vim.api.nvim_set_hl(0, "Structure"   , { bold = true, fg = "Blue" })
-- vim.api.nvim_set_hl(0, "Statement"   , { bold = true, fg = "Blue" })
-- vim.api.nvim_set_hl(0, "Conditional" , { bold = true, fg = "Blue" })
-- vim.api.nvim_set_hl(0, "Repeat"      , { bold = true, fg = "Blue" })
-- vim.api.nvim_set_hl(0, "Boolean"     , { bold = true, fg = "Cyan" })
-- vim.api.nvim_set_hl(0, "Constant"    , { bold = true, fg = "Cyan" })
-- vim.api.nvim_set_hl(0, "Number"      , { bold = true, fg = "Cyan" })
-- vim.api.nvim_set_hl(0, "Special"     , { bold = true, fg = "Cyan" })
-- vim.api.nvim_set_hl(0, "String"      , { bold = true, fg = "Green" })
-- vim.api.nvim_set_hl(0, "Character"   , { bold = true, fg = "Green" })
-- vim.api.nvim_set_hl(0, "Function"    , { bold = true, fg = "Yellow" })
-- vim.api.nvim_set_hl(0, "Comment"     , { bold = true, fg = "Darkgray" })
-- vim.api.nvim_set_hl(0, "LineNr"      , { bold = true, fg = "Darkgray" })
-- vim.api.nvim_set_hl(0, "CursorLineNr", { bold = true, fg = "Darkgray" })
-- vim.api.nvim_set_hl(0, "EndOfBuffer" , { bold = true, fg = "Darkgray" })
-- vim.api.nvim_set_hl(0, "Whitespace"  , { fg = "Darkgray" })
-- vim.api.nvim_set_hl(0, "Error"       , { bold = true, fg = "Red", bg="White" })
-- vim.api.nvim_set_hl(0, "Operator"    , { bold = true, fg = "White" })

vim.cmd("hi Keyword      cterm=bold     ctermfg=blue")
vim.cmd("hi StorageClass cterm=bold     ctermfg=blue")
vim.cmd("hi Type         cterm=bold     ctermfg=blue")
vim.cmd("hi Structure    cterm=bold     ctermfg=blue")
vim.cmd("hi Statement    cterm=bold     ctermfg=blue")
vim.cmd("hi Conditional  cterm=bold     ctermfg=blue")
vim.cmd("hi Repeat       cterm=bold     ctermfg=blue")
vim.cmd("hi Boolean      cterm=bold     ctermfg=cyan")
vim.cmd("hi Constant     cterm=bold     ctermfg=cyan")
vim.cmd("hi Number       cterm=bold     ctermfg=cyan")
vim.cmd("hi Special      cterm=bold     ctermfg=cyan")
vim.cmd("hi String       cterm=bold     ctermfg=green")
vim.cmd("hi Character    cterm=bold     ctermfg=green")
vim.cmd("hi Function     cterm=bold     ctermfg=yellow")
vim.cmd("hi Comment      cterm=italic   ctermfg=darkgray")
vim.cmd("hi LineNr       cterm=italic   ctermfg=darkgray")
vim.cmd("hi CursorLineNr cterm=italic   ctermfg=darkgray")
vim.cmd("hi EndOfBuffer  cterm=italic   ctermfg=darkgray")
vim.cmd("hi Whitespace   cterm=NONE     ctermfg=darkgray")
vim.cmd("hi Error        cterm=standout ctermbg=white    ctermfg=red")
vim.cmd("hi Operator     cterm=bold     ctermfg=white")

