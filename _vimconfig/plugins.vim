" vim-airline settings
let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0

" fix some problems with gitgutter and jedi-vim
let g:gitgutter_eager = 0
let g:gitgutter_realtime = 0

" Fix to let ESC work as espected with Autoclose plugin
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" autofocus on Tagbar open
let g:tagbar_autofocus = 1

" Don't change working directory
let g:ctrlp_working_path_mode = 0

" Ignore files on fuzzy finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
  \ 'file': '\.pyc$\|\.pyo$',
  \ }

" tell NERDCommenter to put whitespace after delimiter
let g:NERDSpaceDelims = 1

" clang complete
let g:clang_use_library=1
let g:clang_complete_macros=1
let g:clang_library_path="/usr/lib/llvm-3.2/lib"
let g:clang_snippets = 1
let g:clang_jumpto_declaration_key="<leader>cg"
let g:clang_snippets_engine = 'clang_complete'
let g:clang_hl_errors=1
let g:clang_auto_select=1

" dont select first item when autoomplete
let g:acp_autoselectFirstCompletion=0

" latex suite
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='okular'
let g:Tex_CompileRule_pdf='pdflatex -interaction=nonstopmode -synctex=1 $*'
let g:Tex_MultipleCompileFormats='pdf, aux'
let g:Tex_Folding=0
let g:Tex_FoldedSections=""
let g:Tex_FoldedEnvironments=""
let g:Tex_FoldedMisc=""
