"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Environment 

" This must be first, because it changes other options as a side effect.
set nocompatible

scriptencoding utf-8
filetype plugin indent on   " Automatically detect file types.
syntax on                   " Syntax highlighting

set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing

if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General

set autoread
set backup
set history=1000
set fileencodings=usc-bom,utf-8,gb18030,gbk,gb2312,latin1
set virtualedit=onemore


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" utils

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM UI

set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode

set cursorline                  " Highlight current line

highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode
"highlight clear CursorLineNr    " Remove highlight color from current line number

if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
                                " Selected characters/lines in visual mode
endif

if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code
set foldmethod=indent

set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace


set bg=dark




" grep 
set grepprg=grep\ -nHr\ $*

set wildignore+=*.pyc,*~,*orig
set suffixesadd+=.rst,.md

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Formatting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nowrap
set autoindent
set smartindent

set expandtab
set shiftwidth=4
set softtabstop=4
set smarttab

set splitright
set splitbelow

autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2


" Automatically remove trailing whitespace
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> :%s/\s\+$//e

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key (re)Mappings

let mapleader = ","

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" move btw. buffers
map <leader>bn :bn<cr>
map <leader>bp :bp<cr>

" move btw. tabs
map <leader>tt :tabnew<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tc :tabclose<cr>
map <leader>te :tabedit
map <leader>tm :tabmove
map <leader>tw :tabclose<cr>

" Change Working Directory to that of the current file
map <leader>cd :cd %:p:h<cr>

" tiggle search highlighting
nmap <leader>/ :nohlsearch<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Easier horizontal scrolling
map zl zL
map zh zH


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins

" Bundle
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'


" => Taglist
Bundle 'taglist.vim'

nnoremap <leader>tl :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 42
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1


" => omnicppcomplete
Bundle 'OmniCppComplete'

map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_DefaultNamespaces = [ "std" ]

" automatically open and close the popup menu / preview window 
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
au InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,menuone,longest,preview


" =>  NERDTree
Bundle 'scrooloose/nerdtree'

map <leader>e :NERDTreeToggle<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

" =>  a.vim
Bundle 'a.vim'

" =>  snipMate.vim
Bundle 'snipMate'

" =>  emmet-vim
Bundle 'mattn/emmet-vim'

" =>  fix indenting issue of html.vim in 7.4
" http://stackoverflow.com/questions/19323607/html-indenting-not-working-in-compiled-vim-7-4-any-ideas
let g:html_indent_inctags = "body,head,tbody"
let g:html_indent_autotags = ""

" =>  ctrlp.vim
Bundle 'ctrlpvim/ctrlp.vim'

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }


" =>  vim-flake8
" flake8 need, to install: `pip install flake8 `
Bundle 'nvie/vim-flake8'
let g:flake8_show_in_gutter=1

" =>  rust.vim
Bundle 'rust-lang/rust.vim'
" temporary solve the issue: 
" https://github.com/rust-lang/rust.vim/issues/10
au BufRead,BufNewFile *.rs set filetype=rust


" => undotree
Bundle 'mbbill/undotree'

nnoremap <Leader>u :UndotreeToggle<CR>
" If undotree is opened, it is likely one wants to interact with it.
let g:undotree_SetFocusWhenToggle=1
