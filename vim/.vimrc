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
" Zenburn color scheme
Plugin 'jnurmine/Zenburn'
" Solarized color scheme
Plugin 'altercation/vim-colors-solarized'
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


" Enable folding
set foldmethod=indent
set foldlevel=99
" Use the spacebar to fold 
nnoremap <space> za

" Follow PEP8 when editing *.py files
" Also use it for *.rs files, as those have quite simmilar best practices
au BufNewFile,BufRead *.py, *.rs
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix


"Enable golint to be run using :Lint
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
"Automatically run golint on :w
autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow

" Set colorscheme
set background=dark
colorscheme solarized

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
