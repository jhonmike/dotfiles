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
Plug 'w0rp/ale'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'editorconfig/editorconfig-vim'

"Javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'mattn/emmet-vim'
Plug 'posva/vim-vue'

call plug#end()

let mapleader = "\<space>"

syntax on
set guifont=DejaVu\ Sans\ Mono:h9
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

"set background=dark
"color dracula
color solarized
colorscheme solarized

" config airline
let g:rehash256 = 1
let g:airline_theme='solarized'
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
"map <C-p> :FZF<CR>
map <C-p> :GFiles<CR>
map <C-l> :vsplit<CR>
map <C-j> :split<CR>
nmap <C-Up>  ddkP
nmap <C-Down> ddp
nmap <M-Up> yyP
nmap <M-Down>  yyp
nmap <leader><space> :w<CR>
nmap <C-c> :q!<CR>
nmap <F5> :source ~/.vimrc<CR>
nmap <F12> :silent update<Bar>silent !google-chrome-unstable %:p<CR> :source ~/.vimrc<CR>
vmap <C-r> "hy:%s/<C-r>h//gc<left><left><left>


" Adapted from unimpaired.vim by Tim Pope.
function! s:DoAction(algorithm,type)
  " backup settings that we will change
  let sel_save = &selection
  let cb_save = &clipboard
  " make selection and clipboard work the way we need
  set selection=inclusive clipboard-=unnamed clipboard-=unnamedplus
  " backup the unnamed register, which we will be yanking into
  let reg_save = @@
  " yank the relevant text, and also set the visual selection (which will be reused if the text
  " needs to be replaced)
  if a:type =~ '^\d\+$'
    " if type is a number, then select that many lines
    silent exe 'normal! V'.a:type.'$y'
  elseif a:type =~ '^.$'
    " if type is 'v', 'V', or '<C-V>' (i.e. 0x16) then reselect the visual region
    silent exe "normal! `<" . a:type . "`>y"
  elseif a:type == 'line'
    " line-based text motion
    silent exe "normal! '[V']y"
  elseif a:type == 'block'
    " block-based text motion
    silent exe "normal! `[\<C-V>`]y"
  else
    " char-based text motion
    silent exe "normal! `[v`]y"
  endif
  " call the user-defined function, passing it the contents of the unnamed register
  let repl = s:{a:algorithm}(@@)
  " if the function returned a value, then replace the text
  if type(repl) == 1
    " put the replacement text into the unnamed register, and also set it to be a
    " characterwise, linewise, or blockwise selection, based upon the selection type of the
    " yank we did above
    call setreg('@', repl, getregtype('@'))
    " relect the visual region and paste
    normal! gvp
  endif
  " restore saved settings and register value
  let @@ = reg_save
  let &selection = sel_save
  let &clipboard = cb_save
endfunction

function! s:ActionOpfunc(type)
  return s:DoAction(s:encode_algorithm, a:type)
endfunction

function! s:ActionSetup(algorithm)
  let s:encode_algorithm = a:algorithm
  let &opfunc = matchstr(expand('<sfile>'), '<SNR>\d\+_').'ActionOpfunc'
endfunction

function! MapAction(algorithm, key)
  exe 'nnoremap <silent> <Plug>actions'    .a:algorithm.' :<C-U>call <SID>ActionSetup("'.a:algorithm.'")<CR>g@'
  exe 'xnoremap <silent> <Plug>actions'    .a:algorithm.' :<C-U>call <SID>DoAction("'.a:algorithm.'",visualmode())<CR>'
  exe 'nnoremap <silent> <Plug>actionsLine'.a:algorithm.' :<C-U>call <SID>DoAction("'.a:algorithm.'",v:count1)<CR>'
  exe 'nmap '.a:key.'  <Plug>actions'.a:algorithm
  exe 'xmap '.a:key.'  <Plug>actions'.a:algorithm
  exe 'nmap '.a:key.a:key[strlen(a:key)-1].' <Plug>actionsLine'.a:algorithm
endfunction

function! ChompedSystemCall( ... )
    return substitute(call('system', a:000), '\n\+$', '', '')
endfun

fun! s:Subs(str)
  let my_filetype = &filetype
  let out = ChompedSystemCall('subs -p '.my_filetype, a:str."\n")
  return out
endfunc
call MapAction('Subs', '<leader>y')
