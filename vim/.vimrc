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
au filetype go inoremap <buffer> . .<C-x><C-o>

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

" Set Color Scheme for TypeScript/TypeScriptReact files
autocmd! BufEnter,BufNewFile *.ts set background=dark
autocmd! BufEnter,BufNewFile *.ts color PaperColor
autocmd! BufLeave *.ts color basic

autocmd! BufEnter,BufNewFile *.tsx set background=dark
autocmd! BufEnter,BufNewFile *.tsx color PaperColor
autocmd! BufLeave *.tsx color basic

" Display filename
" set laststatus=2

" Use UTF-8
set encoding=utf-8
set fileencoding=utf-8

" Make any line over 81 chars long stand out
highlight ColorColumn ctermbg=green ctermfg=black
call matchadd('ColorColumn', '\%81v', 100)

" Highlight the current working line
set cursorline

" Enable code folding
set foldmethod=syntax
" set foldmethod=indent
" set foldlevel=99

" Use spacebar to fold code
" nnoremap <space> za
"


" Display Tab Number on the tabline
fu! MyTabLabel(n)
let buflist = tabpagebuflist(a:n)
let winnr = tabpagewinnr(a:n)
let string = fnamemodify(bufname(buflist[winnr - 1]), ':t')
return empty(string) ? '[unnamed]' : string
endfu

fu! MyTabLine()
let s = ''
for i in range(tabpagenr('$'))
" select the highlighting
    if i + 1 == tabpagenr()
    let s .= '%#TabLineSel#'
    else
    let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    "let s .= '%' . (i + 1) . 'T'
    " display tabnumber (for use with <count>gt, etc)
    let s .= ' '. (i+1) . ' ' 

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '

    if i+1 < tabpagenr('$')
        let s .= ' |'
    endif
endfor
return s
endfu
set tabline=%!MyTabLine()

" Remap a leader to quickly go to a specific tab
noremap <space>1 1gt
noremap <space>2 2gt
noremap <space>3 3gt
noremap <space>4 4gt
noremap <space>5 5gt
noremap <space>6 6gt
noremap <space>7 7gt
noremap <space>8 8gt
noremap <space>9 9gt
noremap <space>0 :tablast<cr>

" Pretty-Print / Collapse JSON while in visual mode
" Requires jq to be installed
vnoremap <C-j> :%!jq .<CR>
vnoremap <C-k> :%!jq -c .<CR>

" Execute Shell Command and Output in New Buffer
let s:lastcmd = ''
function! s:RunShellCommand(cmdline, bang)
    " Support for repeating last cmd with bang:
    let _ = a:bang != '' ? s:lastcmd : a:cmdline == '' ? '' : join(map(split(a:cmdline), 'expand(v:val)'))

    if _ == ''
        return
    endif

    let s:lastcmd = _
    let bufnr = bufnr('%')
    let winnr = bufwinnr(_)
    " You can position the new window whenever you want, I chose below + right:
    silent! execute  winnr < 0 ? 'tabnew ' . fnameescape(_) : winnr . 'wincmd w'
    " I could set buftype=nofile, but then no switching back and forth buffers.
    " The results are presented just for viewing, not editing, modify at will:
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile wrap number

    setlocal modifiable
    silent! :%d
    " Useful for debugging, if you encounter issues with fnameescape():
    call setline(1, 'You entered:  ' . a:cmdline)
    call setline(2, 'Expanded to:  ' . _)
    call append(line('$'), substitute(getline(2), '.', '=', 'g'))

    silent execute '$read !' . _
    silent! execute 'autocmd BufUnload <buffer> execute bufwinnr(' . bufnr . ') . ''wincmd w'''
    " If resizing is unwanted for commands with too much output, remove this line:
    silent! execute 'autocmd BufEnter  <buffer> execute ''resize '' .  line(''$'')'
    " You can use <localleader>r to re-execute the last command:
    silent! execute 'nnoremap <silent> <buffer> <localleader>r :call <SID>RunShellCommand(''' . _ . ''', '''')<CR>'

    execute 'resize ' . line('$')

    setlocal nomodifiable
    1
endfunction " RunShellCommand(cmdline)
command! -complete=shellcmd -nargs=* -bang Shell call s:RunShellCommand(<q-args>, '<bang>')

" Custom Statusline
" https://gabri.me/blog/diy-vim-statusline
" https://elianiva.my.id/post/vim-statusline/
" https://shapeshed.com/vim-statuslines/
"
set laststatus=2
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%#GitColor#%{StatuslineGit()}
set statusline+=%#LineNr#
" set statusline+=%#StatusColor#
set statusline+=\ %f
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=%m
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ %{strftime('%T')}
set statusline+=\ 

" https://vim.fandom.com/wiki/Xterm256_color_names_for_console_Vim
hi GitColor guifg=Green guibg=Black ctermbg=16 ctermfg=34
hi StatusColor guifg=White guibg=Black ctermbg=0 ctermfg=231
