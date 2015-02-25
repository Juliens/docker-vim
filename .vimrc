
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

Bundle "brookhong/DBGPavim"
 
Bundle 'tpope/vim-fugitive'
" Syntaxt checks
Bundle 'scrooloose/syntastic'

" Rewrap argument lists
Bundle 'jakobwesthoff/argumentrewrap'

" command-t
Bundle 'git://git.wincent.com/command-t.git'

Bundle 'Align'

Bundle 'SQLUtilities'

Bundle 'Gundo'

Bundle "pangloss/vim-javascript"

Bundle "https://github.com/docteurklein/vim-symfony.git"

Bundle "https://github.com/arnaud-lb/vim-php-namespace.git"

Bundle "https://github.com/aklt/plantuml-syntax"

Bundle "https://github.com/terryma/vim-multiple-cursors"

Bundle "https://github.com/tpope/vim-surround.git"

Bundle "Tagbar"

Bundle "mileszs/ack.vim"

Bundle "php-cs-fixer"
Bundle "tokutake/twig-indent"
Bundle "evidens/vim-twig"

Bundle 'derekwyatt/vim-scala'
Bundle 'craigemery/vim-autotag'

Bundle 'Juliens/vim-php-refactor.git'

Bundle 'sukima/xmledit'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/unite.vim'
"Bundle 'm2mdas/phpcomplete-extended'

filetype plugin indent on     " required!
runtime macros/matchit.vim
"autocmd  FileType  php setlocal omnifunc=phpcomplete_extended#CompletePHP

" Set numbers, sort casing, tabstops and such
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set nocompatible
set nopaste
set hidden
set nowrap
set hlsearch

" Be case insensitive in searches
set ignorecase
" If upper case letters occur, be case insensitive
set smartcase
" Infer the current case in insert completion
set infercase


set encoding=utf-8

" Automatic indention and such around expressions/brackets
set indentexpr=
set smartindent

" Do not highlight search results
" set nohlsearch

" Jump 5 lines when running out of the screen
set scrolljump=5
" Indicate jump out of the screen when 3 lines before end of the screen
set scrolloff=3

" Set the autocomplete style for files
"set wildmode=list:longest
set wildmenu
set wildmode=full

" Cursor line in insert mode
autocmd InsertLeave * set nocursorline
autocmd InsertEnter * set cursorline

" Deactivate visual bell
set visualbell
set t_vb=
set ttyfast

syntax enable
" let g:solarized_termcolors=256
" colorscheme solarized

filetype plugin on
filetype indent on

" Restore line number and column if reentering a file after having edited it
" at least once. For this to work .viminfo in the home dir has to be writable by the user.
let g:restore_position_ignore = '.git/COMMIT_EDITMSG'
au BufReadPost * call RestorePosition()

func! RestorePosition()
    if exists("g:restore_position_ignore") && match(expand("%"), g:restore_position_ignore) > -1
        return
    endif

    if line("'\"") > 1 && line("'\"") <= line("$")
        exe "normal! g`\""
    endif
endfunc

function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction



function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --PHP-kinds=+cf --regex-PHP="/abstract class ([^ ]*)/\1/c/" --regex-PHP="/interface ([^ ]*)/\1/c/" --regex-PHP="/(public |static |abstract |protected |private )+function ([^ (]*)/\2/f/" --fields=+iaS --extra=+q ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
  set tags=tagfilename
endfunction

function! GenerateTags()
  let cmd = "ctags -h \".php\" -R --exclude=\"\.svn\" --totals=yes --tag-relative=yes --PHP-kinds=+cf --regex-PHP='/abstract class ([^ ]*)/\1/c/' --regex-PHP='/interface ([^ ]*)/\1/c/' --regex-PHP='/(public |static |abstract |protected |private )+function ([^ (]*)/\2/f/' --exclude=*.js"
  let resp = system(cmd)
  set tags=tags
endfunction

"autocmd BufWritePost *.php call UpdateTags()

" Undo history between sessions
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" Colored column (to see line size violations)
set colorcolumn=80

set history=200

map <C-left> :tabp<CR>
map <C-right> :tabn<CR>

map <left> <esc>
map <right> <esc>
map <up> <esc>
map <down> <esc>
imap <left> <esc>
imap <right> <esc>
imap <up> <esc>
imap <down> <esc>

" Old to test later
" autocmd FileType php set omnifunc=phpcomplete#CompletePHP


au BufRead,BufNewFile *.twig setfiletype htmldjango


set modeline
set modelines=1000000
let mapleader = ","

nnoremap <silent> <leader>s :call argumentrewrap#RewrapArguments()<CR>

let g:CommandTAcceptSelectionTabMap ='<CR>'
nnoremap <silent> <C-f> :CommandT <CR>
nnoremap <silent> <C-g> :CommandT ./src<CR>
nnoremap <silent> <C-h> :GundoToggle<CR>

"map <C-]> <C-w><C-]><C-w>T

autocmd FileType java map <C-]> :JavaSearchContext<CR>
au BufNewFile,BufRead *.c,*.cc,*.cpp,*.h map <F5> :!make test<CR>
au BufNewFile *.php call CreateClass()
au BufNewFile *.java call CreateClassJava()


"set relativenumber

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

"nnoremap <leader>v V`]
"
    let g:syntastic_mode_map = { 'mode': 'passive',
                               \ 'active_filetypes': ['ruby'],
                               \ 'passive_filetypes': ['puppet', 'php'] }


    let g:symfony_enable_shell_mapping = 0 "disable the mapping of symfony console

    " Use your key instead of default key which is <C-F>
    map <leader>c :execute ":!"g:symfony_enable_shell_cmd<CR>

" first set path
set path+=**

inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>
inoremap <Leader>i <C-O>:call ImplementInterface()<CR>
noremap <Leader>i :call ImplementInterface()<CR>
inoremap <Leader>o <C-O>:call GenerateTags()<CR>
noremap <Leader>o :call GenerateTags()<CR>
inoremap <Leader>t <C-O>:TagbarToggle<CR>
noremap <Leader>t :TagbarToggle<CR>
map gf <C-w>gf<C-w>T
au BufNewFile,BufRead *.java map <C-S-O-> :JavaImportOrganize<CR>

"source /home/juliens/.vim/bundle/cscope_maps.vim
"
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:EclimJavaSearchSingleResult = 'tabnew'

set tags+=vendors.tags
set tags+=copix.tags
let g:dbgPavimPort = 9001


function! CreateClassJava()
    let pwd=expand("%:.:h")
    let namespace=substitute(substitute(pwd, "src\/main\/java\/", "", ""), "/", ".", "g")
    let class_name=expand("%:t:r")
    exe ":!mkdir -p %:h"
    if (namespace!=".")
        exe ":normal ggopackage " . namespace .";"
    endif
    exe ":normal oclass " . class_name . "{}"
    exe ":normal ko"
endfunction
