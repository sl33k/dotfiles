" A minimal vimrc for new vim users to start with.
"
"
" Original Author:       Bram Moolenaar <Bram@vim.org>
" Made more minimal by:  Ben Orenstein
" Modified by :          Ben McCormick
" Last change:           2014 June 8
"
" To use it, copy it to
"  for Unix based systems (including OSX and Linux):  ~/.vimrc
"  for Windows :  $VIM\_vimrc
"
"  If you don't understand a setting in here, just type ':h setting'.
" Use Vim settings, rather than Vi settings (much better!).

"automatic plug installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plug-vim
" increase timeout for ycm
let g:plug_timeout = 180
call plug#begin('~/.vim/plugged')

" User Plugins
Plug 'morhetz/gruvbox'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --tern-completer --rust-completer', 'for': ['c', 'cpp', 'javascript', 'rust'] }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

Plug 'bling/vim-bufferline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'simeji/winresizer'
Plug 'raimondi/delimitmate'
Plug 'Chiel92/vim-autoformat'
Plug 'bfrg/vim-cpp-modern', { 'for': ['c', 'cpp'] }
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/1.x',
  \ 'for': [
    \ 'javascript',
    \ 'typescript',
    \ 'css',
    \ 'less',
    \ 'scss',
    \ 'json',
    \ 'graphql',
    \ 'markdown',
    \ 'vue',
    \ 'lua',
    \ 'php',
    \ 'python',
    \ 'ruby',
    \ 'html',
    \ 'swift' ] }
Plug 'vim-perl/vim-perl', { 'for': 'perl'}
Plug 'pangloss/vim-javascript', { 'for': 'javascript'}
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'typescript'] }
Plug 'stephpy/vim-yaml', { 'for': ['yaml']}
Plug 'derekwyatt/vim-scala', { 'for': 'scala'}
Plug 'leafgarland/typescript-vim', { 'for': 'typescript'}
Plug 'lervag/vimtex', { 'for': 'tex' }

Plug 'vim-syntastic/syntastic'

Plug 'Konfekt/FastFold'
Plug 'ntpeters/vim-better-whitespace'

" finish Plugins
call plug#end()


" SETTINGS
set enc=utf8
" This must be first, because it changes other options as a side effect.
set nocompatible
" FIX O takes a long since the OS is waiting for escape sequences
" set noesckeys
" make sure file enconding is utf-8 otherwise youcompleteme doesnt work
set encoding=utf-8
" Make backspace behave in a sane manner.
set backspace=indent,eol,start
" Enable file type detection and do language-dependent indenting.
filetype plugin indent on
" Switch syntax highlighting on
syntax on
" Show line numbers
set number
" Show relative line numbers
set relativenumber
"allow incremental search
set incsearch
"highlight search results
set hlsearch
" Allow hidden buffers, don't limit to 1 file per window/split
set hidden
" Setting the tabstop to 4 Spaces
set tabstop=4
set shiftwidth=4
set expandtab
"except for typescript files
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2
"disable expandtab for makefiles
autocmd Filetype make setlocal noet
" enable folding
set foldenable "but not on file open
" dont collapse on open
set foldlevelstart=99
" syntax is best
set foldmethod=syntax
" dont create subfolds (if/for/etc.)
set foldnestmax=1
" autoclose on exit
set foldclose=all
" dont fold anything below 10 lines
set foldminlines=10
" nicer folder marker
set foldmarker====,===
" persistent undo
"" create dir if it does not exist
if !isdirectory($HOME."/.vim/undodir/")
    call mkdir($HOME."/.vim/undodir/", "p")
endif
"" set correct undodir and enable undofile
set undodir=~/.vim/undodir
set undofile
" enable mouse support in all modes
set mouse=a

""" Temporary Files
if !isdirectory($HOME."/.vim/backupdir/")
    call mkdir($HOME."/.vim/backupdir/")
endif
set directory=~/.vim/backupdir
if !isdirectory($HOME."/.vim/directorydir/")
    call mkdir($HOME."/.vim/directorydir/")
endif
set backupdir=~/.vim/directorydir

" PLUGIN SETTINGS
" auto close nerdtree if its the only buffer open
autocmd bufenter * if(winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Vim Airline Powerline fonts
let g:airline_powerline_fonts = 1
" Vim Airline Theme
let g:airline_theme='gruvbox'
" airline + syntastic
let g:airline#extensions#syntastic#enabled = 1

"YCM Settings
" Auto Close preview
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0
"vim-jsx settings
"also enable on .js files instead of on .jsx only
let g:jsx_ext_required = 0
"vim-gitgutter settings
"update the vim refresh rate for a smoother experience
set updatetime=250
"dont show vim-bufferline in command line
let g:bufferline_echo = 0

"syntastic settings
let g:syntastic_cpp_clang_check_post_args = ""
let g:syntastic_cpp_clang_tidy_post_args = ""
let g:syntastic_cpp_checkers = ['clang_tidy', 'clang_check']
let g:syntastic_mode_map =  { "mode": "active", "passive_filetypes": [ "tex" ] }

" fast fold settings
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
" vimtex settings
let g:vimtex_view_method = 'zathura'
" better-whitespace
" dont clean on save
let g:strip_whitespace_on_save = 0

" THEMING
" gruvbox
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column = 'bg0'
colorscheme gruvbox
set termguicolors
set cursorline

" winresizer
let g:winresizer_finish_with_escape = 1
"syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" c/cpp highlighting
let g:cpp_simple_highlight = 1
let g:cpp_member_variable_highlight = 1
" ocaml merlin 
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line

" FUNCTIONS

" easy navigation with CTRL+h,j,k,l
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"KEYBINDINGS
"Open NerdTREE on ,ne
let mapleader = ","
let maplocalleader= ","
nmap <leader>ne :NERDTreeToggle<cr>
nmap <leader>nf :NERDTreeFocus<cr>
nmap <leader>nc :NERDTreeClose<cr>
"Autoformat binding
nmap <leader>ff :Autoformat<cr>
