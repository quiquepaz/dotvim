set tabstop=4				 " Set tabstops to 4 spaces
set expandtab
set shiftwidth=4			 " Set indentation shift-width to 4 spaces
set autoindent				 " Enable automatic indentation
set laststatus=2			 " Always show a status line
set showcmd					 " Show commands as they are typed
set formatoptions+=cqron1 	 " Some useful formatting options
set showmatch				 " Show matching parens
set textwidth=80

call pathogen#infect()
call pathogen#helptags()

syntax on

if has ("autocmd")
    filetype plugin indent on
    au BufRead,BufNewFile *.ml,*.mli compiler ocaml
end

" Color settings
colorscheme ron
highlight Pmenu ctermbg=grey gui=bold
highlight PmenuSel ctermbg=green gui=bold

" Color long lines
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Highlight tabs and trailing spaces
set list
set listchars=tab:\ \ ,trail:»

" on cmd, 1 tab longest possible completion, 2 shows available list, 3 and
" subsequent cycle through that list
set wildmode=longest,list,full
" wildmenu in the command menu (only for 'full')
set wildmenu
" Ignore backups and misc files for wilcompletion
set wildignore=*.o,*.cm[ioax],*.ppu,*.core,*~,core,#*#

" Navigating completion menu with j and k
inoremap <expr> j pumvisible() ? "\<C-N>" : "j"
inoremap <expr> k pumvisible() ? "\<C-P>" : "k"

" Clear trailing whitespaces on save
fun! <SID>StripTrailingWhitespaces()
    let save_cursor = getpos(".")
    :silent! %s/\s\+$//e
    :silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', save_cursor)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" <C-u> -> Toggle numbers
map  <C-u>   :set nu!<CR>
imap <C-u>   <ESC>:set nu!<CR>i

" Autocorrect some usually-mispelled commands
command! -nargs=0 -bang Q q<bang>
command! -bang W write<bang>
command! -nargs=0 -bang Wq wq<bang>

" Allow use of :SW to write a file as sudo
command SW w !sudo tee % > /dev/null

set backupdir=./.vimbackup,~/.vimbackup,.,/tmp

set incsearch

" Limit words with an underscore character
"set iskeyword-=_

" CTags

function CreateTags()
    exec ':!ctags -R'
endfunction
map <LocalLeader>t :call CreateTags()<CR>

let maplocalleader = "\\"

" NERDTree
map <C-b> :NERDTreeToggle<CR>

" Ocaml
"     Indentation via ocp-indent
autocmd FileType ocaml source /home/enrique/.opam/4.01.0/share/vim/syntax/ocp-indent.vim
"     Merlin stuff
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
execute "set rtp+=" . g:opamshare . "/merlin/vimbufsync"
let g:syntastic_ocaml_checkers = ['merlin']
function! OCamlType()
    let col  = col('.')
    let line = line('.')
    let file = expand("%:p:r")
    echo system("annot -n -type ".line." ".col." ".file.".annot")
endfunction
map ,t :call OCamlType()<return>

" Erlang
"     txt snippets
function! ErlangAuthor()
    r~/.vim/templates/erlang/author.txt
endfunction
command! -nargs=0 Eauthor call ErlangAuthor()

function! ErlangFunctionEdoc()
    r~/.vim/templates/erlang/function_edoc.txt
endfunction
command! -nargs=0 Efunedoc call ErlangFunctionEdoc()

function! ErlangQuickcheckModule()
    r~/.vim/templates/erlang/quickcheckmodule.txt
endfunction
command! -nargs=0 Equickcheckmodule call ErlangQuickcheckModule()

function! ErlangEunitModule()
    r~/.vim/templates/erlang/eunitmodule.txt
endfunction
command! -nargs=0 Eeunit call ErlangEunitModule()

" LaTeX & Beamer
"     txt snippets
function! BeamerFrame()
    r~/.vim/templates/latex/frame.txt
endfunction
command! -nargs=0 Lframe call BeamerFrame()

function! LatexItemize()
    r~/.vim/templates/latex/itemize.txt
endfunction
command! -nargs=0 Litem call LatexItemize()
