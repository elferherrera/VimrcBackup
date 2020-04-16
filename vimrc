" Plugins installed in folder vimfiles/pack/plugins/start
" To install the plugins you only need to clone the projects 
" in the folder
" 
" Plugins
"   YouCompleteMe
"   ctrlp.vim
"   jedi-vim
"   lightline.vim
"   vifm.vim
"   vim-fugitive
"   vim-go
"   vim-multiple-cursors

set nocompatible

filetype plugin indent on

colorscheme pablo

syntax enable

set visualbell                  " Flash screen instead of beep sound
set encoding=utf-8              " Change how vim represents characters on the screen
set fileencoding=utf-8          " Set the encoding of files written

" File backup for opened files
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

set undofile " Maintain undo history between sessions
set undodir=~/.vim/undo//


set path+=**                    " Option for search in folder and wildmenu
set wildmenu                    " visual autocomplete for command menu

set lazyredraw                  " redraw only when we need to.

set number relativenumber       " show line numbers
set nu rnu                      " show line numbers

set backspace=indent,eol,start
set tabstop=4                   " set tabs to have 4 spaces
set autoindent                  " indent when moving to the next line while writing code
set expandtab                   " expand tabs into spaces
set softtabstop=4               " number of spaces in tab when editing
set shiftwidth=4                " when using the >> or << commands, shift lines by 4 spaces
set cursorline                  " show a visual line under the cursor's current line
hi CursorLine ctermbg=40 ctermfg=30 "8 = dark gray, 15 = white

set showmatch                   " show the matching part of the pair for [] {} and ()
"let python_highlight_all = 1    " enable all Python syntax highlighting features

set showcmd                     " show command in bottom bar

set showmatch                   " highlight matching [{()}]
set incsearch                   " search as characters are entered
set hlsearch                    " highlight matches

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" GO mappings 
let g:go_fmt_command = "goimports"    " Run goimports along gofmt on each save     
let g:go_auto_type_info = 1           " Automatically get signature/type info for object under cursor     
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']

" Special mappings
" Automatically closing braces
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
inoremap [      []<Left>
inoremap [[     [
inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap ((     (
inoremap "      ""<Left>
inoremap ""     "
inoremap <      <><Left>
inoremap <<CR>  <<CR>><Esc>O
inoremap <<     <
inoremap <>     <>


" Remaps
let mapleader = " "

nnoremap <C-L> :nohl<CR><C-L>

" Remaping window movements
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>

map <leader><leader>l :wincmd v<CR>
map <leader><leader>k :wincmd s<CR>
map <leader><leader>j :wincmd c<CR>

map <leader>r+ :vertical resize +5<CR>
map <leader>r- :vertical resize -5<CR>

" Remaping for tabs
map <leader>g :tabe<CR>
map <leader>f :tabn<CR>
map <leader>d :tabp<CR>
map <leader>s :tabc<CR>

" Opening Vertical Ex
map <leader>o :Vex <CR>

" Buffers and args
map <leader>i :buffers <CR>:bu
map <leader>u :args <CR>

" Mappings for CtrP
nnoremap <leader>m :CtrlPBuffer<CR>
nnoremap <leader>n :CtrlPMRU<CR>

nnoremap <leader><leader>m :bnext<CR>
nnoremap <leader><leader>n :bprev<CR>

" Error mappings
nnoremap <Right> :cnext<CR>
nnoremap <Left> :cprev<CR>

" Configurations for jedi-vim
let &pythonthreedll = 'C:\Users\fernandoj.herrera\AppData\Local\Continuum\anaconda3\python37.dll'
let g:jedi#popup_on_dot = 0

" Configuration for YouCompleMe
let g:ycm_always_populate_location_list = 1
let g:ycm_auto_trigger = 1

nnoremap <leader>gd :YcmCompleter GoTo<CR>
nnoremap <leader>gf :YcmCompleter FixIt<CR>

" Multi Cursor
let g:multi_cursor_quit_key = '<Esc>'
