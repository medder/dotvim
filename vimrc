
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif


" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

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

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=100

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
let mapleader = "\\"
let g:mapleader = "\\"


" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

set fileencodings=usc-bom,utf-8,gb18030,gbk,gb2312,latin1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set bg=dark

set nu  " line number

set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"Turn on WiLd menu
"set wildmenu 

set clipboard+=unnamed
set scrolloff=6

set wildignore+=*.pyc,*~,*orig

"The commandbar height
"set cmdheight=2 

" foldmethod
set fdm=indent
set fen

" grep 
set grepprg=grep\ -nHr\ $*

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set smartindent

set expandtab
set shiftwidth=4
set softtabstop=4
set smarttab

" Automatically remove trailing whitespace
autocmd FileType c,cpp,java,php,python autocmd BufWritePre <buffer> :%s/\s\+$//e

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Smart way to move around
map <up> 5k
map <down> 5j

map <right> 3w
map <left> 3b

map <leader>n :bn<cr>
map <leader>p :bp<cr>

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

map <F2> :nohlsearch<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xtstp <c-r>=strftime("%H:%M:%S %y-%m-%d")<cr>

iab #i	#include
iab #d	#define

iab /b /******************************************************
iab ;e <ESC>S*****************************************************/<CR>
iab #m int main( void)<CR>{<CR>return 0;<CR>}<CR><ESC>3ka
iab @m int main( int argc, char* argv[] )<CR>{<CR>return 0;<CR>}<CR><ESC>3ka

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Bundle configure 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" alternatively, pass a path where Vundle should install bundles
" let path = '~/some/path/here'
" call vundle#rc(path)

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tags, taglist and omnicppcomplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'taglist.vim'
Bundle 'OmniCppComplete'

map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

nnoremap <silent> <F9> :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 42
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1


let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_DefaultNamespaces = [ "std" ]

" automatically open and close the popup menu / preview window 
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
au InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,menuone,longest,preview

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'The-NERD-Tree'
map <F4> :NERDTreeToggle<cr>
let NERDTreeIgnore=['\~$','\.pyc$']
let NERDTreeShowBookmarks=1
let NERDTreeWinSize=26

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  a.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'a.vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  snipMate.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'snipMate'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  emmet-vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'mattn/emmet-vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  fix indenting issue of html.vim in 7.4
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://stackoverflow.com/questions/19323607/html-indenting-not-working-in-compiled-vim-7-4-any-ideas
let g:html_indent_inctags = "body,head,tbody"
let g:html_indent_autotags = ""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  ctrlp.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'kien/ctrlp.vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  vim-flake8
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" flake8 need, to install: `pip install flake8 `
Bundle 'nvie/vim-flake8'
let g:flake8_show_in_gutter=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  rust.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'rust-lang/rust.vim'
" temporary solve the issue: 
" https://github.com/rust-lang/rust.vim/issues/10
au BufRead,BufNewFile *.rs set filetype=rust
