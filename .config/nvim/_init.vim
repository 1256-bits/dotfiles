set number rnu
set ts=4 sw=4
set clipboard+=unnamedplus
" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

inoremap <silent><expr> <M-CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-y>"

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue AutoFormatBuffer prettier
  autocmd FileType swift AutoFormatBuffer swift-format
augroup END

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vieira/vim-javascript', {'branch': 'master'}
Plug 'google/vim-maktaba', {'branch': 'master'}
Plug 'google/vim-codefmt', {'branch': 'master'}
Plug 'kovetskiy/sxhkd-vim', {'branch': 'master'}
Plug 'google/vim-glaive', {'branch': 'master'}
call plug#end()
