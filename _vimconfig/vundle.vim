" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif

" required for vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" Bundles from GitHub repos:

" Mustang color scheme
Bundle 'Mustang2'
" Better file browser
Bundle 'scrooloose/nerdtree'
" Code and files fuzzy finder
Bundle 'kien/ctrlp.vim'
" Extension to ctrlp, for fuzzy command finder
Bundle 'fisadev/vim-ctrlp-cmdpalette'
" Class/module browser
Bundle 'majutsushi/tagbar'
" Pending tasks list
Bundle 'fisadev/FixedTaskList.vim'
" Code commenter
Bundle 'scrooloose/nerdcommenter'
" Git integration
Bundle 'motemen/git-vim'
" Git diff icons on the side of the file lines
Bundle 'airblade/vim-gitgutter'
" Snippets manager (SnipMate), dependencies, and snippets repo
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/vim-snippets'
Bundle 'garbas/vim-snipmate'
" Autocompletion
Bundle 'AutoComplPop'
" Surround
Bundle 'tpope/vim-surround'
" Autoclose
Bundle 'Townk/vim-autoclose'
" Airline
Bundle 'bling/vim-airline'
" Search results counter
Bundle 'IndexedSearch'
" Toogle List Tool
Bundle 'milkypostman/vim-togglelist'
" Vim Clang
Bundle 'Rip-Rip/clang_complete'

" Installing plugins the first time
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

" allow plugins by file type
filetype plugin on
filetype indent on
