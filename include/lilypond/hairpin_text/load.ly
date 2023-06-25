
#(define (hairtxt:stencil grob)
   (let* ((stencil (ly:hairpin::print grob))
          (dir (ly:grob-property (ly:grob-parent grob Y) 'direction))
          (text (ly:grob-property grob 'text))
          (text-sten (grob-interpret-markup grob text))
          (combined (ly:stencil-combine-at-edge
                     (ly:stencil-aligned-to stencil X CENTER)
                     Y dir
                     (ly:stencil-aligned-to text-sten X CENTER)
                     ))
          (new-stencil  (ly:stencil-aligned-to combined  X LEFT)))
     (ly:grob-set-property! grob 'stencil new-stencil)
     (ly:grob-set-property! grob 'Y-offset 0)
     )
   )

hairtxtCresc =
#(define-event-function (parser location txt) (markup?)
   #{
     \tweak text #txt
     \tweak after-line-breaking #hairtxt:stencil
     \<
   #}
   )

hairtxtDim =
#(define-event-function (parser location txt) (markup?)
   #{
     \tweak text #txt
     \tweak Y-offset -2
     \tweak stencil #hairtxt:stencil
     \>
   #}
   )