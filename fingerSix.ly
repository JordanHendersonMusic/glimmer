\version "2.22.2"
\include "include/lilypond/flute_tab/fingering/load.ly"

fingerSix = \new fltabFingerVoice \drummode {
  \voiceTwo
  
  
  s8 sixC8
  s4*4
  \bar "|" % 0:10

  s4*4
  s8 sixN8\fltabKTrans
  \bar "|" % 0:20

  s8.. sixH32
  sixO16 sixN8.\fltabKTrans
  sixC4
  s2 
  \bar "|" % 0:30

  s4*4
  s8  sixN8\fltabKTrans
  \bar "|" % 0:40

  s8 sixO8
  s4
  sixN4\fltabKTrans
  s4
  sixC4
  \bar "|" % 0:50

  s4*5
  \bar "|" % 1:00

  sixC4
  s4
  sixN4\fltabKTrans
  s4
  sixH4
  \bar "|" % 1:10

  s4*5
  \bar "|" % 1:20

  sixH4
  s4*4
  \bar "|" % 1:30

  s4*4
  sixN4\fltabKTrans
  \bar "|" % 1:40

  s4.
  sixO8
  s4*3
  \bar "|" % 1:50

  s4*5
  \bar "|" % 2:00
  
  sixO4
  s4*4
  \bar "|" % 2:10
  
  s4*5
  \bar "|" % 2:20
  
  sixO4
  s4*4
  \bar "|" % 2:30
}