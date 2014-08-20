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
Bundle 'gerw/vim-HiLinkTrace'
Bundle 'croaker/mustang-vim'
Bundle 'JohnnyMudcrab/vim-mudcrab'
Bundle 'endel/vim-github-colorscheme'
" Bundle 'altercation/vim-colors-solarized'
" Bundle 'shawncplus/skittles_berry'
" Bundle 'Skittles-Dark'
" Bundle 'twilight256.vim'
" Bundle 'flazz/vim-colorschemes'
" Bundle 'guns/xterm-color-table.vim'

" Better file browser
Bundle 'scrooloose/nerdtree'

" make nerdtree work with tabs
Bundle 'jistr/vim-nerdtree-tabs'

" Project Support
" Bundle 'amiorin/vim-project'

" Code and files fuzzy finder
Bundle 'kien/ctrlp.vim'

" Extension to ctrlp, for fuzzy command finder
Bundle 'fisadev/vim-ctrlp-cmdpalette'

" Class/module browser
Bundle 'majutsushi/tagbar'

" restore view
Bundle 'restore_view.vim'

" Pending tasks list
Bundle 'fisadev/FixedTaskList.vim'

" Code commenter
Bundle 'scrooloose/nerdcommenter'

" Git integration
" Bundle 'motemen/git-vim'
Bundle 'tpope/vim-fugitive'

" snippets stuff
" Bundle 'MarcWeber/vim-addon-mw-utils'
" Bundle 'tomtom/tlib_vim'
" Bundle 'honza/vim-snippets'
" Bundle 'Shougo/neosnippet.vim'

" Autocompletion
" Bundle 'Shougo/neocomplete.vim'
" Bundle 'ervandew/supertab'
Bundle 'Valloric/YouCompleteMe'

" Surround
Bundle 'tpope/vim-surround'

" Autoclose
" Bundle 'Townk/vim-autoclose'
Bundle 'Raimondi/delimitMate'
" Airline
Bundle 'bling/vim-airline'

" Search results counter
Bundle 'IndexedSearch'

" Toogle List Tool
Bundle 'milkypostman/vim-togglelist'

" multiple cursor support
Bundle 'terryma/vim-multiple-cursors'

" Lua support (needs to be outsourced)
Bundle 'xolox/vim-misc'
Bundle 'lua.vim'

" vim sneak for easier motion
Bundle 'justinmk/vim-sneak'

" Installing plugins the first time
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

" allow plugins by file type
filetype plugin on
filetype indent on
