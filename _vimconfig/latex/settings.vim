"" Latex Suite Settings
" let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'

" set default output format
let g:Tex_DefaultTargetFormat='pdf'

" set default viewer
let g:Tex_ViewRule_pdf='evince'

" define toolchain for pdf
" let g:Tex_CompileRule_dvi = 'latex --interaction=nonstopmode $*'
" let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
" let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'
let g:Tex_CompileRule_pdf='pdflatex -shell-escape -interaction=nonstopmode -synctex=1 $*'

" formats for cross-references
let g:Tex_MultipleCompileFormats='pdf, aux'

" disable latex suite folding
let g:Tex_Folding=0

" no sections will be folded
let g:Tex_FoldedSections=""

" no enviroments will be folded
let g:Tex_FoldedEnvironments=""

" no misc will be folded
let g:Tex_FoldedMisc=""

" change filetype back to latex
let g:tex_flavor='latex'

" dont open error message if not wanted
let g:Tex_GotoError=0

"" User Defined Functions
" forward serach with latex
function! SyncTexForward()
     let execstr = "silent !okular --unique %:p:r.pdf\\#src:".line(".")."%:p &"
     exec execstr
     redraw!
     redraw!
endfunction

au BufNewFile,BufRead *.asy set filetype=asy

let Tex_no_error=1
let g:Tex_ShowErrorContext = 0
