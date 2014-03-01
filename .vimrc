" Never hit escape again!
imap jk <Esc>:w<CR>

" Make sure I can spell
" set spell spelllang=en_us

" Go hard or go hom
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" Bye, bye arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Check that syntax
execute pathogen#infect()
" Syntastic on by default
let g:syntastic_mode_map = { 'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': [] }

" Check it on startup
let g:syntastic_check_on_open = 1
" Don't check syntax when you quit fool
let g:syntastic_check_on_wq = 0
" Got them pretty symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" Checkers
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_json_checkers=['jsonlint']

"Ctrl-p Stuff
set runtimepath^=~/.vim/bundle/ctrlp.vim
:helptags ~/.vim/bundle/ctrlp.vim/doc
let g:ctrlp_working_path_mode = 2          " CtrlP: use the nearest ancestor that contains one of these directories or files: .git/ .hg/ .svn/ .bzr/ _darcs/
set wildignore+=*/tmp/*,*.so,*.swp,*.zip   " MacOSX/Linux
" set wildignore+=tmp\*,*.swp,*.zip,*.exe    " Windows
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|node_modules',
    \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\|\.DS_Store',
    \ 'link': 'some_bad_symbolic_links',
    \ }
let g:ctrlp_extensions = [
   \ 'ctrlp-filetpe',
   \ ]
let g:ctrlp_follow_symlinks = 1

" Syntax Highlighting
syntax on

" Easy viewing of multiple files? Why not!
set hidden

" Line Numbers
set number

" What column am I in?
set ruler

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

"inoremap <tab> <c-r>=Smart_TabComplete()<CR>

" Enable mouse support in console (Has issues with git)
"set mouse=a

" Highlight things found with search
set hlsearch
set incsearch

" Why make search case sensitive?
set ignorecase

" Highlight current line
set cursorline

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Who wants an 8 character tab?  Not me!
set shiftwidth=4
set softtabstop=4

" Who doesn't like auto-indent?
set autoindent
set copyindent

" Spaces are better than a tab character
set expandtab
set smarttab

" This shows what you are typing as a command.
set showcmd

" Show that filename in that bottom
set ls=2

" Set that backspace to work
set backspace=indent,eol,start

" Why backup when you can git?
set nobackup
set noswapfile

" Die annoying beep die!!!
set visualbell
set noerrorbells

" Get them 80 columns (Vim 7.3 and above)
set colorcolumn=100
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/
