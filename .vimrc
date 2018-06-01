set nocompatible

let mapleader=" "

" vim-plug auto install
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin()
Plug 'jiangmiao/auto-pairs'
Plug 'flazz/vim-colorschemes'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'fholgado/minibufexpl.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'vim-airline/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go'
Plug 'junegunn/goyo.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'w0rp/ale'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/async.vim'
Plug 'lepture/vim-jinja'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'terryma/vim-smooth-scroll'
Plug 'yuttie/comfortable-motion.vim'
Plug 'myusuf3/numbers.vim'
Plug 'vimwiki/vimwiki'
Plug 'ervandew/supertab'
" Add new plugins here
call plug#end()

set number
" Use relative line numbers.
set rnu
set cc=81
set mouse=a
set hlsearch
set incsearch

set wildmenu                    " Menu for command autocompletion
set laststatus=2                " Always show status line
set autoread                    " Automatically read a file changed outside of vim
set backspace=indent,eol,start  " Backspace for dummies
set display=lastline            " Show as much as possible of the last line
set encoding=utf-8              " Default encoding
set history=10000               " Maximum history record
set smarttab                    " Smart tab
set ttyfast                     " Faster redrawing
set viminfo+=!                  " Viminfo include !

if !has('nvim')
    set ttymouse=xterm2
endif

" No help Uganda information, and overwrite read messages to avoid PRESS ENTER prompts
set shortmess=atOI

set ignorecase     " Case sensitive search
set smartcase      " Case sensitive when uc present
set scrolloff=3    " Minumum lines to keep above and below cursor
set shiftwidth=4   " Use indents of 4 spaces
set tabstop=4      " An indentation every four columns
set softtabstop=4  " Let backspace delete indent
set splitright     " Puts new vsplit windows to the right of the current
"set splitbelow     " Puts new split windows to the bottom of the current
set autowrite      " Automatically write a file when leaving a modified buffer
set mousehide      " Hide the mouse cursor while typing
set hidden         " Allow buffer switching without saving
set t_Co=256       " Use 256 colors
set ruler          " Show the ruler
set showcmd        " Show partial commands in status line and Selected characters/lines in visual mode
set showmode       " Show current mode in command-line
set showmatch      " Show matching brackets/parentthesis
set matchtime=5    " Show matching time
set report=0       " Always report changed lines
set linespace=0    " No extra spaces between rows

set winminheight=0
set wildmode=list:longest,full

set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶

set whichwrap+=<,>,h,l  " Allow backspace and cursor keys to cross line boundaries
"
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Easy navigation between splits. Instead ctrl-w then j, it's just ctrl-j.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Map spacebar to leader
" map <Space> <Leader>

" Enabled spell checking for English.
setlocal spell spelllang=en_us

if has('gui_running')
  set guioptions-=r        " Hide the right scrollbar
  set guioptions-=L        " Hide the left scrollbar
  set guioptions-=T
  set guioptions-=e
  set shortmess+=c
  " No annoying sound on errors
  set noerrorbells
  set novisualbell
  set t_vb=
endif

set cursorline  " Highlight current line

" Remap Escape to jk
imap jk <Esc>

" Show current branch in status line
"set stl=%F-%{fugitive#statusline()}

if filereadable("/usr/share/vim/google/google.vim")
  source /usr/share/vim/google/google.vim
  filetype plugin indent on

  Glug youcompleteme-google
  let g:ycm_autoclose_preview_window_after_insertion = 1

  Glug blazedeps

  Glug blaze plugin[mappings]='<leader>b'

  " Run goimports and gofmt on file save
  Glug codefmt gofmt_executable=goimports
  Glug codefmt-google auto_filetypes+=go

  Glug syntastic-google checkers=`{'borg': 'borgcfg', 'proto': 'glint', 'gcl': 'gcl', 'bzl': 'bzl'}`

  Glug critique
  Glug grok

  " Glug coverage
  " Glug coverage-google

  " Format BUILD files
  autocmd FileType bzl AutoFormatBuffer buildifier
  " Format Markdown files
  " autocmd FileType markdown AutoFormatBuffer mdformat

  let g:ale_linters = { 'python': ['glint'], 'go': ['glint'], 'cpp': ['glint'], 'proto': ['glint'], 'javascript': ['glint']}

  " vim-go tuning for google3
  let g:go_disable_autoinstall = 1
  let g:go_gocode_bin = 'gocode'
  let g:go_def_mapping_enabled = 0

  " vim-lsp tuning
  au User lsp_setup call lsp#register_server({
      \ 'name': 'Kythe Language Server',
      \ 'cmd': {server_info->['/google/data/ro/teams/grok/tools/kythe_languageserver', '--google3']},
      \ 'whitelist': ['python', 'go', 'cpp'],
      \})
  nnoremap <C-]> :LspDefinition<CR>

  " source /google/data/ro/users/er/ershov/bin/iblaze.vim
else
  filetype plugin indent on
endif

" Tagbar support for Go with gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" Toggle tagbar on <leader>+L
nmap <leader>l :TagbarToggle<CR>

" Toggle NERDTree on <leader>+K
nmap <leader>k :NERDTreeToggle<CR>

" Do YCM FixIt on <leader>+f
nmap <leader>y :YcmCompleter FixIt<CR>
nmap <leader>f :FormatLines<CR>

" Open tagbar on the left
let g:tagbar_left = 1

" Usa patched fonts in airline
let g:airline_powerline_fonts = 1

" Syntastic recommended settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["html", "typescript", "cpp"] }

" NERDCommenter settings
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" AutoPairs settings
"let g:AutoPairsFlyMode = 1
let g:AutoPairsCenterLine = 0

" vim-workspace settings
noremap <Tab> :MBEbn<CR>
noremap <S-Tab> :MBEbp<CR>

syntax on

set background=dark
" let g:solarized_termtrans = 1
" color solarized
"
" color molokai
" color railscasts
color rdark-terminal2

" Highlight variable under cursor
" autocmd CursorMoved * exe printf('match FoldColumn /\V\<%s\>/', escape(expand('<cword>'), '/\'))

" vim-smooth-scroll setting
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" Wrap text at 80 characters in Markdown files
au BufRead,BufNewFile *.md setlocal textwidth=80

" vim-better-whitespace settings
let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1
highlight ExtraWhitespace ctermbg=5

" comfortable-scrolling
" let g:comfortable_motion_friction = 0.0
" let g:comfortable_motion_air_drag = 0.0
