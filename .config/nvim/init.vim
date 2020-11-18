call plug#begin('~/.local/share/nvim/plugged')

    Plug 'Ogromny/nvim-lspconfig', { 'branch': 'zls_support' }
    Plug 'christoomey/vim-sort-motion'
    Plug 'junegunn/fzf.vim'
    Plug 'mg979/vim-visual-multi'
    Plug 'nvim-lua/diagnostic-nvim'
    Plug 'tpope/vim-commentary'

    " ncm and friends
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'
    Plug 'subnut/ncm2-github-emoji'

    " Language plugins
    Plug 'rust-lang/rust.vim'
    Plug 'ziglang/zig.vim'

call plug#end()

lua <<EOF
    local nvim_lsp = require'nvim_lsp'
    local ncm2 = require'ncm2'
    local diag = require'diagnostic'
    nvim_lsp.util.default_config = vim.tbl_extend(
        'force',
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
EOF

" Aaaw man, I sure do love that fzf.vim overrides the default prompt so that I
" have to manually get it back... Why? Having my cwd as the prompt is not
" useful. This is a fuzzy find. The search will not represent a valid path.
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--prompt', '> ']}, <bang>0)

" Again, the Rg command was replacing the default prompt... Why? Anyways, here
" I also wanted to change the arguments passed to rg, so I had to define this
" anyways.
command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case --only-matching --replace= -- '.shellescape(<q-args>),
    \   1, fzf#vim#with_preview({'options': ['--prompt', '> ']}), <bang>0)
command! -bang -nargs=* Rgf
    \ call fzf#vim#grep(
    \   'rg --fixed-strings --column --line-number --no-heading --color=always --smart-case --only-matching --replace= -- '.shellescape(<q-args>),
    \   1, fzf#vim#with_preview({'options': ['--prompt', '> ']}), <bang>0)

let g:diagnostic_show_sign = 0

let g:rustfmt_autosave = 1
let g:fzf_layout = {}

set clipboard=unnamed,unnamedplus
set completeopt=noinsert,menuone

set listchars=trail:•,tab:▸\ 
set list

set noswapfile
set hidden
set title

set nowrap
set nohlsearch

set autoindent
set expandtab
set shiftwidth=4
set showtabline=0
set smartindent
set softtabstop=4
set tabstop=4

set colorcolumn=100
set laststatus=0
set nonumber
set numberwidth=1
set relativenumber

" set spell! spelllang=en_us

noremap <c-p> :Files<Enter>
noremap <c-f> :Rgf <c-r><c-w>
nnoremap r :%s/\<<c-r><c-w>\>//gc<left><left><left>
vnoremap r :s//gc<left><left><left>

" ncm remaps
inoremap <expr> <tab> (pumvisible() ? "\<c-y>" : "\<tab>")
inoremap <expr> <cr> (pumvisible() ? "\<c-e>\<cr>" : "\<cr>")

" Language server remaps
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> K  <cmd>lua vim.lsp.buf.hover()<cr>

autocmd BufEnter * call ncm2#enable_for_buffer()

hi Keyword      cterm=bold     ctermfg=blue
hi StorageClass cterm=bold     ctermfg=blue
hi Type         cterm=bold     ctermfg=blue
hi Structure    cterm=bold     ctermfg=blue
hi Statement    cterm=bold     ctermfg=blue
hi Conditional  cterm=bold     ctermfg=blue
hi Repeat       cterm=bold     ctermfg=blue
hi Boolean      cterm=bold     ctermfg=cyan
hi Constant     cterm=bold     ctermfg=cyan
hi Number       cterm=bold     ctermfg=cyan
hi Special      cterm=bold     ctermfg=cyan
hi String       cterm=bold     ctermfg=green
hi Character    cterm=bold     ctermfg=green
hi Function     cterm=bold     ctermfg=yellow
hi Comment      cterm=italic   ctermfg=darkgray
hi LineNr       cterm=italic   ctermfg=darkgray
hi CursorLineNr cterm=italic   ctermfg=darkgray
hi EndOfBuffer  cterm=italic   ctermfg=darkgray
hi Whitespace   cterm=NONE     ctermfg=darkgray
hi Error        cterm=standout ctermbg=white    ctermfg=red
hi Operator     cterm=bold     ctermfg=white

