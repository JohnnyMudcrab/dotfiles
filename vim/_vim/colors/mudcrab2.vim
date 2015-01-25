set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "mudcrab"


" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine   cterm=NONE    ctermfg=NONE ctermbg=236
  hi ColorColumn  cterm=NONE    ctermfg=NONE ctermbg=233
  hi CursorColumn cterm=NONE    ctermfg=NONE ctermbg=233
  hi MatchParen   cterm=NONE    ctermfg=157  ctermbg=237
  hi MatchParen   cterm=bold    ctermfg=157  ctermbg=237
  hi Pmenu		  cterm=NONE    ctermfg=255  ctermbg=238
  hi PmenuSel     cterm=NONE    ctermfg=0    ctermbg=148
endif

" General colors
hi Cursor         cterm=NONE    ctermfg=0    ctermbg=241
hi Normal         cterm=NONE    ctermfg=253  ctermbg=234
hi NonText        cterm=NONE    ctermfg=244  ctermbg=235
hi LineNr         cterm=NONE    ctermfg=244  ctermbg=232
hi StatusLine     cterm=ITALIC  ctermfg=253  ctermbg=238
hi StatusLineNC   cterm=NONE    ctermfg=246  ctermbg=238
hi VertSplit      cterm=NONE    ctermfg=238  ctermbg=238
hi Folded         cterm=NONE    ctermfg=248  ctermbg=8
hi Title          cterm=BOLD    ctermfg=254  ctermbg=NONE
hi Visual         cterm=NONE    ctermfg=254  ctermbg=4
hi SpecialKey     cterm=NONE    ctermfg=244  ctermbg=236
hi search         cterm=NONE    ctermfg=NONE ctermbg=240

" Syntax highlighting
hi Comment        cterm=NONE    ctermfg=244 ctermbg=NONE
hi Todo           cterm=NONE    ctermfg=245 ctermbg=NONE
hi Boolean        cterm=NONE    ctermfg=148 ctermbg=NONE
hi String         cterm=NONE    ctermfg=180 ctermbg=NONE
hi Identifier     cterm=NONE    ctermfg=148 ctermbg=NONE
hi Function       cterm=NONE    ctermfg=255 ctermbg=NONE
hi Type           cterm=NONE    ctermfg=110 ctermbg=NONE
hi Statement      cterm=NONE    ctermfg=110 ctermbg=NONE
hi Keyword        cterm=NONE    ctermfg=208 ctermbg=NONE
hi Constant       cterm=NONE    ctermfg=208 ctermbg=NONE
hi Number         cterm=NONE    ctermfg=150 ctermbg=NONE
hi Special        cterm=NONE    ctermfg=174 ctermbg=NONE
hi PreProc        cterm=NONE    ctermfg=150 ctermbg=NONE

" Code-specific colors
hi pythonOperator cterm=NONE    ctermfg=103 ctermbg=NONE

" NERDTree colors
hi NERDTreeFile   cterm=NONE    ctermfg=250 ctermbg=NONE
hi NERDTreeDir    cterm=NONE    ctermfg=111 ctermbg=NONE
hi NERDTreeUp     cterm=NONE    ctermfg=62  ctermbg=NONE

hi def link NERDTreeOpenable String
hi def link NERDTreeCloseable NERDTreeOpenable
hi def link NERDTreeCWD String
hi def link NERDTreePart String
