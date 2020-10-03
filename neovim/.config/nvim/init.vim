set shortmess=a
set cmdheight=2

" Enable folding
set foldmethod=indent
set foldlevel=99
" Use the spacebar to fold
nnoremap <space> za


""" Colorscheme configuration
filetype plugin indent on
syntax on
set background=dark
colorscheme monokai
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

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.

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
"""


""" Autoformatter config
" Only languages not supported by coc are configured here, the rest are
" configured via coc
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
let g:neoformat_only_msg_on_error = 1
"""


""" Denite config

" Define mappings
" TODO: Reenable once nix neovim package gets a bumped msgpack
"autocmd FileType denite call s:denite_my_settings()
"function! s:denite_my_settings() abort
"  nnoremap <silent><buffer><expr> <CR>
"  \ denite#do_map('do_action')
"  nnoremap <silent><buffer><expr> d
"  \ denite#do_map('do_action', 'delete')
"  nnoremap <silent><buffer><expr> p
"  \ denite#do_map('do_action', 'preview')
"  nnoremap <silent><buffer><expr> q
"  \ denite#do_map('quit')
"  nnoremap <silent><buffer><expr> i
"  \ denite#do_map('open_filter_buffer')
"  nnoremap <silent><buffer><expr> <Space>
"  \ denite#do_map('toggle_select').'j'
"endfunction

"autocmd FileType denite-filter call s:denite_filter_my_settings()
"	function! s:denite_filter_my_settings() abort
"	  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
"	endfunction

" Use ripgrep in place of grep
"call denite#custom#var('grep', 'command', ['rg'])
" Custom options for ripgrep
"call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])
" Recommended defaults for ripgrep via Denite docs
"call denite#custom#var('grep', 'recursive_opts', [])
"call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
"call denite#custom#var('grep', 'separator', ['--'])
"call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
"call denite#custom#var('buffer', 'date_format', '')
"""


""" Debugger config
packadd termdebug
"""

""" Rainbow brackets
let g:rainbow_active = 1
" Default colors are poorly visible w/ monokai
let g:rainbow_conf = {'ctermfgs': ['blue', 'yellow', 'cyan', 'magenta']}
" Cmake syntax highlighting breaks if used alongside rainbow
augroup rainbow_off
    au!
    au FileType cmake RainbowToggleOff
augroup END
"""
