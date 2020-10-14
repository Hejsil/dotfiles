set clipboard+=unnamedplus

call plug#begin('~/.local/share/nvim/plugged')

    Plug 'christoomey/vim-sort-motion'
    Plug 'neovim/nvim-lspconfig'
    Plug 'tpope/vim-commentary'

    " fzf and friends
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " ncm and friends
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'

    " Language plugins
    Plug 'rust-lang/rust.vim'
    Plug 'ziglang/zig.vim'

call plug#end()

lua <<EOF
    require'nvim_lsp'.bashls.setup{}
    require'nvim_lsp'.clangd.setup{}
    require'nvim_lsp'.cmake.setup{}
    require'nvim_lsp'.rls.setup{}
    require'nvim_lsp'.vimls.setup{}
    -- require'nvim_lsp'.zls.setup{}
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
    \   'rg --column --line-number --no-heading --color=always --smart-case --only-matching --replace= -- '.shellescape(<q-args>), 1,
    \   fzf#vim#with_preview({'options': ['--prompt', '> ']}), <bang>0)
command! -bang -nargs=* Rgf
    \ call fzf#vim#grep(
    \   'rg --fixed-strings --column --line-number --no-heading --color=always --smart-case --only-matching --replace= -- '.shellescape(<q-args>), 1,
    \   fzf#vim#with_preview({'options': ['--prompt', '> ']}), <bang>0)

let g:rustfmt_autosave = 1
let g:fzf_layout = {}

set completeopt=noinsert,menuone

set listchars=trail:•,tab:▸\ 
set list

" set hidden
set title

set nowrap
set nohlsearch

set expandtab
set tabstop=4
set shiftwidth=4
set showtabline=0

set laststatus=0
set nonumber
set relativenumber
set numberwidth=1

" set spell! spelllang=en_us

noremap <C-p> :Files<Enter>
noremap <C-f> :Rgf 
nnoremap r :%s//gc<Left><Left><Left>
vnoremap r :s//gc<Left><Left><Left>

" ncm remaps
inoremap <expr> <Tab> (pumvisible() ? "\<c-y>" : "\<Tab>")
inoremap <expr> <CR> (pumvisible() ? "\<c-e>\<CR>" : "\<CR>")

" Language server remaps
nmap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nmap <silent> K  <cmd>lua vim.lsp.buf.hover()<CR>

autocmd BufEnter * call ncm2#enable_for_buffer()
autocmd BufReadPost *.rs setlocal filetype=rust

autocmd FileType vim setlocal commentstring=\"\ %s

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

