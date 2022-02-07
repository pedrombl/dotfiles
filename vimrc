" Set leader
let mapleader = ','

"make it easy to type command in normal mode
nmap ; :

" Color
syntax enable
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

" Remove all buffers except the current one
nmap <Leader>da :%bd\|e#\|bd#<CR>

" NERDTree biding key
nnoremap <silent> <F8> :NERDTreeFind<cr>
nnoremap <silent> <F7> :NERDTreeToggle<cr>
nmap <S-F7> :NERDTreeClose<CR>

" Ack binding key
"noremap <Leader>a :Ack <cword><cr>

" Text commands
iab datetoday <C-R>=strftime("%b %d, %Y")<CR>
iab vg very good
iab ex exceptional
iab ad adequate

" Abreviations
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq| cab Qall qall

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

"Grammar
command! Grammar set spell spelllang=en_us

function! CodeHelper()
  if &list
    :set cc=0
  else
    :set cc=120
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

function! EditFile(file)
  :execute 'edit' a:file
endfunction

function! SplitVertically()
  :vsplit
endfunction

function! OpenTest()
  let app_match = matchstr(@%, 'app/')
  if empty(app_match)
    let with_spec_folder = substitute(@%, '\(\w\+\)\/', 'spec/\1/', '')
    let spec_file = substitute(with_spec_folder, '\.rb', '_spec.rb', 'g')
    if filereadable(spec_file)
      :call EditFileIfExists(spec_file)
    else
      let with_test_folder = substitute(@%, '\(\w\+\)\/', 'test/\1/', '')
      let test_file = substitute(with_test_folder, '\.rb', '_test.rb', 'g')
      :call EditFileIfExists(test_file)
    endif
  else
    let spec_file = substitute(substitute(@%, 'app\/', 'spec/', 'g'), '\.rb', '_spec.rb', 'g')
    if filereadable(spec_file)
      :call EditFileIfExists(spec_file)
    else
      let test_file = substitute(substitute(@%, 'app\/', 'test/', 'g'), '\.rb', '_test.rb', 'g')
      :call EditFileIfExists(test_file)
    endif
  end
endfunction

function! CreateTest()
  let app_match = matchstr(@%, 'app/')
  if empty(app_match)
    let with_spec_folder = substitute(@%, '\(\w\+\)\/', 'spec/\1/', '')
    :call EditFile(substitute(with_spec_folder, '\.rb', '_spec.rb', 'g'))
  else
    :call EditFile(substitute(substitute(@%, 'app\/', 'spec/', 'g'), '\.rb', '_spec.rb', 'g'))
  end
endfunction

function! CreateDirForCurrentFile()
  :!mkdir -p %:h
endfunction

function! OpenSource()
  let is_spec = matchstr(@%, '_spec\.rb') 
  let is_test = matchstr(@%, '_test\.rb') 
  let with_app_folder_on_spec = substitute(substitute(@%, 'spec\/', 'app/', 'g'), '_spec\.rb', '.rb', 'g')
  let with_app_folder_on_test = substitute(substitute(@%, 'test\/', 'app/', 'g'), '_test\.rb', '.rb', 'g')
  if !empty(is_spec)
    :call EditFileIfExists(with_app_folder_on_spec)
  elseif !empty(is_test)
    :call EditFileIfExists(with_app_folder_on_test)
  else
    let without_app_folder = substitute(with_app_folder_on_spec, 'app\/', '', 'g')
    :call EditFileIfExists(without_app_folder)
  end
endfunction

nmap <Leader>ot :call OpenTest()<CR>
nmap <Leader>ct :call CreateTest()<CR>
nmap <Leader>cd :call CreateDirForCurrentFile()<CR>
nmap <Leader>ow :call OpenSource()<CR>
nmap <Leader>oT :call SplitVertically()<CR><C-l>:call OpenTest()<CR>
nmap <Leader>nt :tabe<CR>

" to clean trailing spaces
fun! TrimWhitespace()
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()

" gU, gD: vertical movement through whitespace
" http://vi.stackexchange.com/a/156/67
function! FloatUp()
  while line(".") > 1 && (strlen(getline(".")) < col(".") || getline(".")[col(".") - 1] =~ '\s')
    norm k
  endwhile
endfunction
function! FloatDown()
  while line(".") > 1 && (strlen(getline(".")) < col(".") || getline(".")[col(".") - 1] =~ '\s')
    norm j
  endwhile
endfunction
nnoremap <silent> gU :call FloatUp()<CR>
nnoremap <silent> gD :call FloatDown()<CR>

" Copy matches
function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

set tags+=.git/tags

source $HOME/.vim/conf/plugins
"source $HOME/.vim/conf/coc
