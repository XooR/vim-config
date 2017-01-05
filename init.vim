" vim: set foldmethod=marker foldlevel=0:"
set nocompatible

" vundle {{{1
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


Plugin 'tpope/vim-fugitive'
Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'altercation/vim-colors-solarized'
Plugin 'godlygeek/tabular.git'
Plugin 'vim-scripts/taglist.vim'
Plugin 'tomtom/tlib_vim'
Plugin 'bling/vim-airline'
Plugin 'fatih/vim-go'

call vundle#end()
filetype plugin indent on

" General options {{{1
syntax on

set number
set numberwidth=5

set noswapfile
set nomousehide " don't hide mouse pointer during typing

" Gives menu on TAB completion
set wildmenu

" backspaces over everything in insert mode
set backspace=indent,eol,start

if exists('+colorcolumn')
  set colorcolumn=80
endif

" folding
set foldmethod=indent
set foldlevel=99

set incsearch  " show while typing pattern
set visualbell " flash on error

" If you want list, set list
set listchars=tab:.\ ,trail:.,extends:#,nbsp:.
set nolist

set hlsearch
" cmd line history
set history=500

set scrolloff=10 " Scroll with 10 line buffer above and bellow

" font
if has("gui_running")
  set guifont=Menlo\ For\ Powerline\ 11
  let g:airline_powerline_fonts=1
  set guioptions-=T
endif

colorscheme desert256
"if &t_Co >= 256 || has("gui_running")
"  set guifont=Droid\ Sans\ Mono\ 11
"  set guioptions-=T
"else
"  colorscheme xoria256
"endif

" turn off cursor blinking
set guicursor+=a:blinkon0

" ShortCuts {{{1
" <space> - clear recent search highlighting with space {{{2
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" :w!! - save files as root without prior sudo {{{2
cmap w!! w !sudo tee % >/dev/null

"<n>; enter command mode {{{2
nnoremap ; :

let mapleader = ','

" <n> ,a - :Ack {{{2
nnoremap <Leader>a :Ack
" <n> ,, - NERDTreeTabsToggle {{{2
noremap <Leader>, :NERDTreeToggle<cr>
" <n> ,f - Find current file {{{2
nmap <leader>f :NERDTreeFind<cr>

" <n> ,l - set list {{{2
nmap <leader>l :set list<cr>
nmap <leader>L :set nolist<cr>

" <n> ,e - Remove all spaces in a file before end of line {{{2
nmap <leader>e :%s/\s\+$//<cr>

" <n> ,cd - CWD to directory of current file {{{2
nmap <leader>cd :cd %:p:h<cr>

" <n> + - increase windows size to vertically {{{2
nmap + <c-w>+
" <n> - - decrease windows size to vertically {{{2
nmap _ <c-w>-

" <n> ,. - TlistToggle {{{2
nmap <Leader>. :TlistToggle<cr>

" <n> ,c - :tabclose {{{2
nmap <Leader>c :tabclose<cr>
" <i> C^s - SERBIAN KeyBoard {{{2
imap <silent> <C-s> <ESC>:if &keymap =~ 'serbian' <Bar>
                    \set keymap= <Bar>
                \else <Bar>
                    \set keymap=serbian <Bar>
                \endif <Enter>a

" <v> Copy/Paste -> xclip {{{2
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction

vnoremap <Leader>y y:call ClipboardYank()<cr>
nnoremap <Leader>p :call ClipboardPaste()<cr>p
" Plugin configurations {{{1
" NERTTree {{{2
" Sidebar folder navigation
let NERDTreeShowLineNumbers=1
let NERDTreeShowBookmarks=1
let g:NERDTreeHighlightCursorline=1
let NERDTreeChDirMode=2 " Change CWD
let NERDTreeWinSize=50 " width
let NERDTreeIgnore=['CVS']

" ----- bling/vim-airline settings ----- {{{2
" Always show statusbar
set laststatus=2

" ack {{{2
let g:ackprg="ack -H --nocolor --nogroup --column"

" Tag list {{{2
let Tlist_Use_SingleClick = 1
let Tlist_Use_Right_Window = 1
let Tlist_Show_Menu = 1
let Tlist_Compact_Format = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_WinWidth = 50
