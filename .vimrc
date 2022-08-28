syntax on
set number
set nohlsearch
set ignorecase
set smartcase
let mapleader = "\<Space>"
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" ) <CR>
inoremap <silent> <Home> <Esc>`^
inoremap <silent> <Esc> <Esc>`^
