call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'

call plug#end()

syntax on
set guifont=DejaVu\ Sans\ Mono:h9
set number
set laststatus=2
set shiftwidth=4
set softtabstop=4
set expandtab
set listchars=eol:¬,tab:>·,trail:·,extends:>,precedes:<,space:·
set list
set hlsearch
set backspace=indent,eol,start
set autoindent
set mouse=a
set paste
set go+=a
set pastetoggle=<F11>
set clipboard=unnamedplus
set t_Co=256

colorscheme monokai

let g:rehash256 = 1
let g:airline_theme='dark'
let g:airline_powerline_fonts = 1

map <C-k> :NERDTreeToggle<CR>
map <C-p> :FZF<CR>

