call plug#begin('~/.vim/plugged')

"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'rust-lang/rust.vim'
Plug 'peterhoeg/vim-qml'
Plug 'fatih/vim-go'
Plug 'tpope/vim-fireplace' " ->> Clojure
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'mattn/emmet-vim'
Plug 'posva/vim-vue'
Plug 'w0rp/ale'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'editorconfig/editorconfig-vim'
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

let mapleader = "\<space>"

syntax on
set guifont=DejaVu\ Sans\ Mono:h9
set encoding=utf-8
set number
set laststatus=2
set shiftwidth=2
set tabstop=2
"set softtabstop=2
set expandtab
"set listchars=tab:▸\·,trail:·
"set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set listchars=tab:→\ ,
set list
set hlsearch
set backspace=indent,eol,start
set autoindent
set mouse=a
set pastetoggle=<F11>
set clipboard=unnamedplus
set t_Co=256
set noswapfile
set nowrap
set shell=zsh
autocmd FileType html,css,javascript,javascript.jsx setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType go setlocal tabstop=2 noexpandtab

" config ale plugin -- linters
let g:ale_enabled = 0
let g:ale_fix_on_save = 1
"let g:ale_fixers = { 'javascript': [ 'prettier' ] }
let g:ale_fixers = {'javascript': ['eslint']}
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file

set background=dark
color dracula
colorscheme dracula
set termguicolors

" config airline
let g:rehash256 = 1
let g:airline_theme='dracula'
let g:airline_powerline_fonts = 1

" config netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" config emmet
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
 \  'javascript.jsx' : {
 \      'extends' : 'jsx',
 \  },
 \}

" atalhos
map <C-\> :Explore<CR>
map <C-p> :FZF<CR>
"map <C-p> :GFiles<CR>
map <C-l> :vsplit<CR>
map <C-j> :split<CR>
nmap <C-Up>  ddkP
nmap <C-Down> ddp
nmap <M-Up> yyP
nmap <M-Down>  yyp
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p
nmap <leader><space> :w<CR>
nmap <C-c> :q!<CR>
nmap <F5> :source ~/.vimrc<CR>
nmap <F12> :silent update<Bar>silent !google-chrome-unstable %:p<CR> :source ~/.vimrc<CR>
vmap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>
