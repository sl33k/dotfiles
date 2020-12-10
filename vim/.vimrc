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
Plug 'rhysd/vim-grammarous'
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
Plug 'vim-syntastic/syntastic'
Plug 'lervag/vimtex'
Plug 'Konfekt/FastFold'
Plug 'ntpeters/vim-better-whitespace'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'igankevich/mesonic'

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
" disable cursorline for tex files, it bring the highlighter to a grinding
" halt
autocmd Filetype tex setlocal nocursorline
autocmd Filetype latex setlocal nocursorline
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
let g:airline#extensions#vimtex#enabled = 1

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
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_mode_map =  { "mode": "active", "passive_filetypes": [ "asm" ] }
let g:syntastic_tex_checkers = ['lacheck']
let g:syntastic_tex_lacheck_quiet_messages = { 'regex': '\Vpossible unwanted space at' }

" By default use gcc as the c checker, however, if meson is available use
" that in conjunction with mesonic
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_c_config_file = '.syntastic_c_config'
"let g:syntastic_c_no_default_include_dirs = 1
"let g:syntastic_c_compiler_options = ''
" If there's a `meson.build` file, use meson for linting.
autocmd FileType c call ConsiderMesonForLinting()
if !exists('*ConsiderMesonForLinting')
    function ConsiderMesonForLinting()
        if filereadable('meson.build')
            let g:syntastic_c_checkers = ['meson']
        endif
    endfunction
endif


let g:syntastic_vhdl_ghdl_args = ["--std=08"]

" fast fold settings
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

" vimtex settings
let g:vimtex_syntax_autoload_packages = ['amsmath']
let g:vimtex_view_method = 'zathura'
let g:vimtex_matchparen_enabled = 0
let g:vimtex_compiler_method = 'latexmk'
let g:tex_flavor = 'latex'
let g:tex_no_error = 1
let g:tex_nospell = 1
syn sync minlines=25
syn sync maxlines=100
let g:tex_fold_enabled=0

let g:vimtex_quickfix_open_on_warning = 0
set spelllang=en_us
" auto start server
if empty(v:servername) && exists('*remote_startserver') && has('clientserver')
    call remote_startserver('VIM')
endif
" grammarous settings
let g:grammarous#use_vim_spelllang = 1
let g:grammarous#languagetool_cmd = $HOME."/local/bin/yalafi-grammarous"
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
let g:syntastic_check_on_wq = 1
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
" grammarous bindings
nmap <leader>gf <Plug>(grammarous-move-to-info-window)
nmap <leader>go <Plug>(grammarous-open-info-window)
nmap <leader>gc :GrammarousCheck<cr>
nmap <leader>gr :GrammarousReset<cr>
let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
    nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
    nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
    nmap <buffer><C-r> <Plug>(grammarous-remove-error)
    nmap <buffer><C-R> <Plug>(grammarous-disable-rule)
    nmap <buffer><C-f> <Plug>(grammarous-fixit)
    nmap <buffer><C-c> <Plug>(grammarous-reset)
endfunction

function! g:grammarous#hooks.on_reset(errs) abort
    nunmap <buffer><C-n>
    nunmap <buffer><C-p>
    nmap <buffer><C-r>
    nmap <buffer><C-R>
    nmap <buffer><C-f>
    nmap <buffer><C-c>
endfunction
" Markdown preview
nmap <leader>mp <Plug>MarkdownPreviewToggle
