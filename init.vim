" Plugins installed in folder pack/plugins/start
" To install the plugins you only need to clone the projects 
" in the folder
" 
" Plugins
" coc.nvim-release
" fzf
" fzf.vim
" lightline.vim
" nerdtree
" vim-fugitive
" vim-monokai

filetype plugin indent on

colorscheme monokai
set termguicolors

syntax enable

" Removes searching in files in folder
" verbose setglobal complete?
setglobal complete-=i

set visualbell                  " Flash screen instead of beep sound
set encoding=utf-8              " Change how vim represents characters on the screen
set fileencoding=utf-8          " Set the encoding of files written

" File backup for opened files
set backupdir=~/AppData/Local/nvim/backup//
set directory=~/AppData/Local/nvim/swap//

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
set shiftwidth=4                " when using the >> or <commands, shift lines by 4 spaces

"exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
"set list

hi CursorLine ctermbg=gray ctermfg=yellow "8 = dark gray, 15 = red
set cursorline                  " show a visual line under the cursor's current line

hi ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%101v', 100)

set showmatch                   " show the matching part of the pair for [] {} and ()
"let python_highlight_all = 1    " enable all Python syntax highlighting features

set showcmd                     " show command in bottom bar

set showmatch                   " highlight matching [{()}]
set incsearch                   " search as characters are entered
set hlsearch                    " highlight matches

set laststatus=2                " Show lightline wven when only one pane is open

" Language options
" Normally un set to avoid error with code but if you want to add 
" spelling you can enable it and remove it later
"set spell
"set spelllang=en_us, es


" move vertically by visual line
nnoremap j gj
nnoremap k gk

" Special mappings
" Automatically closing braces
inoremap {<CR>  {<CR>}<Esc>O
inoremap (<CR>  (<CR>)<Esc>O
inoremap [<CR>  [<CR>]<Esc>O

" Remaps
let mapleader = " "

" Open vimrc
map <leader><leader>q :e $MYVIMRC<CR>

" Jump tags
map <leader>{ :tag <c-r><c-w><cr>

" Open terminal
map <leader>y :terminal<CR>

" Quick saving and quit
map <leader>w :w<CR>
map <leader>qw :wq<CR>
map <leader>qq :q!<CR>

map <leader>ñ :nohl<CR>
map <leader><leader>ñ :redraw!<CR>

" Remaping window movements
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>

" Split navigation
map <leader>gl :wincmd v<CR>
map <leader>gk :wincmd s<CR>
map <leader>gj :wincmd c<CR>
map <leader>gh :wincmd o<CR>

" Split resizing
map <leader>r+ :vertical resize +5<CR>
map <leader>r- :vertical resize -5<CR>
map <leader><leader>r+ :resize +5<CR>
map <leader><leader>r- :resize -5<CR>

" Remaping for tabs
map <leader>gg :tabe<CR>
map <leader>gf :tabn<CR>
map <leader>gd :tabp<CR>
map <leader>gs :tabc<CR>

" Buffers and args
map <leader>ii :buffers <CR>:bu
map <leader>iu :buffers <CR>:bd
map <leader>u :args <CR>
nnoremap <leader>m :bnext<CR>
nnoremap <leader>n :bprev<CR>

" Error mappings
nnoremap <Right> :cnext<CR>
nnoremap <Left> :cprev<CR>

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <leader>o :NERDTreeToggle<CR>

" fzf mapping
map <leader>p :FZF<CR>
map <leader><leader>p :Rg<CR>
let g:fzf_action = {
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit'
            \ }

" Fugitive mapping
nmap <leader>bb :G<CR>
nmap <leader>bv :Gclog<CR>
nmap <leader>bn :Gblame<CR>
nmap <leader>bg :diffget //2<CR>
nmap <leader>bh :diffget //3<CR>

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml "foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" =========================================
" Configurations recommended for CoC
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
"set nobackup
"set noswapfile
"set nowritebackup

" Give more space for displaying messages.
set cmdheight=1 

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <leader>e <Plug>(coc-diagnostic-prev)
nmap <leader>r <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>t  <Plug>(coc-format-selected)
nmap <leader>t  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader><leader>ac  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <leader>zz  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <leader>za  :<C-u>CocList extensions<cr>
" Find symbol of current document.
nnoremap <leader>zx  :<C-u>CocList outline<cr>
" Show commands.
nnoremap <leader>zc  :<C-u>CocList commands<cr>
" Show actions.
nnoremap <leader>zs  :<C-u>CocAction<cr>
" Search workspace symbols.
nnoremap <leader>zd  :<C-u>CocList -I symbols<cr>
" Resume latest coc list.
nnoremap <leader>zv  :<C-u>CocListResume<CR>
