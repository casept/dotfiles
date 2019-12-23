"Enable syntax highlighting
syntax on

" Disable legacy vi compatibility
set nocompatible

" Always use UTF-8
set encoding=utf-8

" Enable 256 color support
set t_Co=256

filetype plugin indent on

set shortmess=a
set cmdheight=2

" Enable folding
set foldmethod=indent
set foldlevel=99
" Use the spacebar to fold
nnoremap <space> za

"Ignore E501 (do not complain about long lines in python)
let g:ale_python_autopep8_options="--ignore=E501"
let g:ale_python_flake8_options="--ignore=E501,E225"
"Automatically run autopep8
autocmd BufWritePost,FileWritePost *.py :call Autopep8() | cwindow
" autopep8 on pressing <F8>
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
" Disable diff view for autopep8
let g:autopep8_disable_show_diff=1

""" Golang configuration
"Enable golint to be run using :Lint
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
"Automatically run golint on :w
autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow
" Set vim-go to run goimports on save
let g:go_fmt_command = "goimports"
" Run gometalinter on save
let g:ale_linters = {'go': ['gometalinter']}
" Enable several additional linters for gometalinter
let g:go_gometalinter_options = "--enable=misspell --enable=unparam --enable=unused --enable=safesql --enable=staticcheck"
"""


""" Colorscheme configuration
set background=dark
colorscheme monokai
"""

""" NERDTree configuration
" List of files for NERDTree to ignore
let NERDTreeIgnore=['\.pyc$', '\~$']
"""

""" Load vim-alias aliases from ~/.vim/aliases.vimrc
if exists('s:loaded_vimafter')
	silent doautocmd VimAfter VimEnter *
else
	let s:loaded_vimafter = 1
	augroup VimAfter
	autocmd VimEnter * source ~/.vim/aliases.vimrc
	augroup END
endif
"""


""" Enable line numbering and change color of LN
set number
highlight LineNr ctermfg=grey
highlight LineNr guifg=#050505
"""

""" Syntax-highlighted search
set hlsearch
"""


""" Enable autoindent
set autoindent
"""


""" Toggle paste mode with <F5>
set pastetoggle=<F5>
"""


"" Neocomplete config
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Go related mappings
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <Leader>b <Plug>(go-build)
au FileType go nmap <Leader>t <Plug>(go-test)
au FileType go nmap gd <Plug>(go-def-tab)
""" End of neocomplete config


""" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
"""

""" Rust configuration
let g:rustfmt_autosave = 1
"""


""" Tab configuration
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
"""

" Allow for 0-height windows to save space by only displaying the filename
" instead of filename + current line
set wmh=0
"""

""" Split config
" Open splits below/to the right of current buffer (as in tmux)
set splitbelow
set splitright


""" Language server config
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ }
