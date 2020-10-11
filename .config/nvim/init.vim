set clipboard+=unnamedplus

call plug#begin('~/.local/share/nvim/plugged')
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }

" fzf and friends
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" ncm and friends
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

" Language plugings
Plug 'rust-lang/rust.vim'
Plug 'ziglang/zig.vim'
call plug#end()

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

let g:rustfmt_autosave = 1
let g:fzf_layout = {}

let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }

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
noremap <C-f> :Rg 
nnoremap r :%s//gc<Left><Left><Left>
vnoremap r :s//gc<Left><Left><Left>
vnoremap <C-s> :sort<Enter>

" ncm remaps
inoremap <expr> <Tab> (pumvisible() ? "\<c-y>" : "\<Tab>")
inoremap <expr> <CR> (pumvisible() ? "\<c-e>\<CR>" : "\<CR>")

" Language server remaps
nnoremap <silent> K :call LanguageClient_textDocument_hover()<Enter>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<Enter>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<Enter>

" autocmd TextChanged,InsertLeave * silent write
autocmd BufEnter * call ncm2#enable_for_buffer()
autocmd BufReadPost *.rs setlocal filetype=rust

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

