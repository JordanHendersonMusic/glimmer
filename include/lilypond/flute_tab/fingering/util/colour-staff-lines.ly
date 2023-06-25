\version "2.21.82"

#(define-public ((color-staff-lines . rest) grob)
   (define (index-cell cell dir)
     (if (equal? dir RIGHT)
         (cdr cell)
         (car cell)))

   (define (index-set-cell! x dir val)
     (case dir
       ((-1) (set-car! x val))
       ((1) (set-cdr! x val))))

   (let* ((common (ly:grob-system grob))
          (span-points '(0 . 0))
          (thickness (* (ly:grob-property grob 'thickness 0.1)
                        (ly:output-def-lookup (ly:grob-layout grob) 'line-thickness)))
          (width (ly:grob-property grob 'width))
          (line-positions (ly:grob-property grob 'line-positions))
          (staff-space (ly:grob-property grob 'staff-space 1))
          (line-stencil #f)
          (total-lines empty-stencil)
          ;; use a local copy of colors list, since
          ;; stencil creation mutates list
          (colors rest))

     (for-each
      (lambda (dir)
        (if (and (= dir RIGHT)
                 (number? width))
            (set-cdr! span-points width)
            (let* ((bound (ly:spanner-bound grob dir))
                   (bound-ext (ly:grob-extent bound bound X)))

              (index-set-cell! span-points dir
                               (ly:grob-relative-coordinate bound common X))
              (if (and (not (ly:item-break-dir bound))
                       (not (interval-empty? bound-ext)))
                  (index-set-cell! span-points dir
                                   (+ (index-cell span-points dir)
                                      (index-cell bound-ext dir))))))
        (index-set-cell! span-points dir (- (index-cell span-points dir)
                                            (* dir thickness 0.5))))
      (list LEFT RIGHT))

     (set! span-points
           (coord-translate span-points
                            (- (ly:grob-relative-coordinate grob common X))))
     (set! line-stencil
           (make-line-stencil thickness (car span-points) 0 (cdr span-points) 0))

     (if (pair? line-positions)
         (for-each (lambda (position)
                     (let ((color (if (pair? colors)
                                      (car colors)
                                      #f)))
                       (set! total-lines
                             (ly:stencil-add
                              total-lines
                              (ly:stencil-translate-axis
                               (if (color? color)
                                   (ly:stencil-in-color line-stencil
                                                        (first color)
                                                        (second color)
                                                        (third color))
                                   line-stencil)
                               (* position staff-space 0.5) Y)))
                       (and (pair? colors)
                            (set! colors (cdr colors)))))
                   line-positions)
         (let* ((line-count (ly:grob-property grob 'line-count 5))
                (height (* (1- line-count) (/ staff-space 2))))
           (do ((i 0 (1+ i)))
             ((= i line-count))
             (let ((color (if (and (pair? colors)
                                   (> (length colors) i))
                              (list-ref colors i)
                              #f)))
               (set! total-lines (ly:stencil-add
                                  total-lines
                                  (ly:stencil-translate-axis
                                   (if (color? color)
                                       (ly:stencil-in-color line-stencil
                                                            (first color)
                                                            (second color)
                                                            (third color))
                                       line-stencil)
                                   (- height (* i staff-space)) Y)))))))
     total-lines))
