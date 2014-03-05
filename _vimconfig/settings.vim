" vim-airline settings
let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_left_sep=""
let g:airline_right_sep=""
let g:airline#extensions#tabline#enabled = 1

" fix some problems with gitgutter
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


" dont select first item when autoomplete
let g:acp_autoselectFirstCompletion=0


