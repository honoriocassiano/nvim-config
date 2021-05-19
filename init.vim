set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
" set rtp+=$HOME.'/vimfiles/bundle/Vundle.vim/'
" call vundle#begin($HOME.'/vimfiles/bundle/')
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'preservim/nerdtree'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'rust-lang/rust.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'ycm-core/YouCompleteMe'

Plugin 'altercation/vim-colors-solarized'

call vundle#end()            " required
filetype plugin indent on    " required

" NERDTree configurations
nmap <F6> :NERDTreeToggle<CR>

" YouCompleteMe settings
set completeopt=menu

let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
" ----------------------------------------------------------------------------------
" Ctrlp settings
let ctrlp_working_path_mode = 'r'

set wildignore+=*/tmp/*,*/target/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*\\target\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_follow_symlinks=1
let g:ctrlp_cmd='CtrlPRoot'
let g:ctrlp_use_caching=0

" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\v[\/]\.(git|hg|svn|target)$',
"   \ 'file': '\v\.(exe|so|dll)$',
"   \ }

" ----------------------------------------------------------------------------------

" Util Snips settings
let g:UltiSnipsSnippetsDir = $HOME.'/vimfiles/bundle/vim-snippets/UltiSnips'

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" ----------------------------------------------------------------------------------
" VIM Editor settings
" Config line numbers
set autoindent
set autoread
set number

" Config tabs
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Theme
set background=light
colorscheme solarized

" Show useless whitespaces
let c_space_errors = 1

" nnoremap <C-i> :%s/;/ {\r}
" Defined macros
" Insert characters in normal mode
:nnoremap <Space> i_<Esc>r

set list
set listchars=trail:.

" ----------------------------------------------------------------------------------
" Specific language settings
" ----------------------------------------------------------------------------------
" Rust
" let g:rustc_path=$HOME."/.cargo/bin/rustc"
" let g:rustfmt_command="rustfmt %"
let g:rustfmt_autosave=1
