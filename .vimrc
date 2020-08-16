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

let mapleader = "\<Space>"              " Leader
let &ls=0                               " Set to 2 to enable statusline (if 0 showcmd is enabled)
let spaceline_seperate_style = 'arrow'

" Settings {{{

" Enable Statusline
if &ls != 0 | set noshowmode | endif
if exists("&pumwidth") | set pumwidth=40 | endif
set pumheight=20
set nocp
set hidden
set termguicolors
set showtabline=0
set cmdheight=1
set noshowcmd 
set arabicshape!
set backspace=indent,eol,start
set complete-=i
set nrformats-=octal
set incsearch
set smartcase
set ignorecase
set scrolloff=2
set wildmenu
set number relativenumber
set nowrap
set noswapfile
set noruler
set mouse=a
set splitbelow splitright
set virtualedit=block
set selection=exclusive
set fdm=marker

if has('nvim')
  set inccommand=nosplit
else
  au BufEnter * set tm=500 ttm=0
endif

" }}}
" Remaps {{{

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
cnoremap <silent> <C-s> <C-\><C-c><C-s>

" Bind CTRL+q -> Quit
nnoremap <silent> <C-q> <C-w>q
inoremap <silent> <C-q> <C-o><C-q>
cnoremap <silent> <C-q> <C-\><C-c><C-q>

" Emacs
inoremap <C-a> <Home>
inoremap <C-b> <C-Left>
inoremap <C-e> <End>
inoremap <C-f> <C-Right>
inoremap <silent> <C-k> <C-r>=exutils#kill_line()<CR>
inoremap <silent> <C-y> <C-r>"

cnoremap <C-k> <C-\>e strpart(getcmdline(), 0, getcmdpos() - 1)<CR>
cnoremap <C-y> <C-r>"
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-k> <C-f>D<C-c><C-c>:<Up>

" Easy paste above/below
nnoremap <silent> <M-p> :put<CR>
nnoremap <silent> <M-P> :put!<CR>

" Easy new lines
nnoremap <silent> <M-o> :call append(line('.'), '')<CR>
nnoremap <silent> <M-O> :call append(line('.')-1, '')<CR>

" Easier Indentations
vnoremap < <gv
vnoremap > >gv

" System Clipboard
noremap <Leader>y "*y
noremap <Leader>Y "+y

" More text-objects 
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
  au BufWrite    * mkview
  au BufRead     * silent! loadview
  au WinEnter    * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "vifmd" | bw! | q | endif
augroup END

" }}}
