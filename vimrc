set tabstop=4				 " Set tabstops to 4 spaces
set expandtab
set shiftwidth=4			 " Set indentation shift-width to 4 spaces
set autoindent				 " Enable automatic indentation
set copyindent				 " Enable automatic indentation of pasted lines
set laststatus=2			 " Always show a status line
set showfulltag				 " Show full prototype of tags on completion
set showcmd					 " Show commands as they are typed
set formatoptions+=cqron1 	 " Some useful formatting options
set showmatch				 " Show matching parens

let g:username = "Enrique Paz Pérez"
let g:author = "Enrique Paz Pérez"
let g:email  = "quiquepaz@gmail.com"

call pathogen#infect()
call pathogen#helptags()

" wildmenu in the command menu
set wildmenu           	 " Show completions on menu over cmdline
set wildchar=<TAB>     	 " Navigate wildmenu with tabs
" Ignore backups and misc files for wilcompletion
set wildignore=*.o,*.cm[ioax],*.ppu,*.core,*~,core,#*#

syntax on
colorscheme elflord

" Functions and Commands   }}}1{{{1
" Autocorrect some usually-mispelled commands
command! -nargs=0 -bang Q q<bang>
command! -bang W write<bang>
command! -nargs=0 -bang Wq wq<bang>

" Some commands used to thrash trailing garbage in lines.
command -nargs=0 KillEolLF      :execute("%s/\\r$//")
command -nargs=0 KillEolSpaces  :execute("%s/[ \\t]\\+$//")
command -nargs=0 KillEolGarbage :execute("%s/[ \\t\\r]\\+$//")

" <C-p> -> Toggle paste
map  <C-p>   :set paste!<CR>
imap <C-p>   <ESC>:set paste!<CR>i

" <C-p> -> Toggle numbers
map  <C-n>   :set nu!<CR>
imap <C-n>   <ESC>:set nu!<CR>i

set list
set listchars=tab:\ \ ,trail:»,extends:↷,precedes:↶
"set listchars=eol:•,tab:↦\ ,trail:»,extends:↷,precedes:↶

" Allow use of w!! to write a file as sudo
" cmap w!! %!sudo tee > /dev/null %
command SW w !sudo tee % > /dev/null

set backupdir=./.vimbackup,~/.vimbackup,.,/tmp

" Erlang txt snippets
function! ErlangAuthor()
    r~/.vim/templates/erlang/author.txt
endfunction
command! -nargs=0 Eauthor call ErlangAuthor()

function! ErlangFunctionEdoc()
    r~/.vim/templates/erlang/function_edoc.txt
endfunction
command! -nargs=0 Efunedoc call ErlangFunctionEdoc()

function! ErlangGenServer()
    r~/.vim/templates/erlang/gen_server.txt
endfunction
command! -nargs=0 Egenserver call ErlangGenServer()

function! ErlangSupervisor()
    r~/.vim/templates/erlang/supervisor.txt
endfunction
command! -nargs=0 Esupervisor call ErlangSupervisor()

function! ErlangApplication()
    r~/.vim/templates/erlang/application.txt
endfunction
command! -nargs=0 Eapplication call ErlangApplication()

function! ErlangDotApp()
    r~/.vim/templates/erlang/dotapp.txt
endfunction
command! -nargs=0 Edotapp call ErlangDotApp()

function! ErlangQuickcheckModule()
    r~/.vim/templates/erlang/quickcheckmodule.txt
endfunction
command! -nargs=0 Equickcheckmodule call ErlangQuickcheckModule()


