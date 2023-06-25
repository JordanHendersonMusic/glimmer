\version "2.21.82"

fltabHHold = #(define-event-function (parser location) ()
                #{ \- #})

fltabHTrans = #(define-event-function (parser location) ()
                 #{ \glissando #})

fltabHShowLedgersUpTo =
#(define-music-function (l mus ) (ly:music? ly:music?)
   #{
     <<
       $mus

       \new Voice {
         \voiceTwo
         \override NoteHead.transparent = ##t
         \omit Stem
         \omit Flag
         \omit Dots
         \afterGrace s16 $l
       }

     >>
   #})


fltabHCurv =
#(define-event-function (parser location pnts) (pair?)
   #{
     \tweak breakable #f
     \tweak stencil
     #(lambda (grob)
        (let* ((original (ly:line-spanner::print grob))
               (left-bound-info (ly:grob-property grob 'left-bound-info))
               (left-bound (ly:spanner-bound grob LEFT))
               (right-bound-info (ly:grob-property grob 'right-bound-info))
               (right-bound (ly:spanner-bound grob RIGHT))
               (left-y (assoc-get 'Y left-bound-info))
               (right-y (assoc-get 'Y right-bound-info))
               (note-column (ly:grob-parent left-bound X))
               (note-heads (ly:grob-object note-column 'note-heads))
               (ext-X (if (null? note-heads) '(0 . 0)
                          (ly:relative-group-extent note-heads grob X)))
               (factor (interval-length (ly:stencil-extent original X)))

               (xspace (lambda (x) (* x factor)))
               (yspace (lambda (y) (* y (- right-y left-y))))

               (pnt1 (car pnts))
               (pnt2 (cdr pnts))

               (new-sten
                (grob-interpret-markup
                 grob
                 (markup
                  #:path 0.46 (list (list 'curveto
                                          (xspace (car pnt1)) (cdr pnt1)
                                          (xspace (car pnt2)) (cdr pnt2)
                                          (xspace 1) (yspace 1)))))))
          (ly:stencil-translate new-sten (cons (interval-length ext-X) left-y ))))
     \glissando
   #})


#(define-markup-command (fltabhcurvelongdebug layout props point col) (pair? color?)
   (interpret-markup layout props
                     (markup #:translate point #:with-color col #:draw-circle 0.4 0.1 #t )))




#(define (range first last)
   (if (>= first last)
       '()
       (cons first (range (+ first 1) last))))
#(define (normRange steps) (map (lambda (n) (/ n steps)) (range 0 steps)))

#(define (cart2pol c) (cons (* (car c) (cos (cdr c)) ) (* (car c) (sin (cdr c)))))



#(define (lerp from to l) (+ from (* l (- to from))))

#(define (vec:mag v)
   (sqrt (+ (* (car v) (car v)) (* (cdr v) (cdr v))))
   )
#(define (vec:oper func l r)
   (cons (func (car l) (car r)) (func (cdr l)  (cdr r))))

#(define (points:dis pfrom pto) (vec:oper - pto pfrom))
#(define (points:len pfrom pto) (vec:mag (vec:oper - pto pfrom)))


#(define (vec:lerp from to l)
   (let* ((a (lerp (car from) (car to) l))
          (b (lerp (cdr from) (cdr to) l)))
     (cons a b)))

#(define (fltab:hcurvelong:2beziers len hei pnts)
   (let* ((xspace (lambda (x) (* x len)))
          (yspace (lambda (y) (* y hei)))
          (norm2space (lambda (p) (cons (xspace (car p)) (yspace (cdr p)))))

          (norm:start (assoc-ref pnts "start"))
          (norm:ctl1 (assoc-ref pnts "ctl1"))
          (norm:mid (assoc-ref pnts "mid"))
          (norm:midRaw (cart2pol (assoc-ref pnts "midCtlPolar")))
          (norm:ctl2 (vec:oper - norm:mid norm:midRaw))
          (norm:ctl3 (vec:oper + norm:mid norm:midRaw))
          (norm:ctl4 (assoc-ref pnts "ctl4"))
          (norm:end '(1 1))

          (bez:first (map norm2space (list norm:start norm:ctl1 norm:ctl2 norm:mid)))
          (bez:second (map norm2space (list norm:mid norm:ctl3 norm:ctl4 norm:end))))
     (cons bez:first bez:second)
     ))

#(define (listOfLists2Bezier l)
   (if (pair? (car l))
       (list (car (car l))
             (cdr (car l))

             (car (car (cdr l)))
             (cdr (car (cdr l)))

             (car (car (cdr (cdr l))))
             (cdr (car (cdr (cdr l))))

             (car (car (cdr (cdr (cdr l)))))
             (cdr (car (cdr (cdr (cdr l)))))
             )
       (list (car (car l))
             (car (cdr (car l)))

             (car (car (cdr l)))
             (car (cdr (car (cdr l))))

             (car (car (cdr (cdr l))))
             (car (cdr (car (cdr (cdr l)))))

             (car (car (cdr (cdr (cdr l)))))
             (car (cdr (car (cdr (cdr (cdr l))))))
             )))

#(define (bezier2ListOfLists b)
   (list (bezier:start b) (bezier:ctl1 b) (bezier:ctl2 b) (bezier:end b)))

#(define (bezier:start b) (cons (car b)
                                (car (cdr b))))
#(define (bezier:ctl1 b)  (cons (car (cdr (cdr b)))
                                (car (cdr (cdr (cdr b))))))
#(define (bezier:ctl2 b)  (cons (car (cdr (cdr (cdr (cdr b)))))
                                (car (cdr (cdr (cdr (cdr (cdr b))))))))
#(define (bezier:end b)   (cons (car (cdr (cdr (cdr (cdr (cdr (cdr b)))))))
                                (car (cdr (cdr (cdr (cdr (cdr (cdr (cdr b))))))))))


#(define (bez:lerp b l)
   (let* ((a1 (vec:lerp (bezier:start b) (bezier:ctl1 b) l))
          (a2 (vec:lerp (bezier:ctl1 b) (bezier:ctl2 b) l))
          (a3 (vec:lerp (bezier:ctl2 b) (bezier:end b) l))
          (b1 (vec:lerp a1 a2 l))
          (b2 (vec:lerp a2 a3 l)))
     (vec:lerp b1 b2 l)))

#(define (bez:split b l) ;; proudces 2 beziers
   (let* ((a1 (vec:lerp (bezier:start b) (bezier:ctl1 b) l))
          (a2 (vec:lerp (bezier:ctl1 b) (bezier:ctl2 b) l))
          (a3 (vec:lerp (bezier:ctl2 b) (bezier:end b) l))
          (b1 (vec:lerp a1 a2 l))
          (b2 (vec:lerp a2 a3 l))
          (c (vec:lerp b1 b2 l))
          (lhs (list (bezier:start b) a1 b1 c))
          (rhs (list c b2 a3 (bezier:end b))))
     (list (listOfLists2Bezier lhs) (listOfLists2Bezier rhs))))

#(define (bez:len b)
   (let* ((breaks (map (lambda (n) (/ n 25)) (range 0 25)))
          (break-points (map (lambda (p) (bez:lerp b p)) breaks ))
          (init-distance 0)
          (init-point (car break-points))
          (initobj (list init-distance init-point))
          (distance_acc (lambda (newpoint  dobj)
                          (let* ((olddis (car dobj))
                                 (oldpoint (car (cdr dobj)))
                                 (dis (+ (car dobj) (points:len oldpoint newpoint))))
                            (list dis newpoint)
                            )))

          (finalobj (fold distance_acc initobj (cdr break-points))))
     (car finalobj)))

#(define (bez:map func b)
   (listOfLists2Bezier (map func (bezier2ListOfLists b))))

#(define (path:moveToBezStart b)
   (let ((pn (bezier:start b)))
     (list 'moveto (car pn) (cdr pn))
     ))

#(define (path:curveAlongBez b)
   (let* ((ctl1 (bezier:ctl1 b))
          (ctl2 (bezier:ctl2 b))
          (end (bezier:end b)))
     (list 'curveto
           (car ctl1) (cdr ctl1)
           (car ctl2) (cdr ctl2)
           (car end) (cdr end))))

#(define bez:zero (list 0 0 0 0 0 0 0 0))

#(define (bez2:lerp bs l)
   (let*((b1:len (bez:len (car bs)))
         (b2:len (bez:len (car (cdr bs))))
         (t:len (+ b1:len b2:len))
         (newpos (* l t:len))
         (in-b1 (< newpos b1:len))
         (b1:perc (/ t:len b1:len))
         (b2:perc (/ t:len b2:len))
         (lerp:ifb1 (/ newpos b1:len))
         (lerp:ifb2 (/ (- newpos b1:perc) b2:len))
         (finallerp (if in-b1 lerp:ifb1 lerp:ifb2))
         (finalbez (if in-b1 (car bs) (car (cdr bs)))))
     (bez:lerp finalbez finallerp)))


#(define (remove-last lst)
   (if (null? (cdr lst))
       '()
       (cons (car lst) (remove-last (cdr lst)))))


#(define (bez2:crosses-xpos bs xpos)
   ;; distances where the curve crosses some x position
   ;; all in normalised space
   (let* ((breaks (normRange 100))
          (breaks2points (lambda (l)
                           (let* (
                                   (a (bez2:lerp bs l))
                                   (b (car a))
                                   (out (cons b l))
                                   )
                             out
                             )
                           ))
          (points (map  breaks2points breaks))
          ;; (xpos . distancelerp)
          (pointsFrom (remove-last points))
          (pointsTo (cdr points))
          (crossedFunc (lambda (from to)
                         (if (and (< (car from) xpos) (> (car to) xpos))
                             (cons 1 (cdr from))  ;; left to right cross
                             (if (and (> (car from) xpos) (< (car to) xpos))
                                 (cons -1 (cdr from))  ;; right to left cross
                                 (cons 0 (cdr from)) )))) ;; no cross
          (crossdata (map crossedFunc pointsFrom pointsTo))
          (crosses (remove (lambda (c) (if (eq? (car c) 0) #t #f)) crossdata))
          )
     crosses
     ))

#(define (bez2:split-right bs l) ;; may return a zero bezier
   (let* ((b1 (car bs))
          (b2 (car (cdr bs)))

          (b1:len (bez:len b1))
          (b2:len (bez:len b2))
          (t:len (+ b1:len b2:len))

          (newpos (* l t:len))
          (in-b1 (< newpos b1:len))
          (b1:perc (/ t:len b1:len))
          (b2:perc (/ t:len b2:len))
          (lerp:ifb1 (/ newpos b1:len))
          (lerp:ifb2 (/ (- newpos b1:perc) b2:len))
          (finallerp (if in-b1 lerp:ifb1 lerp:ifb2))
          (remaining (car (cdr (bez:split (if in-b1 b1 b2) finallerp)))))
     (if in-b1
         (list remaining b2)
         (list bez:zero remaining))))

#(define (bez2:split-left bs l) ;; may return a zero bezier
   (let* ((b1 (car bs))
          (b2 (car (cdr bs)))
          (b1:len (bez:len b1))
          (b2:len (bez:len b2))
          (t:len (+ b1:len b2:len))
          (newpos (* l t:len))
          (in-b2 (> newpos b1:len))
          (b1:perc (/ t:len b1:len))
          (b2:perc (/ t:len b2:len))
          (lerp:ifb1 (/ newpos b1:len))
          (lerp:ifb2 (/ (- newpos b1:perc) b2:len))
          (finallerp (if in-b2 lerp:ifb2 lerp:ifb1))
          (remaining (car (bez:split (if in-b2 b2 b1) finallerp))))
     (if in-b2
         (list b1 remaining )
         (list bez:zero remaining))))


#(define (draw:bez-info grob)
   (let* ((original (ly:line-spanner::print grob))
          (left-bound-info (ly:grob-property grob 'left-bound-info))
          (left-bound (ly:spanner-bound grob LEFT))
          (right-bound-info (ly:grob-property grob 'right-bound-info))
          (right-bound (ly:spanner-bound grob RIGHT))
          (left-y (assoc-get 'Y left-bound-info))
          (thickness (ly:grob-property grob 'thickness))
          (right-y (assoc-get 'Y right-bound-info))
          (left-x (assoc-get 'X left-bound-info))
          (right-x (assoc-get 'X right-bound-info))
          (note-column (ly:grob-parent left-bound X))
          (note-heads (ly:grob-object note-column 'note-heads))
          (ext-X (if (null? note-heads) '(0 . 0) (ly:relative-group-extent note-heads grob X)))
          ;(len (interval-length (ly:stencil-extent original X)))
          (len (- right-x left-x))
          (hei (- right-y left-y))
          (xspace (lambda (x) (* x len)))
          (staff-space (ly:staff-symbol-staff-space grob))
          (yspace (lambda (y) (* y hei)))
          (yspaceMiddle (lambda (y) (* y (if (> (abs hei) 0.1) hei 0))))
          (toStaffSpace (lambda (pnt) (cons (xspace (car pnt)) (yspace (cdr pnt)))))
          (toStaffSpaceMiddle (lambda (pnt) (cons (xspace (car pnt)) (yspaceMiddle (cdr pnt)))))
          (transStencil (lambda (sten)
                          (ly:stencil-translate sten (cons (interval-length ext-X) left-y )))))
     (list (cons "original" original)
           (cons "left-bound-info" left-bound-info)
           (cons "left-bound" left-bound)
           (cons "thickness" thickness)
           (cons "right-bound-info" right-bound-info)
           (cons "right-bound" right-bound)
           (cons "left-y" left-y)
           (cons "right-y" right-y)
           (cons "note-column" note-column)
           (cons "note-heads" note-heads)
           (cons "ext-X" ext-X)
           (cons "length" len)
           (cons "height" hei)
           (cons "xspace" xspace)
           (cons "yspace" yspace)
           (cons "yspaceMiddle" yspaceMiddle)
           (cons "toStaffSpace" toStaffSpace)
           (cons "toStaffSpaceMiddle" toStaffSpaceMiddle)
           (cons "staff-space" staff-space)
           (cons "transSten" transStencil))))



#(define (fltab:beziers2stencil bs grob info showHandels)
   (let* ((b1:ns (car bs))
          (b2:ns (car (cdr bs)))
          (ss-mapperEnds (assoc-get "toStaffSpace" info))
          (ss-mapperMiddle (assoc-get "toStaffSpaceMiddle" info))

          (mapToStaffSpace
           (lambda (b)
             (let ((start (ss-mapperEnds (bezier:start b)))
                   (ctl1 (ss-mapperMiddle (bezier:ctl1 b)))
                   (ctl2 (ss-mapperMiddle (bezier:ctl2 b)))
                   (end (ss-mapperEnds (bezier:end b))))
               (listOfLists2Bezier (list start ctl1 ctl2 end)))))

          (b1:ss (mapToStaffSpace b1:ns)) ;staffspace
          (b2:ss (mapToStaffSpace b2:ns))

          (new-path (list (path:moveToBezStart b1:ss)
                          (path:curveAlongBez b1:ss)
                          (path:curveAlongBez b2:ss)))
          (new-markup (markup #:path (* (assoc-get "staff-space" info) (assoc-get "thickness" info) (if showHandels 0.025 0.10)) new-path))

          (debugmarkup (markup
                        #:combine
                        #:with-color red
                        #:override '(thickness . 1) #:translate (bezier:ctl2 b1:ss)
                        #:draw-line (cons
                                     (- (car (bezier:ctl1 b2:ss)) (car (bezier:ctl2 b1:ss)))
                                     (- (cdr (bezier:ctl1 b2:ss)) (cdr (bezier:ctl2 b1:ss))))

                        #:combine #:fltabhcurvelongdebug (bezier:ctl1 b1:ss) red
                        #:combine #:fltabhcurvelongdebug (bezier:ctl2 b1:ss) blue
                        #:combine #:fltabhcurvelongdebug (bezier:end b1:ss) grey
                        #:combine #:fltabhcurvelongdebug (bezier:ctl1 b2:ss) green
                        #:fltabhcurvelongdebug (bezier:ctl2 b2:ss) magenta))

          (finalmarkup (markup #:combine (if showHandels debugmarkup (markup #:null)) new-markup)))
     (grob-interpret-markup grob finalmarkup)))


#(define (bez2:moveXOrigin bs)
   (let* (
           (b1 (car bs))
           (start (bezier:start b1))
           (ctl1 (bezier:ctl1 b1))
           (ctl2 (bezier:ctl2 b1))
           (end (bezier:end b1))
           (rem (cons (car start) 0))

           (b1 (bez:map (lambda (n) (vec:oper - n rem)) b1))
           (b2 (bez:map (lambda (n) (vec:oper - n rem)) (car (cdr bs))))

           (b2last (cons (car (bezier:end b2)) 1))

           (start (bezier:start b1))
           (ctl1 (bezier:ctl1 b1))
           (ctl2 (bezier:ctl2 b1))
           (end (bezier:end b1))

           (b1 (bez:map (lambda (n) (vec:oper / n b2last)) b1))
           (b2 (bez:map (lambda (n) (vec:oper / n b2last)) b2))
           )
     (list b1 b2)))

#(define (fltab:bezierGlisSplit spanner-grob this-grob beziers possible-grobs showHandels)
   (let* (
           (b1:ns (car beziers)) ;normspace
           (b2:ns (car (cdr beziers)))
           (this-info (draw:bez-info this-grob))
           (this-length (assoc-get "length" this-info))
           (this-height (assoc-get "height" this-info))

           (r-grob (car (cdr possible-grobs)))
           (r-info (draw:bez-info r-grob))
           (r-length (assoc-get "length" r-info))
           (l-grob (car possible-grobs))
           (l-info (draw:bez-info l-grob))
           (l-length (assoc-get "length" l-info))

           (is-left? (eq? l-grob this-grob))

           (total-length (+ l-length r-length))
           (split-percent (/ l-length total-length))

           (split-bez-pos (cdr (car (bez2:crosses-xpos beziers split-percent))))

           (bezSplitter (if is-left? bez2:split-left bez2:split-right))
           (new-bez2 (bezSplitter beziers split-bez-pos))
           (new-bez2 (bez2:moveXOrigin new-bez2))

           (new-stencil (fltab:beziers2stencil new-bez2 this-grob this-info showHandels))
           (new-stencil (if (< this-length 1) #f new-stencil))
           (new-stencil (ly:stencil-translate
                         new-stencil
                         (cons
                          (if is-left? 0 5) ; why 5? - I dunno?
                          (assoc-get "left-y" this-info)))))
     (ly:grob-set-property! this-grob 'stencil new-stencil)
     ))

fltabHTwoBezier =
#(define-event-function (parser location bs showHandels) (list? boolean?)
   #{
     \tweak stencil
     #(lambda (grob)
        (let (
               (info (draw:bez-info grob))

               )
          ((assoc-get "transSten" info) (fltab:beziers2stencil bs grob info showHandels))
          ))

     \tweak after-line-breaking
     #(lambda (grob)
        (let* ((spanner-original (ly:grob-original grob))
               (info (draw:bez-info grob))
               (siblings (if (ly:grob? spanner-original)
                             (ly:spanner-broken-into spanner-original)
                             '()))
               (was-split (>= (length siblings) 2)))
          (if was-split (fltab:bezierGlisSplit spanner-original grob bs siblings showHandels))
          ))

     \glissando

   #})


fltabHCurveLong =
#(define-event-function (parser location pnts showHandels) (list? boolean?)
   (let* ((start (cons 0 0))
          (end (cons 1 1))
          (midInfo (cart2pol (car (cdr pnts))))
          (splitPoint (car (cdr (cdr pnts))))
          (ctl1 (vec:oper + start (vec:oper * (cons (car splitPoint) 1)(cart2pol (car pnts)))))
          (ctl2 (vec:oper - splitPoint midInfo))
          (ctl3 (vec:oper + splitPoint midInfo))
          (ctl4raw (cart2pol (car (cdr (cdr (cdr pnts))))))
          (ctl4 (vec:oper - end (vec:oper * (cons (- 1 (car splitPoint)) 1) ctl4raw)))
          (b1 (listOfLists2Bezier (list start ctl1 ctl2 splitPoint)))
          (b2 (listOfLists2Bezier (list splitPoint ctl3 ctl4 end)))
          (bs (list b1 b2)))
     #{
       \fltabHTwoBezier #bs #showHandels
     #}
     )
   )
