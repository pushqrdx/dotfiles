"                              ,,      ,,          
"    ▄▄▓▓▓▄▄                   ▓▓      ▓▓          
"   ▓▓Γ   '▓▓     ▓▓▓▓▓▓▓▓▌    ▓▓      ▓▓  ▄▓▓▀▓▓▓ 
"   ╨▓▓▄▄,                     ▓▓██████▓▓ ╔▓▌   ▓▓ 
"      ╙▀▀█▓▓                  ▓▓      ▓▓ ╙▓▄   ▓▓ 
"   ▓▓     ▓▓∩    ▓▓▓▓▓▓▓▓▌    ▓▓      ▓▓  ▀▓▄▄▓▓▓ 
"    ▀▓▓▓▓▓█▀      ╙╙╙╙╙╙╙                 ▓▄  ,▓▓ 
"                                           ▀▀▀▀╚  

call plug#begin()
  Plug 'vimoxide/vim-cinnabar'
  Plug 'vimoxide/vim-devicons'
  Plug 'vimoxide/vim-extra-utils'
  Plug 'vimoxide/vim-indent-detector'
  Plug 'vimoxide/vim-indent-object'
  Plug 'vimoxide/vim-lion'
  Plug 'vimoxide/vim-mkdir'
  Plug 'vimoxide/vim-quickscope'
  Plug 'vimoxide/vim-sherlock'
  Plug 'vimoxide/vim-spaceline'
  Plug 'vimoxide/vim-vifmd'
call plug#end()

colorscheme cinnabar

let mapleader = "\<Space>"    " Leader
let &ls       = 2             " Set to 0 to disable statusline (if 0, showmode is enabled)

" Settings {{{

" Note that creating a vimrc file will cause the 'compatible' option to be off
set arabicshape!
set backspace=indent,eol,start
set cmdheight=1
set complete-=i
set fdm=marker
set hidden
set ignorecase
set incsearch
set mouse=a
set noruler
set noshowcmd 
set nowrap
set nrformats-=octal
set number relativenumber
set pumheight=20
set scrolloff=2
set selection=exclusive
set showtabline=0
set smartcase
set splitbelow splitright
set termguicolors
set virtualedit=block
set wildmenu

set swapfile
let &directory = expand('~/.vim/swap//')

set backup
let &backupdir = expand('~/.vim/backup//')

set undofile
let &undodir = expand('~/.vim/undo//')

if !isdirectory(&undodir) | call mkdir(&undodir, "p") | endif
if !isdirectory(&backupdir) | call mkdir(&backupdir, "p") | endif
if !isdirectory(&directory) | call mkdir(&directory, "p") | endif

if has('nvim')
  set inccommand=nosplit
else
  au BufEnter * set tm=500 ttm=0
endif

if &ls == 2 | set nosmd | endif
if exists('&pumwidth') | set pumwidth=40 | endif

" }}}
" Remaps {{{

" Y like D
nnoremap Y y$

" Folds
nnoremap <Tab> za

" NOP Space
nnoremap <Space> <Nop>

" Quick Mark
nnoremap <C-Space> m'

" Repeat Macro
nnoremap Q @@

" Repeats latest action on selected lines
" retaining selection
vnoremap <silent> . :norm .<CR>gv

" Opens $MYVIMRC for editing, or use :tabedit $MYVIMRC
nnoremap <silent> <Leader>v :e $MYVIMRC<CR>

" Splits
nnoremap <silent> \| :vs<CR>
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k

" Bind CTRL+S -> Save
nnoremap <silent> <C-s> :w<cr>
inoremap <silent> <C-s> <C-o><C-s>

" Bind CTRL+q -> Buffer Delete
nnoremap <silent> <C-q> :bd<CR>
inoremap <silent> <C-q> <C-o><C-q>

" Emacs
inoremap <C-a> <Home>
inoremap <C-b> <C-Left>
inoremap <C-e> <End>
inoremap <C-f> <C-Right>
inoremap <silent> <C-W> <C-\><C-O>db
inoremap <silent> <C-U> <C-\><C-O>d0
inoremap <silent> <C-k> <C-\><C-O>d$
inoremap <C-y> <C-r>"

cnoremap <C-k> <C-\>e exutils#kill_cmd_line(v:false)<CR>
cnoremap <C-u> <C-\>e exutils#kill_cmd_line(v:true)<CR>
cnoremap <C-y> <C-r>"
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Easy paste above/below
nnoremap <silent> <M-p> :put<CR>
nnoremap <silent> <M-P> :put!<CR>

" Easy new lines
nnoremap <silent> <M-o> :call append(line('.'), '')<CR>
nnoremap <silent> <M-O> :call append(line('.')-1, '')<CR>

" Easier Indentations
vnoremap < <gv
vnoremap > >gv

" More Range Selections
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '-', '#' ]
  execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
  execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
  execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
  execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" Terminal
tnoremap <silent> <ESC><ESC> <C-\><C-N><C-w><C-w>
nnoremap <silent> <Leader>p :VifmdToggle<CR>

" Sherlock
cnoremap <C-p> <C-\>e sherlock#completeBackward()<CR>
cnoremap <C-n> <C-\>e sherlock#completeForward()<CR>

" Quick buffer cycling
nnoremap <silent> <Leader>bn :call exutils#next_buffer()<CR>
nnoremap <silent> <Leader>bp :call exutils#previous_buffer()<CR>

" }}}
" Autocmd {{{

augroup CustomGroup
  autocmd!
  au InsertEnter * set norelativenumber
  au InsertLeave * set relativenumber
  au BufEnter    * set formatoptions-=cro
augroup END

" }}}

