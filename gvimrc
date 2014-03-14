
set mousehide		" Hide the mouse when typing text

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>


" highlighting strings inside C comments
let c_comment_strings=1

if !exists("syntax_on")
    syntax on
endif

" Switch on search pattern highlighting.
set hlsearch

" For Win32 version, have "K" lookup the keyword in a help file
"if has("win32")
"  let winhelpfile='windows.hlp'
"  map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
"endif

" Set nice colors
" background for normal text is light grey
" Text below the last line is darker grey
" Cursor is green, Cyan when ":lmap" mappings are active
" Constants are not underlined but have a slightly lighter background
"highlight Normal guibg=grey90
"highlight Cursor guibg=Green guifg=NONE
"highlight lCursor guibg=Cyan guifg=NONE
"highlight NonText guibg=grey80
"highlight Constant gui=NONE guibg=grey95
"highlight Special gui=NONE guibg=grey95
color desert


" no toolbar and menu
set guioptions-=T
set guioptions-=m

set nobackup


" lines & columns
set lines=40
set columns=110

" font setting
"set guifont=Liberation\ Mono\ 11
set guifont=WenQuanYi\ Micro\ Hei\ Mono\ 10

