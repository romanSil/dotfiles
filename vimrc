" vimrc of Roman Silberschneider


" vundle plugin manager
set nocompatible
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'Chiel92/vim-autoformat'
Plugin 'rust-lang/rust.vim'
Plugin 'lervag/vimtex'

call vundle#end()            " required
filetype plugin indent on    " required


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
    set nobackup	" do not keep a backup file, use versions instead
else
    set backup		" keep a backup file
endif

set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch	" do incremental searching


" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
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
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif

set relativenumber

"------------------------------------------------------------------------------
" Spellchecking

" toggle spellchecking
map <F3> :set invspell<CR>

augroup gitcommit
    " we want spelling for git commits
    autocmd FileType gitcommit setlocal spell        
augroup END

augroup latexspll
    " we want spelling for git commits
    autocmd FileType plaintex setlocal spell        
augroup END

if has("autocmd")
    filetype plugin indent on

    "---------------------------------------------------------------------------
    " C files
    autocmd FileType c setlocal ts=2 sts=0 sw=2 expandtab smarttab
    "---------------------------------------------------------------------------
    " CPP files
    autocmd FileType cpp setlocal ts=2 sts=0 sw=2 expandtab smarttab
    "---------------------------------------------------------------------------
    " H files
    autocmd FileType h setlocal ts=2 sts=0 sw=2 expandtab smarttab
    "---------------------------------------------------------------------------
    " JSON files
    autocmd FileType json setlocal ts=2 sts=0 sw=2 expandtab smarttab
    "---------------------------------------------------------------------------
    " YAML files
    autocmd FileType yaml setlocal ts=2 sts=0 sw=2 expandtab smarttab
endif

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" command line history
set history=500

" Show a vertical gray line at x-th column
set colorcolumn=80
highlight Colorcolumn ctermbg=0

" Search
set ignorecase smartcase
set hlsearch
set incsearch

set nowrap

syntax on

" Hide backup files in file browser
let g:netrw_list_hide= '.*\.swp$,\~$,\.orig$'

map <F2> :w<CR> :make<CR>


" write with sudo
command W w !sudo tee % >/dev/null
