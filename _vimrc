"===============================================================================
" Pathogen
"===============================================================================
call pathogen#infect()
call pathogen#helptags()

"===============================================================================
" relocating swap files
"===============================================================================
set backupdir=C:\workspace\vim

"===============================================================================
" ...so that fugitive works
"===============================================================================
set directory+=,~/tmp,$TMP

"===============================================================================
" complete file path while typing
"===============================================================================
set wildmode=longest,list,full
set wildmenu



"===============================================================================
" Autocompletion
"===============================================================================
filetype plugin on
set ofu=syntaxcomplete#Complete

"===============================================================================
" Enable the installation of vimballs (vba files)
"===============================================================================
" call vimball#Vimball("%:p:h")

"===============================================================================
" Code Folding
"===============================================================================
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END



"===============================================================================
" Automatically closes brakets
" Taken from: http://vim.wikia.com/wiki/Automatically_append_closing_characters
"===============================================================================
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

" Incomplete example moving the cursor after insertion.
" DO NOT USE, use a plugin instead.
function! MoveLeft()
  let newpos = getpos('.')
  let newpos[2] -= 1
  if (newpos[2] < 1)
    let newpos[2] = 1
  endif
  call setpos('.', newpos)
  return ""
endfunction
inoremap ( ()<C-R>=MoveLeft()<CR>


"===============================================================================
" Tab characters
"===============================================================================
:set tabstop=2
:set shiftwidth=2
:set expandtab

nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

"===============================================================================
" navigate buffers
"===============================================================================
:nnoremap <C-n> :bnext<CR>
:nnoremap <C-p> :bprevious<CR>


"===============================================================================
" Return characters in normal mode 
"===============================================================================
map <S-Enter> O<Esc>
map <CR> o<Esc>


"===============================================================================
"===============================================================================
set nocompatible
syntax enable
filetype plugin on
filetype indent on

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set hidden


"===============================================================================
"===============================================================================
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv


"===============================================================================
" colorscheme
"===============================================================================
syntax enable
set background=dark
colorscheme solarized

"colorscheme xoria256 
"colorscheme inkpot
call togglebg#map("<F6>")


let mapleader = ","

"===============================================================================
" show row numbers
"===============================================================================
:set number



"===============================================================================
" VimOutliner
"===============================================================================
filetype plugin indent on
syntax on
runtime! ftdetect\*.vim



"===============================================================================
" Swap words
"===============================================================================
:nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>
" This version will work across newlines:
:nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>



"===============================================================================
" Macro for date insertion
"===============================================================================
"noremap <A-d> strftime("%m/%d/%y")
"
:nnoremap <F5> "=strftime("%m/%d/%y")<CR>P
:inoremap <F5> <C-R>=strftime("%m/%d/%y")<CR>

:inoremap <A-3> #' 
:nnoremap <A-3> i#' <Esc>

"===============================================================================
" auto wraping text
"===============================================================================
set formatoptions-=tcqro

" http://www.derekwyatt.org/vim/the-vimrc-file/
set textwidth=70


" Increase history of executed commands (:).
set history=1000

" Increase number of possible undos.
set undolevels=1000


set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction


function! VO2MD()
  let lines = []
  let was_body = 0
  for line in getline(1,'$')
    if line =~ '^\t*[^:\t]'
      let indent_level = len(matchstr(line, '^\t*'))
      if was_body " <= remove this line to have body lines separated
        call add(lines, '')
      endif " <= remove this line to have body lines separated
      call add(lines, substitute(line, '^\(\t*\)\([^:\t].*\)', '\=repeat("#", indent_level + 1)." ".submatch(2)', ''))
      call add(lines, '')
      let was_body = 0
    else
      call add(lines, substitute(line, '^\t*: ', '', ''))
      let was_body = 1
    endif
  endfor
  silent %d _
  call setline(1, lines)
endfunction

function! MD2VO()
  let lines = []
  for line in getline(1,'$')
    if line =~ '^\s*$'
      continue
    endif
    if line =~ '^#\+'
      let indent_level = len(matchstr(line, '^#\+')) - 1
      call add(lines, substitute(line, '^#\(#*\) ', repeat("\<Tab>", indent_level), ''))
    else
      call add(lines, substitute(line, '^', repeat("\<Tab>", indent_level) . ': ', ''))
    endif
  endfor
  silent %d _
  call setline(1, lines)
endfunction
