\version "2.22.2"

#(define remove-last (lambda (l) (reverse (cdr (reverse l)))))


% all left aligned
#(define (tt:transition-stencil grob textList spaceList)
   (let* ((line-too-short-error
           "\n\nTransition is not large enough for the text wished to be displayed: make text smaller, line longer, or alter break points.\n")

          (original-sten (ly:line-spanner::print grob))
          (original-len (interval-length (ly:stencil-extent original-sten X)))

          (text-markup (map (lambda (t) (grob-interpret-markup grob (markup t))) textList))
          (text-lengths (map (lambda (s) (interval-length (ly:stencil-extent s X))) text-markup))
          (text-total-len (apply + text-lengths))
          (was-error (if (< original-len text-total-len)
                         (ly:error line-too-short-error)))

          (raw-line (make-connected-line (list (cons 0 0) (cons original-len  0)) grob ))

          (segment-positions (map (lambda (d) (* d original-len)) spaceList))
          (segment-lengths (map - (cdr segment-positions) (remove-last segment-positions)))

          (line-lengths (map - segment-lengths (remove-last text-lengths)))
          (line-lengths-check (map (lambda (d) (if (< d 0) (ly:error line-too-short-error))) line-lengths))

          (arrow-height 1)
          (arrow-width 1.2)
          (arrow-points (list (cons (- arrow-width)  (/ arrow-height 2))
                              (cons 0  0) (cons (- arrow-width) (/ arrow-height -2))))
          (arrow (ly:round-polygon arrow-points 0.15 0 #t))

          (make-line-arrow (lambda (len)
                             (ly:stencil-translate-axis
                              (ly:stencil-combine-at-edge
                               (make-connected-line (list (cons 0 0) (cons len 0)) grob)
                               X RIGHT arrow (- 0.4 arrow-width))
                              0.75 Y)))

          (text-with-arrows (map
                             (lambda (mark line-len)
                               (ly:stencil-combine-at-edge
                                mark X RIGHT  (make-line-arrow line-len) 0 ))
                             (remove-last text-markup)
                             line-lengths
                             ))
          (text-with-arrows (append text-with-arrows (list (last text-markup))))

          )
     (display line-lengths)

     (fold (lambda (lhs rhs) (ly:stencil-combine-at-edge rhs X RIGHT lhs 0) )
           (car text-with-arrows)
           (cdr text-with-arrows)
           )))

ttBeginTransition =
#(define-event-function
  (parser location textLists spaceLists)
  (list? list?)
  (let* ((extra-space 2)
         (textList-padded-first (markup (first textLists) #:hspace extra-space))
         (textList-padded-last (markup #:hspace extra-space (last textLists)))
         (textList-padded-middle (map (lambda (m)
                                        (markup #:hspace extra-space m #:hspace extra-space))
                                      (reverse (cdr (reverse (cdr textLists))))))
         (textList-padded (append (list textList-padded-first)
                                  textList-padded-middle
                                  (list textList-padded-last)))

         (spaceLists-check (if (not (eq? (+ (length spaceLists) 2) (length textLists)))
                               (ly:error "\n\nWrong number of spacing arguments provided to ttBeginTransition, should 2 less than the number of text elements"
                                         )))
         (spaceList-full (append '(0) spaceLists '(1))) )
    #{
      \tweak thickness #2
      \tweak style #'line
      \tweak bound-details.right.stencil-align-dir-y #0
      \tweak bound-details.left.stencil-align-dir-y #0
      \tweak stencil #(lambda (grob) (tt:transition-stencil grob textList-padded spaceList-full))
      \startTextSpan
    #}))

ttEndTransition =
#(define-event-function (parser location) ()
   #{ \stopTextSpan #})