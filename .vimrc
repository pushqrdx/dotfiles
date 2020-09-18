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
  Plug 'vimoxide/vim-commentary'
  Plug 'vimoxide/vim-devicons'
  Plug 'vimoxide/vim-extra-utils'
  Plug 'vimoxide/vim-indent-object'
  Plug 'vimoxide/vim-mkdir'
  Plug 'vimoxide/vim-quickscope'
  Plug 'vimoxide/vim-regreplop'
  Plug 'vimoxide/vim-vem-tabline'
  Plug 'vimoxide/vim-vifmd'
call plug#end()

colorscheme cinnabar

let mapleader  = "\<Space>"
let &ls        = 0
let pumwidth   = 40
let pumheight  = 20
let vimrcdir   = fnamemodify($MYVIMRC, ':p:h')

" Settings {{{
augroup RelativeLineToggle
  autocmd!
  au InsertEnter * set norelativenumber
  au InsertLeave * set relativenumber
  au BufEnter    * set formatoptions-=cro
augroup END

set shortmess+=c
set backspace=indent,eol,start
set cmdheight=1
set fdm=marker
set hidden
set ignorecase incsearch smartcase
set mouse=a
set noruler noshowcmd nowrap
set number relativenumber
set splitbelow splitright
set termguicolors
set virtualedit=block
set wildmenu
set tm=1000 ttm=50
set swapfile backup undofile

if &ls == 2 | set nosmd | endif
if exists('&pumwidth')  | let &pumwidth = pumwidth   | endif
if exists('&pumheight') | let &pumheight = pumheight | endif

let &directory = vimrcdir . '/.vim/swap//'
let &backupdir = vimrcdir . '/.vim/backup//'
let &undodir   = vimrcdir . '/.vim/undo//'

for directory in [&directory, &backupdir, &undodir]
  if !isdirectory(directory)
    call mkdir(directory, 'p')
  endif
endfor

" }}}
" Remaps {{{
nnoremap <Space> <Nop>
nnoremap <Leader>v :e $MYVIMRC<CR>

" Random
nnoremap Y y$
nnoremap <silent> <Leader>cd :cd %:p:h<CR>
nnoremap <Leader><Tab> za
nnoremap <C-Space> m'
nnoremap Q @@
nnoremap <silent> <Leader> :noh<CR>

" Visual Mode
vnoremap < <gv
vnoremap > >gv
vnoremap <silent> . :norm .<CR>gv

" Splits
nnoremap <silent> <bar> :vs<CR>
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" Save
nnoremap <silent> <C-s> :up<CR>
imap <C-s> <C-o><C-s>

" Delete buffer
nnoremap <silent> <C-q> :bd<CR>
imap <C-q> <C-o><C-q>

" Emacs
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-W> <C-\><C-O>db
inoremap <C-U> <C-\><C-O>d0
inoremap <C-k> <C-\><C-O>d$
inoremap <C-y> <C-r>"
cnoremap <C-k> <C-\>e exutils#kill_cmd_line(v:false)<CR>
cnoremap <C-u> <C-\>e exutils#kill_cmd_line(v:true)<CR>
cnoremap <C-y> <C-r>"
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" More Range Mappings
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '-', '#' ]
  execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
  execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
  execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
  execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" Put
nnoremap <silent> <Leader>p :put<CR>
nnoremap <silent> <Leader>P :put!<CR>

" Put Empty Line
nnoremap <silent> <Leader>o :call append(line('.'), '')<CR>
nnoremap <silent> <Leader>O :call append(line('.')-1, '')<CR>

" Quick buffer cycling
nnoremap <C-{> <Plug>vem_prev_buffer-
nnoremap <C-}> <Plug>vem_next_buffer-

" Vifm Drawer
nnoremap <silent> <Leader>d :VifmdToggle<CR>

" Replace
nmap <Leader>r  <Plug>ReplaceMotion
nmap <Leader>rl <Plug>ReplaceLine
vmap <Leader>r  <Plug>ReplaceVisual

" }}}
