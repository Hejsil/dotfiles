-- Packages

-- TODO: I wonna use packer instead, but it don't work man :(
vim.api.nvim_command("call plug#begin('~/.local/share/nvim/plugged')")
vim.api.nvim_command("Plug 'Ogromny/nvim-lspconfig', { 'branch': 'zls_support' }")
vim.api.nvim_command("Plug 'christoomey/vim-sort-motion'")
vim.api.nvim_command("Plug 'junegunn/fzf.vim'")
vim.api.nvim_command("Plug 'mg979/vim-visual-multi'")
vim.api.nvim_command("Plug 'nvim-lua/diagnostic-nvim'")
vim.api.nvim_command("Plug 'tpope/vim-commentary'")
vim.api.nvim_command("Plug 'ncm2/ncm2'")
vim.api.nvim_command("Plug 'roxma/nvim-yarp'")
vim.api.nvim_command("Plug 'ncm2/ncm2-bufword'")
vim.api.nvim_command("Plug 'ncm2/ncm2-path'")
vim.api.nvim_command("Plug 'subnut/ncm2-github-emoji'")
vim.api.nvim_command("Plug 'rust-lang/rust.vim'")
vim.api.nvim_command("Plug 'ziglang/zig.vim'")
vim.api.nvim_command("call plug#end()")

-- Functions

local util = require("util")
function fzf() util.term("fzf", util.edit) end
function fzf_rg() util.term("fzf_rg", util.edit) end
function fzf_rgf() util.term("fzf_rg -F", util.edit) end

-- lsp stuff

local ncm2 = require"ncm2"
local diag = require"diagnostic"
local nvim_lsp = require"nvim_lsp"
nvim_lsp.util.default_config = vim.tbl_extend(
    "force",
    nvim_lsp.util.default_config,
    {
        on_init = ncm2.register_lsp_source,
        on_attach = diag.on_attach
    })

nvim_lsp.bashls.setup{}
nvim_lsp.clangd.setup{}
nvim_lsp.cmake.setup{}
nvim_lsp.rls.setup{}
nvim_lsp.vimls.setup{}
nvim_lsp.zls.setup{}

-- Keybind

vim.api.nvim_set_keymap("", "<c-p>", ":lua fzf()<cr>", { noremap = true })
vim.api.nvim_set_keymap("", "<c-f>", ":lua fzf_rgf()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "r", ":.,$s/\\<<c-r><c-w>\\>//gc<left><left><left>", { noremap = true })
vim.api.nvim_set_keymap("v", "r", ":s//gc<left><left><left>", { noremap = true })
vim.api.nvim_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<cr>", { silent = true, noremap = true })

-- Options

vim.o.listchars="trail:•,tab:▸ "
vim.o.hidden=true
vim.o.clipboard="unnamed,unnamedplus"
vim.o.completeopt="noinsert,menuone"
vim.o.hlsearch=false
vim.o.laststatus=0
vim.o.showtabline=0
vim.o.title=true

-- These cannot be set through vim.o or nvim_set_option

vim.api.nvim_command("set colorcolumn=100")
vim.api.nvim_command("set expandtab")
vim.api.nvim_command("set list")
vim.api.nvim_command("set noswapfile")
vim.api.nvim_command("set nowrap")
vim.api.nvim_command("set numberwidth=1")
vim.api.nvim_command("set relativenumber")
vim.api.nvim_command("set shiftwidth=4")
vim.api.nvim_command("set smartindent")
vim.api.nvim_command("set softtabstop=4")
vim.api.nvim_command("set tabstop=4")


-- TODO: Port this stuff to lua
vim.api.nvim_command('let g:diagnostic_show_sign = 0')

vim.api.nvim_command('let g:rustfmt_autosave = 1')

vim.api.nvim_command('inoremap <expr> <tab> (pumvisible() ? "\\<c-y>" : "\\<tab>")')
vim.api.nvim_command('inoremap <expr> <cr> (pumvisible() ? "\\<c-e>\\<cr>" : "\\<cr>")')

vim.api.nvim_command('autocmd BufEnter * call ncm2#enable_for_buffer()')

vim.api.nvim_command("hi Keyword      cterm=bold     ctermfg=blue")
vim.api.nvim_command("hi StorageClass cterm=bold     ctermfg=blue")
vim.api.nvim_command("hi Type         cterm=bold     ctermfg=blue")
vim.api.nvim_command("hi Structure    cterm=bold     ctermfg=blue")
vim.api.nvim_command("hi Statement    cterm=bold     ctermfg=blue")
vim.api.nvim_command("hi Conditional  cterm=bold     ctermfg=blue")
vim.api.nvim_command("hi Repeat       cterm=bold     ctermfg=blue")
vim.api.nvim_command("hi Boolean      cterm=bold     ctermfg=cyan")
vim.api.nvim_command("hi Constant     cterm=bold     ctermfg=cyan")
vim.api.nvim_command("hi Number       cterm=bold     ctermfg=cyan")
vim.api.nvim_command("hi Special      cterm=bold     ctermfg=cyan")
vim.api.nvim_command("hi String       cterm=bold     ctermfg=green")
vim.api.nvim_command("hi Character    cterm=bold     ctermfg=green")
vim.api.nvim_command("hi Function     cterm=bold     ctermfg=yellow")
vim.api.nvim_command("hi Comment      cterm=italic   ctermfg=darkgray")
vim.api.nvim_command("hi LineNr       cterm=italic   ctermfg=darkgray")
vim.api.nvim_command("hi CursorLineNr cterm=italic   ctermfg=darkgray")
vim.api.nvim_command("hi EndOfBuffer  cterm=italic   ctermfg=darkgray")
vim.api.nvim_command("hi Whitespace   cterm=NONE     ctermfg=darkgray")
vim.api.nvim_command("hi Error        cterm=standout ctermbg=white    ctermfg=red")
vim.api.nvim_command("hi Operator     cterm=bold     ctermfg=white")


