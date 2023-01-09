" ----------------------------------------------------------------------------------
" Plugin definitions
" ----------------------------------------------------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'overcache/NeoSolarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'preservim/nerdtree'
Plugin 'rust-lang/rust.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'tpope/vim-capslock'
Plugin 'preservim/tagbar'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sensible'
Plugin 'easymotion/vim-easymotion'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'vimwiki/vimwiki'

call vundle#end()            " required
filetype plugin indent on    " required
syntax on
" ----------------------------------------------------------------------------------
" VIM Editor settings
" ----------------------------------------------------------------------------------
" Config line numbers
set nonumber
set norelativenumber

set mouse=a
set inccommand=nosplit

set autoindent
set autoread
set cursorline
set nowrap

set background=light

" Disable highlight search
set nohlsearch

" Config tabs
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Open tabs on the right
set splitright

" Theme
colorscheme NeoSolarized

" Show useless whitespaces
let c_space_errors=1

set guifont=Monolisa:h9
set linespace=1

" Margem para rolagem vertical e horizontal
set scrolloff=3
set sidescroll=3

" Show trailing characters
set list
set listchars=trail:¶

" Salva a porra (quase) toda na sessão
set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize
fu! SessionSave()
    execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! SessionRestore()
if filereadable(getcwd() . '/.session.vim')
    execute 'so ' . getcwd() . '/.session.vim'
endif
endfunction

command -nargs=1 -complete=dir SessionCd call SessionCd(<q-args>)
function SessionCd(path)
    let seila=string(a:path)
    " echo seila
    " echo 'cd ' . a:path
    exe 'cd ' . a:path
    call SessionRestore()
endfunction

" Autocommands

au VimLeave * call SessionSave()
au VimEnter * call SessionRestore()

au FocusLost * silent! :wa
au FocusGained,BufEnter * :checktime

au FileType html setlocal ts=2 sts=2 sw=2
au FileType css setlocal ts=2 sts=2 sw=2

au BufNew,BufRead *.ejs :set filetype=html
" ----------------------------------------------------------------------------------
" Ctrlp settings
" ----------------------------------------------------------------------------------
let ctrlp_working_path_mode='r'

set wildignore+=*/tmp/*,*/target/*,*.so,*.swp,*.zip      " MacOSX/Linux
set wildignore+=*\\tmp\\*,*\\target\\*,*.swp,*.zip,*.exe " Windows

let g:ctrlp_follow_symlinks=1
let g:ctrlp_cmd='CtrlPRoot'
let g:ctrlp_use_caching=0

let g:ctrlp_custom_ignore={
  \ 'dir':  '\v[\/](\.(git|hg|svn|target))|(build)|(node_modules)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" ----------------------------------------------------------------------------------
" Easytags configurations
" ----------------------------------------------------------------------------------
" Atualiza as tags após o salvamento de um arquivo
let g:easytags_events = ['BufWritePost']
" ----------------------------------------------------------------------------------
" NERDTree configurations
" ----------------------------------------------------------------------------------
nmap <F6> :NERDTreeToggle<CR>

let g:NERDTreeWinPos="right"
" Fecha a janela do NERDTree após abrir um arquivo
let NERDTreeQuitOnOpen=1

" ----------------------------------------------------------------------------------
" YouCompleteMe settings
" ----------------------------------------------------------------------------------
set completeopt=menu

let g:ycm_global_ycm_extra_conf="~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf=0
let g:ycm_update_diagnostics_in_insert_mode=0
let g:ycm_echo_current_diagnostic="virtual-text"
map gt :YcmCompleter GoTo<CR>

nmap <F8> :silent! :TagbarToggle<CR>
" ----------------------------------------------------------------------------------
" Easymotion
" ----------------------------------------------------------------------------------
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
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
map <Space> <Leader>

nnoremap \ ^
vnoremap \ ^

nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P

nnoremap <Leader>y "+y
nnoremap <Leader>Y "+Y
vnoremap <Leader>y "+y
vnoremap <Leader>Y "+Y

nnoremap <Leader>s :vsplit $NVIMRC
" nnoremap <Leader>w :w<CR>

nnoremap <Leader>i <C-i>
nnoremap <Leader>o <C-o>

vmap > >gv
vmap < <gv

imap <A-k> <Up>
imap <A-j> <Down>
imap <A-h> <Left>
imap <A-l> <Right>
imap <A-w> <C-o>w
imap <A-W> <C-o>W
imap <A-e> <C-o>e
imap <A-E> <C-o>E
imap <A-b> <C-o>b
imap <A-B> <C-o>B

inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

:command W w
:command Q q

nnoremap <Tab> <Esc>
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>
inoremap <Tab> <Esc>`^
inoremap <Leader><Tab> <Tab>

" Abrir o sublime em uma posição específica
command Subl call Subl()
function Subl()
    let file = expand('%')

    if empty(file)
        echohl ErrorMsg
        echom "No named buffer!"
        echohl None
    else
        let pos = getpos('.')
        let location = file . ':' . pos[1] . ':' . pos[2]

        let command = "!\"C:\\Program Files\\Sublime Text\\subl.exe\" -a " . location

        " Atualiza o arquivo e abre o Sublime
        :silent up | silent exe command
    endif
endfunction

" Mostra as correspondências (buscas) no centro da tela
function! CenteredFindNext(forward)
    let s:so_curr=&scrolloff
    set scrolloff=999
    try
        if a:forward
            silent normal! n
        else
            silent normal! N
        endif
    finally
        let &scrolloff=s:so_curr
    endtry
endfunction

nnoremap <silent>n :call CenteredFindNext(1)<CR>
nnoremap <silent>N :call CenteredFindNext(0)<CR>

nnoremap <F7> :cn<CR>
nnoremap <S-F7> :cp<CR>
