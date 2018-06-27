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

" plug-vim
" increase timeout for ycm
let g:plug_timeout = 120
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" User Plugins
Plug 'altercation/vim-colors-solarized'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --tern-completer' }
Plug 'bling/vim-bufferline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'christoomey/vim-tmux-navigator'
Plug 'raimondi/delimitmate'
Plug 'vim-perl/vim-perl'
Plug 'leafgarland/typescript-vim'
Plug 'Chiel92/vim-autoformat'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'jeaye/color_coded', { 'do': 'mkdir build && cd build && cmake ../ && make && make install'}
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround' 
Plug 'ctrlpvim/ctrlp.vim'
Plug 'morhetz/gruvbox'
Plug 'Konfekt/FastFold'
Plug 'lervag/vimtex'

" finish Plugins
call plug#end()


" SETTINGS
" This must be first, because it changes other options as a side effect.
set nocompatible
" FIX O takes a long since the OS is waiting for escape sequences
" set noesckeys
" make sure file enconding is utf-8 otherwise youcompleteme doesnt work
set encoding=utf-8
" Make backspace behave in a sane manner.
set backspace=indent,eol,start
" Switch syntax highlighting on
syntax on
" Enable file type detection and do language-dependent indenting.
filetype plugin indent on
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

" PLUGIN SETTINGS
" auto close nerdtree if its the only buffer open
autocmd bufenter * if(winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Vim Airline Powerline fonts
let g:airline_powerline_fonts = 1
" Vim Airline Theme
let g:airline_theme='gruvbox'
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
"ctrlp settings
" set invocation command to <leader><Space>
let g:ctrlp_map = '<leader><Space>'
"dont show vim-bufferline in command line
let g:bufferline_echo = 0
" fast fold settings
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

" THEMING
" gruvbox
set t_8f=[38;2;%lu;%lu;%lum        " set foreground color
set t_8b=[48;2;%lu;%lu;%lum        " set background color
set background=dark
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column = 'bg0'
colorscheme gruvbox
set termguicolors
set cursorline

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
"Autoformat binding
nmap <leader>ff :Autoformat<cr>
"CtrlP buffer searching
nmap <leader>b :CtrlPBuffer<cr>

