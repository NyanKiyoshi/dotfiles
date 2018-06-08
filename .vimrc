" clear all auto commands
autocmd!

syntax enable
set t_Co=256
colorscheme xoria256

set wildmenu                    " turn on wild menu :e <Tab>
set wildmode=list:longest       " set wildmenu to list choice

set nocompatible                " disable vi compatibility
set viminfo=                    " don't use or save viminfo files
set fileformats=unix,dos,mac    " support all three newline formats

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

set ruler                       " show cursor position
set showmatch                   " highlight matching brackets
set wrap                        " enable soft wrap
set list                        " show invisible characters
set listchars=tab:>·,trail:·    " but only show tabs and trailing whitespace
set lazyredraw                  " don't redraw while in macros

set backspace=indent,eol,start
set scrolloff=5                 " keep at least 5 lines around the cursor
set formatoptions& formatoptions+=mM
set tw=0
set shortmess=atI               " shorten messages and don't show intro

" set column
set textwidth=80                " set column width to be 80 chars
set wrapmargin=2
execute "set colorcolumn=" . join(range(81,335), ',')

set backup
set history=1000

set mouse-=a " no auto visual

set noautochdir

set incsearch                   " enable incremental searching
set hlsearch                    " highlight matches


" no error bells and prints
set noerrorbells
set visualbell t_vb=

filetype plugin on
filetype plugin indent on


" set spellchecker
set spl=en spell
set nospell


" file type detection
filetype on                   " Enable filetype detection
filetype indent on            " Enable filetype-specific indenting
filetype plugin on            " Enable filetype-specific plugins

