set number rnu
set ts=4 sw=4
set clipboard+=unnamedplus
" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

inoremap <silent><expr> <M-CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-y>"

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vieira/vim-javascript', {'branch': 'master'}
Plug 'google/vim-maktaba', {'branch': 'master'}
Plug 'google/vim-codefmt', {'branch': 'master'}
Plug 'kovetskiy/sxhkd-vim', {'branch': 'master'}
call plug#end()
