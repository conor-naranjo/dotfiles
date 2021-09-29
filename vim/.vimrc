" Use spaces instead of tabs
filetype plugin indent on

" set syntax on and enable a simple color-scheme
syntax on
color basic
set number " Turns on line numbering
"set relativenumber " Relative line numbering

" Sets a text-width of 80 chars and will wrap lines longer than 80 chars
set tw=80
set fo+=t

" Allow backspace to delete indentation and inserted text
" i.e. how most programs work
set backspace=indent,eol,start
" indent  allow backspacing over autoindent
" eol     allow backspacing over linebreaks
" start   allow backspacing over the start of insert; Ctrl-W and Ctrl-U
" "      stop once at the start of insert


" For html, ruby, css files; 2 space tab
autocmd FileType html setlocal ts=2 sw=2 expandtab
autocmd FileType javascript setlocal ts=2 sw=2 expandtab
autocmd FileType rb setlocal ts=2 sw=2 expandtab
autocmd FileType css setlocal ts=2 sw=2 expandtab
autocmd FileType sql setlocal ts=2 sw=2 expandtab
autocmd FileType yaml setlocal ts=2 sw=2 expandtab

" For Java, Python, Lisp; 4 space tab
autocmd FileType java setlocal ts=4 sw=4 expandtab
autocmd FileType lisp setlocal ts=4 sw=4 expandtab
autocmd FileType py setlocal ts=4 sw=4 expandtab

" For C/H files we want 8 space tab-width, but not 8 spaces.
autocmd FileType c setlocal ts=8 sw=8
autocmd FileType h setlocal ts=8 sw=8 
"For C / CPP files make switch and case line up
au FileType c,cpp setl cindent cinoptions+=:0

" For Golang, load the vim-go plugin
autocmd! FileType go packadd vim-go

" Elixir support
au BufRead,BufNewFile *.ex,*.exs,*.heex,*.leex,*.sface set filetype=elixir
au BufRead,BufNewFile *.eex set filetype=eelixir
autocmd! FileType elixir packadd vim-elixir
autocmd! FileType eelixir packadd vim-elixir


""" PYTHON Specific Settings
" PEP 7 & 8 compliance
au BufRead,BufNewFile *.py,*.pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab

" Hightlights trailing whitespace
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after 79 characters (Django allows for 119 chars)
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=79
""" END PYTHON SETTINGS


" Display filename
set laststatus=2

" Use UTF-8
set encoding=utf-8
set fileencoding=utf-8

" Make any line over 81 chars long stand out
highlight ColorColumn ctermbg=green
call matchadd('ColorColumn', '\%81v', 100)

" Highlight the current working line
set cursorline

" Force swap files to go somewhere else >:[
"set directory^=$HOME/.vim/tmp//

" Enable code folding
set foldmethod=indent
set foldlevel=99

" Use spacebar to fold code
nnoremap <space> za
