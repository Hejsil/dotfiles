set clipboard+=unnamedplus

call plug#begin('~/.local/share/nvim/plugged')
Plug 'ziglang/zig.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
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

let g:fzf_layout = {}

set listchars=trail:•,tab:▸\ 
set list

set nowrap
set nohlsearch

set expandtab
set tabstop=4
set shiftwidth=4
set showtabline=0

set laststatus=0
set number relativenumber

" set spell! spelllang=en_us

nnoremap <C-p> :Files<Enter>

autocmd TextChanged,InsertLeave * silent write

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

