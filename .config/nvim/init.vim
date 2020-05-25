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

set nowrap
set expandtab
set tabstop=4
set shiftwidth=4
set showtabline=0
set laststatus=0
set number relativenumber

nnoremap <C-p> :Files<Enter>

