set shortmess=a
set cmdheight=2

" Enable folding
set foldmethod=indent
set foldlevel=99
" Use the spacebar to fold
nnoremap <space> za
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c


""" Colorscheme configuration
filetype plugin indent on
syntax on
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox
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
let g:neoformat_enabled_cmake = ['cmakeformat']


augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
let g:neoformat_only_msg_on_error = 1
"""


""" Coc config
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" coc-highlight config
autocmd CursorHold * silent call CocActionAsync('highlight')
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

""" IndentLine config
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indent_blankline_char_list = ['|', '¦', '┆', '┊']
let g:indent_blankline_space_char = ' '
"""

""" vim-gitgutter config
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
"""

""" vimtex config
let g:vimtex_compiler_method = "latexmk"
let g:tex_flavor = "latex"
let g:vimtex_view_method = "zathura"
let g:vimtex_latexmk_continuous = 1
"""

""" Search config
set hlsearch
set incsearch
set ignorecase
"""

""" Termdebug config
packadd termdebug
noremap <silent> <leader>td :Termdebug<cr>
noremap <silent> s :Step<cr>
noremap <silent> o :Over<cr>
noremap <silent> c :Continue<cr>
noremap <silent> t :Evaluate<cr>
"""

""" Enable loading of per-project .vimrc
set exrc
set secure
"""
