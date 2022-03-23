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
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plug-vim
" increase timeout for ycm
let g:plug_timeout = 180
call plug#begin(stdpath('data').'/plugged')

" User Plugins
Plug 'morhetz/gruvbox'
Plug 'bling/vim-bufferline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'simeji/winresizer'
Plug 'raimondi/delimitmate'
Plug 'rhysd/vim-grammarous', { 'for': ['tex','latex'] }
Plug 'bfrg/vim-cpp-modern', { 'for': ['c', 'cpp'] }
Plug 'vim-perl/vim-perl', { 'for': 'perl'}
Plug 'pangloss/vim-javascript', { 'for': 'javascript'}
Plug 'stephpy/vim-yaml', { 'for': ['yaml']}
Plug 'derekwyatt/vim-scala', { 'for': 'scala'}
Plug 'leafgarland/typescript-vim', { 'for': 'typescript'}
Plug 'lervag/vimtex', { 'for': ['tex', 'latex']}
Plug 'Konfekt/FastFold'
Plug 'ntpeters/vim-better-whitespace'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'

" finish Plugins
call plug#end()

" SETTINGS
" Show line numbers
set number
" enable sign column, both for gitgutter and coc/ale
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Give more space for displaying messages.
set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

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
set undofile

" PLUGIN SETTINGS
" auto close nerdtree if its the only buffer open
autocmd bufenter * if(winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Vim Airline Powerline fonts
let g:airline_powerline_fonts = 1
" Vim Airline Theme
let g:airline_theme='gruvbox'
" airline extensions
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#vimtex#enabled = 1
let g:airline#extensions#coc#enabled= 1

"vim-gitgutter settings
"update the vim refresh rate for a smoother experience
set updatetime=250
"dont show vim-bufferline in command line
let g:bufferline_echo = 0

"ale settings
let g:ale_disable_lsp = 1 "disable lsp in ALE to use coc.nvim
let g:ale_sign_error = '❌'
let g:ale_sign_warning ='⚠️'

let g:ale_linters = {
            \      'cpp' : ['clangtidy'],
            \      'c' : ['clangtidy'],
            \}
let g:ale_cpp_clangtidy_checks = []
let g:ale_cpp_clangtidy_executable ='clang-tidy'
let g:ale_c_parse_compile_commands=1
let g:ale_cpp_clangtidy_extra_options = ''
let g:ale_cpp_clangtidy_options = ''

let g:ale_vhdl_ghdl_options = '--std=08'

let g:ale_lint_on_save = 1

"coc settings
let g:coc_global_extensions = ['coc-pyright', 'coc-clangd', 'coc-json', 'coc-cmake', 'coc-emoji', 'coc-snippets']


" fast fold settings
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x', 'X', 'a', 'A', 'o', 'O', 'c', 'C']
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
set background=light
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column = 'bg0'
colorscheme gruvbox
set termguicolors
set cursorline

" winresizer
let g:winresizer_finish_with_escape = 1

" c/cpp highlighting
let g:cpp_simple_highlight = 1
let g:cpp_member_variable_highlight = 1

" vinegar
" start with dotfiles hidden
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" NERDCommenter
let g:NERDCreateDefaultMappings = 0

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
"fast fold
nmap <leader>zu <Plug>(FastFoldUpdate)
" grammarous bindings
nmap <leader>sf <Plug>(grammarous-move-to-info-window)
nmap <leader>so <Plug>(grammarous-open-info-window)
nmap <leader>sc :GrammarousCheck<cr>
nmap <leader>sr :GrammarousReset<cr>
let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
    nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
    nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
    nmap <buffer><C-r> <Plug>(grammarous-remove-error)
    nmap <buffer><C-R> <Plug>(grammarous-disable-rule)
    nmap <buffer><C-f> <Plug>(grammarous-fixit)
    nmap <buffer><C-c> <Plug>(grammarous-reset)
endfunction
" ale bindings
nmap <leader>al :ALELint<cr>

function! g:grammarous#hooks.on_reset(errs) abort
    nunmap <buffer><C-n>
    nunmap <buffer><C-p>
    nmap <buffer><C-r>
    nmap <buffer><C-R>
    nmap <buffer><C-f>
    nmap <buffer><C-c>
endfunction

"CoC
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
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
inoremap <silent><expr> <C-Tab> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> <leader>cp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>cn <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leadeR>gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>cr <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)
nnoremap <leader>ff <Plug>(coc-format)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>cc  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>cf  <Plug>(coc-fix-current)
" Show Codelens or current line
nmap <leader>cl <Plug>(coc-codelens-action)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" coc snippets
" Use <C-l> for trigger snippet expand.
imap <C-x> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-n> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-n> for both expand and jump (make expand higher priority.)
imap <C-n> <Plug>(coc-snippets-expand-jump)
" Use <leader>cx for convert visual selected code to snippet
xmap <leader>cx  <Plug>(coc-convert-snippet)

" NerdCommenter
nmap <leader>cc  <Plug>NerdCommenterToggle
xmap <leader>cc  <Plug>NerdCommenterToggle
xmap <leader>ccc <Plug>NerdCommenterComment
xmap <leader>ccu <Plug>NerdCommenterUncomment
