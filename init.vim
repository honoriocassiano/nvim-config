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
Plugin 'ycm-core/YouCompleteMe'
Plugin 'tpope/vim-capslock'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sensible'
Plugin 'easymotion/vim-easymotion'
Plugin 'vimwiki/vimwiki'
Plugin 'digitaltoad/vim-pug'
Plugin 'tikhomirov/vim-glsl'
Plugin 'habamax/vim-godot'
Plugin 'qpkorr/vim-bufkill'
Plugin 'elixir-editors/vim-elixir'
Plugin 'Asheq/close-buffers.vim'

call vundle#end()            " required
filetype plugin indent on    " required
syntax on
" ----------------------------------------------------------------------------------
" VIM Editor settings
" ----------------------------------------------------------------------------------
" Config line numbers
set number
set relativenumber

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

" Better undo history
set undofile

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
set listchars=tab:▶\ ,trail:¶

" Salva a porra (quase) toda na sessão
set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize
fu! SessionSave()
    execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! SessionRestore()
let dir=getcwd()
if filereadable(dir . '/.session.vim') && dir != $NVIM_HOME
    execute 'so ' . dir . '/.session.vim'
endif
endfunction

command -nargs=1 -complete=dir SessionCd call SessionCd(<q-args>)
function SessionCd(path)
    let seila=string(a:path)
    " echo seila
    " echo 'cd ' . a:path
    exe 'cd ' . a:path
    call SessionRestore()
    normal! :CtrlPDir :pwd<ESC>
endfunction

" Autocommands

augroup session
    au!
    au VimLeave * call SessionSave()
    au VimEnter * call SessionRestore()
augroup end

augroup alttab
    au!
    au FocusLost * silent! :wa
    au FocusGained,BufEnter [^\[]*[^\]] :checktime
augroup end

augroup web
    au!
    au FileType html setlocal ts=2 sts=2 sw=2
    au FileType css setlocal ts=2 sts=2 sw=2

    au BufNew,BufNewFile,BufRead *.ejs :set filetype=html
augroup end
" ----------------------------------------------------------------------------------
" Ctrlp settings
" ----------------------------------------------------------------------------------
let ctrlp_working_path_mode='r'

set wildignore+=*/tmp/*,*/target/*,*.so,*.swp,*.zip      " MacOSX/Linux
set wildignore+=*\\tmp\\*,*\\target\\*,*.swp,*.zip,*.exe,*.dll " Windows

let g:ctrlp_follow_symlinks=1
let g:ctrlp_cmd='CtrlPRoot'
let g:ctrlp_use_caching=0

let g:ctrlp_custom_ignore={
  \ 'dir':  '\v[\/](\.(git|hg|svn|target))|(build)|(node_modules)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" ----------------------------------------------------------------------------------
" NERDTree configurations
" ----------------------------------------------------------------------------------
nmap <F6> :NERDTreeToggle<CR>
imap <F6> <ESC>:NERDTreeToggle<CR>

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
let g:ycm_auto_trigger=0
map gt :YcmCompleter GoTo<CR>

if !has_key( g:, 'ycm_language_server' )
  let g:ycm_language_server = []
endif

function! RenameVariable()
    let name = input("New name: ")

    let command = "YcmCompleter RefactorRename " . name
    exe command
endfunction

nmap <S-F6> <Cmd>call RenameVariable()<CR>
imap <S-F6> <Esc><Cmd>call RenameVariable()<CR>

" ----------------------------------------------------------------------------------
" Dispatch
" ----------------------------------------------------------------------------------
let g:dispatch_no_maps = 1
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
"
augroup rust
    au!
    autocmd FileType rust let b:dispatch = "cargo build"
    " let g:rustfmt_autosave=1
    autocmd FileType rust inoremap <buffer> <C-F9> <ESC>:update<bar>Dispatch cargo build<CR>
    autocmd FileType rust nnoremap <buffer> <C-F9> :update<bar>Dispatch cargo build<CR>

    autocmd FileType rust inoremap <buffer> <F10> <ESC>:update<bar>Dispatch cargo run<CR>
    autocmd FileType rust inoremap <buffer> <S-F10> <ESC>:update<bar>Dispatch cargo run --release<CR>
    autocmd FileType rust nnoremap <buffer> <F10> :update<bar>Dispatch cargo run<CR>
    autocmd FileType rust nnoremap <buffer> <S-F10> :update<bar>Dispatch cargo run --release<CR>
augroup end

" Haskell
let g:haskellmode_completion_ghc=0

" neco-ghc
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:necoghc_enable_detailed_browse=1

" Godot/Gdscript
let g:ycm_language_server += [
  \   {
  \     'name': 'godot',
  \     'filetypes': [ 'gdscript' ],
  \     'project_root_files': [ 'project.godot' ],
  \     'port': 6008
  \   }
  \ ]

func! GodotSettings() abort
    setlocal tabstop=4
    nnoremap <buffer> <F4> :GodotRunLast<CR>
    nnoremap <buffer> <F5> :GodotRun<CR>
    nnoremap <buffer> <F6> :GodotRunCurrent<CR>
    nnoremap <buffer> <F7> :GodotRunFZF<CR>
endfunc
augroup godot | au!
    au FileType gdscript call GodotSettings()
augroup end

" ----------------------------------------------------------------------------------
" Shortcuts
" ----------------------------------------------------------------------------------
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

vnoremap p pgvy

nnoremap <Leader>s :vsplit $NVIMRC
" nnoremap <Leader>w :w<CR>

" nnoremap <Leader>i <C-i>
" nnoremap <Leader>o <C-o>

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

:command W  w
:command Wq wq
:command WQ wq
:command Q  q

" nnoremap <Tab> <Esc>
" vnoremap <Tab> <Esc>gV
" onoremap <Tab> <Esc>
" inoremap <Tab> <Esc>`^
" inoremap <Leader><Tab> <Tab>

inoremap <C-CR> <Esc>O

inoremap <C-d> <Esc>m`yyp``<Down>a
nnoremap <C-d> m`yyp``<Down>

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

nnoremap <F7>   :cn<CR>
nnoremap <S-F7> :cp<CR>

command -nargs=+ Ack execute "silent! grep! <args> | botright copen"

command TODO execute "Ack TODO"

" Grep
if executable("rg")
    set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
    set grepformat=%f:%l:%c:%m

    let g:ctrlp_user_command = 'rg -g "!{target,build,node_modules}"  %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
endif

" ----------------------------------------------------------------------------------
" Statusline
" ----------------------------------------------------------------------------------
let g:currentmode={
       \ 'n'  : 'NORMAL',
       \ 'v'  : 'VISUAL',
       \ 'V'  : 'V·Line',
       \ "\<C-V>" : 'V·Block',
       \ 'i'  : 'INSERT',
       \ 'R'  : 'R',
       \ 'Rv' : 'V·Replace',
       \ 'c'  : 'Command',
       \}

set statusline=
set statusline+=\ [%{toupper(g:currentmode[mode()])}]
set statusline+=\ (%l,\ %c)
set statusline+=\ %f%m\ %y
set statusline+=\ [%L\ lines]

" ----------------------------------------------------------------------------------
" Statusline
" ----------------------------------------------------------------------------------
" Navegar as abas com Alt+{num}

nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-6> 6gt

inoremap <A-1> <esc>1gt
inoremap <A-2> <esc>2gt
inoremap <A-2> <esc>2gt
inoremap <A-3> <esc>3gt
inoremap <A-4> <esc>4gt
inoremap <A-5> <esc>5gt
inoremap <A-6> <esc>6gt
inoremap <A-7> <esc>7gt
inoremap <A-6> <esc>6gt

vnoremap <A-1> 1gt
vnoremap <A-2> 2gt
vnoremap <A-2> 2gt
vnoremap <A-3> 3gt
vnoremap <A-4> 4gt
vnoremap <A-5> 5gt
vnoremap <A-6> 6gt
vnoremap <A-7> 7gt
vnoremap <A-6> 6gt
