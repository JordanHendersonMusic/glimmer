\version "2.21.82"

% key transition line - flutetab::KeyTransition
fltabKTrans =
#(define-event-function (parser location) ()
   #{
     \tweak style #'beam
     \tweak thickness #1.5

     \tweak bound-details.right.padding #0.4
     \tweak bound-details.left.padding #0.4

     \tweak bound-details.right.end-style #'arrow
     \tweak bound-details.right-broken.end-style #'arrow

     \tweak arrow-width #0.766
     \tweak arrow-length #0.7
     \tweak breakable ##t
     \tweak gap #0
     \- %duration line
   #})


% key wiggle line - flutetab::KeyWiggle
fltabKWiggle =
#(define-event-function (parser location sp) (number?)
   (let ((thi (+ (* sp sp 2) 1))
         (wd (max (+ (* (* sp sp) -1.1) 1.4) 0.01))
         (l (+ (* (* sp sp) 1.2) 0.52)) )
     #{
       \tweak style #'zigzag

       \tweak bound-details.right.end-style ##f
       \tweak bound-details.right-broken.end-style ##f

       \tweak bound-details.right.padding #0
       \tweak bound-details.left.padding #0

      % \tweak bound-details.right-broken.padding #-2
      % \tweak bound-details.left-broken.padding #-2

       \tweak breakable ##t
       \tweak gap #0

       \tweak thickness #thi
       \tweak zigzag-width #wd
       \tweak zigzag-length #l
       
       \- %duration line
     #}))





