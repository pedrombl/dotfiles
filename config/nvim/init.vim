set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" get out of insert mode in the terminal
tnoremap jj <C-\><C-n>
