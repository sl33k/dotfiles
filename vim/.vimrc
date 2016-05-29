" A minimal vimrc for new vim users to start with.
"
" Referenced here: http://vimuniversity.com/samples/your-first-vimrc-should-be-nearly-empty
"
" Original Author:	     Bram Moolenaar <Bram@vim.org>
" Made more minimal by:  Ben Orenstein
" Modified by :          Ben McCormick
" Last change:	         2014 June 8
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

" finish Plugins
call vundle#end()


" SETTINGS
" This must be first, because it changes other options as a side effect.
set nocompatible
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


" THEMING
" vim-solarized
set background=dark
colorscheme solarized
set t_Co=16
set cursorline

" Vim Airline
let g:airline_powerline_fonts = 1

" FUNCTIONS

":PerlTidyVisual command to run perltidy on visual selection || entire buffer"
command -range=% -nargs=* PerlTidyVisual <line1>,<line2>!perltidy
":Perl command to run current file with perl
command Perl execute "!perl %"
":SuPerl command to run current file with elevated perl
command SuPerl execute "!sudo perl %"

":PerlTidy on entire buffer and return cursor to (approximate) original position"
fun PerlTidy()
    let l = line(".")
    let c = col(".")
    :PerlTidyVisual
    call cursor(l, c)
endfun

fun PerlRun()
    :silent !clear
    :Perl
endfun

" BINDINGS
"au => autocmd
"shortcut for normal mode to run on entire buffer then return to current line"
au Filetype perl nmap <F2> :call PerlTidy()<CR>

"shortcut for visual mode to run on the the current visual selection"
au Filetype perl vmap <F2> :PerlTidyVisual<CR>

"shortcut for normal mode to (non-elevated) perl 
au Filetype perl nmap <F3> :Perl<CR>

"shortcut for normal mode to (elevated) perl
au Filetype perl nmap <C-F3> :SuPerl<CR>

