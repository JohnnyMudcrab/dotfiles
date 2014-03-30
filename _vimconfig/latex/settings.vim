"" Latex Suite Settings
" set default output format
let g:Tex_DefaultTargetFormat='pdf'

" set default viewer
let g:Tex_ViewRule_pdf='okular'

" define toolchain for pdf
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

"" User Defined Functions
" forward serach with latex
function! SyncTexForward()
     let execstr = "silent !okular --unique %:p:r.pdf\\#src:".line(".")."%:p &"
     exec execstr
     redraw!
     redraw!
endfunction
