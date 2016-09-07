" Set leader
let mapleader = ','

"make it easy to type command in normal mode
nmap ; :

" Color
syntax enable
set background=dark
colorscheme solarized
set background=dark

" set mouse
if has('mouse') | set mouse=a | endif

"clipboard
set clipboard=unnamed

" Show number and ruler
set nu
set ruler

" incremental search
set incsearch

" highlight search
set hlsearch
nnoremap <Enter> :nohlsearch<CR><C-L>

" Text, tab and ident related
"set smarttab
set expandtab " spaces instead of tab
set shiftwidth=2 " tab == 2 spaces
set tabstop=2

set ai "Auto ident

" Set font
set guifont=Monaco:h12

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Navigation between files
nnoremap <Leader><Leader> <c-^>
nmap <Leader>d :bdelete<cr>
nnoremap <F5> :buffers<CR>:buffer<Space>
set hidden
set confirm


" NERDTree biding key
nnoremap <silent> <F8> :NERDTreeFind<cr>
nnoremap <silent> <F7> :NERDTreeToggle<cr>
nmap <S-F7> :NERDTreeClose<CR>

" Abreviations
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq

" Turn of backup since there is version controls
set nobackup
set nowb
set noswapfile

" To always show status line
set laststatus=2

" source $MYVIMRC reloads the saved $MYVIMRC
nmap <Leader>s :source $MYVIMRC<CR>

" opens $MYVIMRC for editing, or use :tabedit $MYVIMRC
nmap <Leader>v :e $MYVIMRC<CR>

"set trailing spaces
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
"nmap <Leader>l :let &list = !&list<CR>
nmap <Leader>l :call CodeHelper()<CR>

function! CodeHelper()
  if &list
    :set cc=0
  else
    :set cc=80
  endif
  :let &list = !&list
endfunction

"ignore files
set wildignore+=*/assets/*,*/node_modules/*,*/test_out/*,*.so,*.swp,*.zip

"structure move to test
function! EditFileIfExists(file)
  if filereadable(a:file)
    :execute 'edit' a:file
  else
    :echom "File does not exists: " . a:file
  endif
endfunction

function! SplitVertically()
  :vsplit
endfunction
function! OpenTest()
  :call EditFileIfExists(substitute(substitute(@%, 'app\/', 'spec/', 'g'), '\.rb', '_spec.rb', 'g'))
endfunction
function! OpenSource()
  :call EditFileIfExists(substitute(substitute(@%, 'spec\/', 'app/', 'g'), '_spec\.rb', '.rb', 'g'))
endfunction

nmap <Leader>ot :call OpenTest()<CR>
nmap <Leader>ow :call OpenSource()<CR>
nmap <Leader>oT :call SplitVertically()<CR><C-l>:call OpenTest()<CR>

" to clean trailing spaces
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()

source $HOME/.vim/conf/plugins

let g:syntastic_javascript_checkers=['jshint']

nmap <c-B> :CtrlPBuffer<cr>

if executable('ag')
  " Use ag over grep
  let g:ackprg = 'ag --vimgrep'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
