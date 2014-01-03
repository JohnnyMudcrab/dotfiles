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

" color scheme
" Bundle 'Mustang2'
Bundle 'croaker/mustang-vim'
" Bundle 'altercation/vim-colors-solarized'
" Bundle 'shawncplus/skittles_berry'
" Bundle 'guns/xterm-color-table.vim'
" Better file browser
Bundle 'scrooloose/nerdtree'
" make nerdtree work with tabs
Bundle 'jistr/vim-nerdtree-tabs'
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
Bundle 'Shougo/neosnippet.vim'
" Autocompletion
" Bundle 'AutoComplPop'
" Bundle 'dirkwallenstein/vim-autocomplpop'
Bundle 'Shougo/neocomplete.vim'
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
" Latex Support
Bundle 'gerw/vim-latex-suite'
" Matlab-Vim
" Bundle 'lazywei/vim-matlab'
" Bundle 'djoshea/vim-matlab-fold'
" multiple cursors
" Bundle 'terryma/vim-multiple-cursors'
" Octave Vim
" Bundle 'sjas/octave.vim'
" Bundle 'jvirtanen/vim-octave'

" Installing plugins the first time
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

" allow plugins by file type
filetype plugin on
filetype indent on
