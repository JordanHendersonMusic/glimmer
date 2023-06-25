#(define-public (my_duration-line::print grob)
  "Return the stencil of @code{DurationLine}."
  (let* ((vals (duration-line::calc grob))
         (staff-space (assoc-get 'staff-space vals))
         (style (assoc-get 'style vals))
         
         (left-start (assoc-get 'x-start vals))
         (right-end (assoc-get 'x-end vals))
         
         (left-Y (assoc-get 'y vals))
         (blot-diameter (assoc-get 'blot vals))
         (used-thick (assoc-get 'thick vals))
         (hook-stil (assoc-get 'hook vals))
         (arrow-stil (assoc-get 'arrow vals)))

    (if (eq? style 'beam)
        (ly:stencil-add
         (ly:round-filled-box
          (cons left-start right-end)
          (coord-translate
           (cons (/ used-thick -2) (/ used-thick 2))
           (* left-Y staff-space))
          blot-diameter)
         hook-stil
         arrow-stil)
        
        (ly:stencil-add
         (ly:line-interface::line
          grob
          left-start
          (* left-Y staff-space)
          right-end
          (* left-Y staff-space))
         arrow-stil))))
