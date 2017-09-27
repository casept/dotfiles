"Enable syntax highlighting
syntax on

" Disable legacy vi compatibility 
set nocompatible

" Always use UTF-8
set encoding=utf-8

" Enable 256 color support
set t_Co=256

"-----------------Set up vundle-----------------------------
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Add the plugins
" Syntax checking
Plugin 'vim-syntastic/syntastic'
" PEP 8 compliance
Plugin 'nvie/vim-flake8'
" Rust-lang support
Plugin 'rust-lang/rust.vim'
" golang support
Plugin 'fatih/vim-go'
" Syntax highlighting for *.toml files
Bundle 'cespare/vim-toml' 
" Proper file browser
Plugin 'scrooloose/nerdtree'
" Git convenience
Plugin 'tpope/vim-fugitive'
" Tmux integration
Plugin 'benmills/vimux'
" Proper aliases
Plugin 'Konfekt/vim-alias'
" Autocompletion                                                                                                     
Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on
"-----------------------------------------------------------

set shortmess=a
set cmdheight=2

" Enable folding
set foldmethod=indent
set foldlevel=99
" Use the spacebar to fold 
nnoremap <space> za

"Ignore E501 (do not complain about long lines in python)
let g:syntastic_python_flake8_args='--ignore=E501'

"Enable golint to be run using :Lint
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
"Automatically run golint on :w
autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow

" Set colorscheme
set background=dark
colorscheme monokai

" List of files for NERDTree to ignore
let NERDTreeIgnore=['\.pyc$', '\~$'] 

" Load vim-alias aliases from ~/.vim/aliases.vimrc
if exists('s:loaded_vimafter')
	silent doautocmd VimAfter VimEnter *
else
	let s:loaded_vimafter = 1
	augroup VimAfter
	autocmd VimEnter * source ~/.vim/aliases.vimrc
	augroup END
endif

" Enable line numbering and change color of LN
set number
highlight LineNr ctermfg=grey
highlight LineNr guifg=#050505

" Syntax-highlighted search
set hlsearch
