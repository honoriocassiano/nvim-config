" ----------------------------------------------------------------------------------
" Plugin definitions
" ----------------------------------------------------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'preservim/nerdtree'
Plugin 'rust-lang/rust.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'koron/nyancat-vim'
Plugin 'tpope/vim-capslock'
Plugin 'preservim/tagbar'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sensible'

call vundle#end()            " required
filetype plugin indent on    " required

" ----------------------------------------------------------------------------------
" VIM Editor settings
" ----------------------------------------------------------------------------------
" Config line numbers
set mouse=a
set inccommand=nosplit

set autoindent
set autoread
set number
set relativenumber

" Disable highlight search
set nohlsearch

" Config tabs
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Theme
colorscheme solarized

" Show useless whitespaces
let c_space_errors=1

set guifont=Fira\ Code:h10
set linespace=3

" Show trailing characters
set list
set listchars=trail:¶

" ----------------------------------------------------------------------------------
" Ctrlp settings
" ----------------------------------------------------------------------------------
let ctrlp_working_path_mode='r'

set wildignore+=*/tmp/*,*/target/*,*.so,*.swp,*.zip      " MacOSX/Linux
set wildignore+=*\\tmp\\*,*\\target\\*,*.swp,*.zip,*.exe " Windows

let g:ctrlp_follow_symlinks=1
let g:ctrlp_cmd='CtrlPRoot'
let g:ctrlp_use_caching=0

" let g:ctrlp_custom_ignore='\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore={
  \ 'dir':  '\v[\/](\.(git|hg|svn|target))|(build)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" ----------------------------------------------------------------------------------
" NERDTree configurations
" ----------------------------------------------------------------------------------
nmap <F6> :NERDTreeToggle<CR>

let g:NERDTreeWinPos="right"

" ----------------------------------------------------------------------------------
" YouCompleteMe settings
" ----------------------------------------------------------------------------------
set completeopt=menu

let g:ycm_key_list_select_completion=['<C-j>']
let g:ycm_key_list_previous_completion=['<C-k>']

let g:ycm_global_ycm_extra_conf="~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf=0
let g:ycm_update_diagnostics_in_insert_mode=0
let g:ycm_echo_current_diagnostic="virtual-text"
map gt :YcmCompleter GoTo<CR>

au BufWritePost *.c,*.cpp,*.h silent! !ctags -R %
nmap <F8> :silent! :TagbarToggle<CR>

" ----------------------------------------------------------------------------------
" Specific language settings
" ----------------------------------------------------------------------------------
" Rust
let g:rustfmt_autosave=1

" Haskell
let g:haskellmode_completion_ghc=0

" neco-ghc
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:necoghc_enable_detailed_browse=1

" Useful shortcuts
let mapleader=" "

inoremap jk <Esc>
inoremap kj <Esc>

nnoremap \ ^
vnoremap \ ^

nnoremap <Leader><Leader> :

nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P

nnoremap <Leader>y "+y
nnoremap <Leader>Y "+Y
vnoremap <Leader>y "+y
vnoremap <Leader>Y "+Y

nnoremap <Leader>s :vsplit $NVIMRC
nnoremap <Leader>w :w<CR>
