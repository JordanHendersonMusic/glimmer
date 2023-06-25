\version "2.21.82"

staffSize =
#(define-music-function (new-size) (number?)
   #{
     \set fontSize = #new-size
     \override StaffSymbol.staff-space = #(magstep new-size)
     \override StaffSymbol.thickness = #(magstep new-size)
   #})
