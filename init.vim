set nocompatible
filetype plugin on
filetype plugin indent on

" vim-plug {{{1
call plug#begin('~/.vim/plugged')

" This plugin adds a :Terraform command that runs terraform, with tab
" completion of subcommands. It also sets up *.tf, *.tfvars, and *.tfstate
" files to be highlighted as HCL, HCL, and JSON respectively.
Plug 'hashivim/vim-terraform'
Plug 'vim-syntastic/syntastic'
Plug 'neomake/neomake'
Plug 'pearofducks/ansible-vim'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'juliosueiras/vim-terraform-completion'

Plug 'tpope/vim-fugitive'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'altercation/vim-colors-solarized'
Plug 'godlygeek/tabular'
Plug 'tomtom/tlib_vim'
Plug 'bling/vim-airline'
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'google/vim-jsonnet'
Plug 'majutsushi/tagbar'
Plug 'NLKNguyen/papercolor-theme'

call plug#end()

call neomake#configure#automake('nrwi', 0)

set t_Co=256
set background=dark
colorscheme PaperColor

let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.terraform = '[^ *\t"{=$]\w*'
let g:deoplete#enable_at_startup = 1
call deoplete#initialize()

call deoplete#custom#option({
\ 'smart_case': v:true,
\ })

set rtp+=~/.fzf

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

set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>

au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
au BufRead,BufNewFile */*ansible*/*.yml set filetype=yaml.ansible

" font
if has("gui_running")
  set guifont=Menlo\ For\ Powerline\ 11
  let g:airline_powerline_fonts=1
  set guioptions-=T
endif

"colorscheme desert256
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

let mapleader = ','


" <n> ,, - NerdTreeToggle {{{2
noremap <Leader>, :NERDTreeToggle<CR>
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

" <n> ,. - TagbarToggle {{{2
noremap <Leader>. :TagbarToggle<CR>

" <n> ,c - :tabclose {{{2
nmap <Leader>c :tabclose<cr>
" <n> ,n - :tabnext {{{2
nmap <Leader>n :tabnext<cr>
" <n> ,p - :tabprevious {{{2
nmap <Leader>p :tabprevious<cr>
" <n> ,m - Sets markdown options for editing (Zabbix scripts that have embeded markdown documenation){{{2
nmap <Leader>m :set sts=4 sw=4 expandtab<cr>

" <n>; :Buffers
nmap ; :Buffers<CR>
" <n>r :Tags
nmap <Leader>r :Tags<CR>
" <n>t :Files
nmap <Leader>t :Files<CR>
" <n>a :Ag
nmap <Leader>a :Ag<CR>

" <v> ,m - Escape all markdown characters in selected visual block except '*'. {{{2
"vmap <Leader>m :'<,'>s/\v(\\)@\<\!(\`\|_\|\{\|\}\|\[\|\]\|\(\|\)\|\#\|\+\|\-\|\!\|[<>])/\\\2/g<cr>
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
" function! ClipboardPaste()
"   let @@ = system('xclip -o -selection clipboard')
" endfunction

vnoremap <Leader>y y:call ClipboardYank()<cr>
"#vnoremap <Leader>y "*y<cr>
"nnoremap <Leader>p :call ClipboardPaste()<cr>p
" :Bs - buffer select {{{2


function! BufSel(pattern)
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, a:pattern) > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches == 1)
    execute ":buffer ". firstmatchingbufnr
  elseif(nummatches > 1)
    let desiredbufnr = input("Enter buffer number: ")
    if(strlen(desiredbufnr) != 0)
      execute ":buffer ". desiredbufnr
    endif
  else
    echo "No matching buffers"
  endif
endfunction

"Bind the BufSel() function to a user-command
command! -nargs=1 Bs :call BufSel("<args>")

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
let g:ackprg="ag --vimgrep -Uf "

" Tag list {{{2
let Tlist_Use_SingleClick = 1
let Tlist_Use_Right_Window = 1
let Tlist_Show_Menu = 1
let Tlist_Compact_Format = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_WinWidth = 50
" Syntastic {{{2

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <Leader>c :SyntasticCheck<CR>
nnoremap <Leader>s :SyntasticToggleMode<CR>

" (Optional)Remove Info(Preview) window
set completeopt-=preview

" (Optional)Hide Info(Preview) window after completions
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" coc.nvim {{{2
"
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

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
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

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

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

