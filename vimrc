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
colorscheme ron

highlight Pmenu ctermbg=grey gui=bold
highlight PmenuSel ctermbg=green gui=bold

if has ("autocmd")
    filetype plugin indent on
    au BufRead,BufNewFile *.ml,*.mli compiler ocaml
end

" on cmd, 1 tab longest possible completion, 2 shows available list, 3 and
" subsequent cycle through that list
set wildmode=longest,list,full
" wildmenu in the command menu (only for 'full')
set wildmenu
" Ignore backups and misc files for wilcompletion
set wildignore=*.o,*.cm[ioax],*.ppu,*.core,*~,core,#*#

" Wrangler stuff for Erlang
let g:erlangRefactoring = 1
let g:erlangWranglerPath = '/var/local/scratch/wrangler'

" Navigating completion menu with j and k
inoremap <expr> j pumvisible() ? "\<C-N>" : "j"
inoremap <expr> k pumvisible() ? "\<C-P>" : "k"

" Clear trailing whitespaces on save

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Merlin stuff for ocaml
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
execute "set rtp+=" . g:opamshare . "/merlin/vimbufsync"
let g:syntastic_ocaml_checkers = ['merlin']

" Ocaml indentation via ocp-indent
autocmd FileType ocaml source /home/enrique/.opam/4.01.0/share/vim/syntax/ocp-indent.vim

" Functions and Commands   }}}1{{{1
" Autocorrect some usually-mispelled commands
command! -nargs=0 -bang Q q<bang>
command! -bang W write<bang>
command! -nargs=0 -bang Wq wq<bang>

let maplocalleader = "\\"

" <C-p> -> Toggle numbers
map  <C-u>   :set nu!<CR>
imap <C-u>   <ESC>:set nu!<CR>i

" <C-n> -> Next buffer
map  <C-n>   :bn<CR>
" <C-b> -> Previous buffer
map  <C-b>   :bp<CR>

" set list
" set listchars=tab:\ \ ,trail:»,extends:↷,precedes:↶

"map ,t :CommandT<CR>
"imap ,,, <esc>bdwi<<esc>pa><cr></<esc>pa><esc>k2>>

" Allow use of :SW to write a file as sudo
command SW w !sudo tee % > /dev/null

set backupdir=./.vimbackup,~/.vimbackup,.,/tmp

nnoremap <silent> <C-t>e :CommandT<CR>
nnoremap <silent> <C-t>b :CommandTBuffer<CR>

set incsearch

"Limit words with an underscore character
"set iskeyword-=_

"Color long lines
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/


" Erlang txt snippets
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

" LaTeX and beamer txt snippets
function! BeamerFrame()
    r~/.vim/templates/latex/frame.txt
endfunction
command! -nargs=0 Lframe call BeamerFrame()

function! LatexItemize()
    r~/.vim/templates/latex/itemize.txt
endfunction
command! -nargs=0 Litem call LatexItemize()

function! OCamlType()
    let col  = col('.')
    let line = line('.')
    let file = expand("%:p:r")
    echo system("annot -n -type ".line." ".col." ".file.".annot")
endfunction    
map ,t :call OCamlType()<return>

