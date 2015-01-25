"" vim-airline settings
let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_left_sep=""
let g:airline_right_sep=""
let g:airline#extensions#tabline#enabled = 1


"" Tagbar Settings
" autofocus on Tagbar open
let g:tagbar_autofocus = 1


"" Ctrl-P Settings
" Don't change working directory
let g:ctrlp_working_path_mode = 0

" Ignore files on fuzzy finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
  \ 'file': '\.pyc$\|\.pyo$',
  \ }


"" NERDCommenter Settings
" tell NERDCommenter to put whitespace after delimiter
let g:NERDSpaceDelims = 1


"" YouCompleteMe
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_auto_trigger = 1
let g:ycm_global_ycm_extra_conf = '~/.vimconfig/.ycm_extra_conf.py'
set completeopt-=preview
" set omnifunc=syntaxcomplete#Complete

"" UltiSnips
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<s-c-j>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Fix to let ESC work as espected with Autoclose plugin
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

let g:sneak#use_ic_scs = 1

"" User Defined Functions
" show syntax informations
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" toogle between number and relativ number
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

" enable language tool
let g:languagetool_jar='~/desktop/LanguageTool-2.7/languagetool-commandline.jar'

" get word count and set statusmessage
" function! WordCount()
  " let s:old_status = v:statusmsg
  " let position = getpos(".")
  " exe ":silent normal g\<c-g>"
  " let stat = v:statusmsg
  " let s:word_count = 0
  " if stat != '--No lines in buffer--'
    " let s:word_count = str2nr(split(v:statusmsg)[11])
    " let v:statusmsg = s:old_status
  " end
  " call setpos('.', position)
  " return s:word_count
" endfunction

" let g:airline_section_z = '%3p%%%{g:airline_symbols.linenr}%#__accent_bold#%4l%#__restore__#:%3c: %{WordCount()}'
" let g:airline_section_z = '%{WordCount()}'





"" Neocomplete Settings
" Use neocomplete.
" let g:neocomplete#enable_at_startup = 1
" Use smartcase.
" let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
" let g:neocomplete#sources#syntax#min_keyword_length = 3
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
" let g:neocomplete#sources#dictionary#dictionaries = {
    " \ 'default' : '',
    " \ 'vimshell' : $HOME.'/.vimshell_hist',
    " \ 'scheme' : $HOME.'/.gosh_completions'
        " \ }

" Define keyword.
" if !exists('g:neocomplete#keyword_patterns')
    " let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
" inoremap <expr><C-g>     neocomplete#undo_completion()
" inoremap <expr><C-l>     neocomplete#complete_common_string()

" AutoComplPop like behavior.
" let g:neocomplete#enable_auto_select = 0

" Enable omni completion.
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" autocmd FileType matlab setlocal omnifunc=syntaxcomplete#Complete

" Enable heavy omni completion.
" if !exists('g:neocomplete#sources#omni#input_patterns')
  " let g:neocomplete#sources#omni#input_patterns = {}
" endif

" if !exists('g:neocomplete#force_omni_input_patterns')
          " let g:neocomplete#force_omni_input_patterns = {}
" endif

" let g:neocomplete#force_overwrite_completefunc = 1
" let g:neocomplete#force_omni_input_patterns.c =
        " \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
" let g:neocomplete#force_omni_input_patterns.cpp =
        " \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
" let g:neocomplete#force_omni_input_patterns.objc =
        " \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
" let g:neocomplete#force_omni_input_patterns.objcpp =
        " \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

" let g:clang_complete_auto = 0

" let g:clang_auto_select = 0


