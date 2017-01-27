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

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" User Plugins
Plugin 'altercation/vim-colors-solarized'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
Plugin 'pangloss/vim-javascript'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'raimondi/delimitmate'
Plugin 'vim-perl/vim-perl'
Plugin 'leafgarland/typescript-vim'
Plugin 'Chiel92/vim-autoformat'


" finish Plugins
call vundle#end()


" SETTINGS
" This must be first, because it changes other options as a side effect.
set nocompatible
" FIX O takes a long since the OS is waiting for escape sequences
set noesckeys
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
" Allow hidden buffers, don't limit to 1 file per window/split
set hidden
" Setting the tabstop to 4 Spaces
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" PLUGIN SETTINGS
" auto close nerdtree if its the only buffer open
autocmd bufenter * if(winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Vim Airline Powerline fonts
let g:airline_powerline_fonts = 1
" Supertab
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" THEMING
" vim-solarized
set background=dark
colorscheme solarized
set t_Co=16
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
nmap <leader>ne :NERDTreeToggle<cr>
nmap <leader>nf :NERDTreeFocus<cr>
"Autoformat binding
nmap <leader>ff :Autoformat<cr>
