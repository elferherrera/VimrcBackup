call plug#begin('C:/Users/Benzaa/AppData/Local/nvim/pack/plugins')
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'sickill/vim-monokai'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'


" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Completion framework
Plug 'hrsh7th/nvim-cmp'

" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'

" Other usefull completion sources
" See hrsh7th's other plugins for more completion sources!
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

" Snippet engine
Plug 'hrsh7th/vim-vsnip'

" Fuzzy finder
" Optional
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Initialize plugin system
call plug#end()


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
"


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

map <leader>- :nohl<CR>
map <leader><leader>- :redraw!<CR>

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

" Move panels
map <leader>gr :wincmd r<CR>
map <leader>gR :wincmd R<CR>
map <leader>gL :wincmd L<CR>
map <leader>gK :wincmd K<CR>
map <leader>gJ :wincmd J<CR>
map <leader>gH :wincmd H<CR>

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
map <leader>oo :NERDTreeToggle<CR>

" fzf mapping
map <leader>pp :Files<CR>
map <leader>pl :Lines<CR>
map <leader>po :BLines<CR>
map <leader>pi :Rg<CR>
map <leader>pu :Buffers<CR>
map <leader>pk :Tags<CR>

" VIFM mapping
map <leader>ñ :Vifm<CR>

let g:fzf_action = {
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit'
            \ }

" Fugitive mapping
nmap <leader>bb :G<CR>
nmap <leader>bv :Gclog<CR>
nmap <leader>bc :Gdiffsplit<CR>
nmap <leader>bn :Gblame<CR>
nmap <leader>bg :diffget //2<CR>
nmap <leader>bh :diffget //3<CR>

tnoremap <Esc> <C-\><C-n>

" lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml "foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Rust analyzer
" https://sharksforarms.dev/posts/neovim-rust/
" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = ""
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes
