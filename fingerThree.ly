\version "2.22.2"
\include "include/lilypond/flute_tab/fingering/load.ly"

fingerThree = \new fltabFingerVoice \drummode {
  \voiceTwo
  
  s8 threeC8
  s4
  s4
  s4
  s4

  \bar "|" % 0:10

  s4
  s4
  s4
  s4
  s4

  \bar "|" % 0:20

  threeC4
  s4
  s4
  s4
  s4

  \bar "|" % 0:30

  s4
  s4
  s4
  s4
  s4

  \bar "|" % 0:40

  threeC4
  s4
  s4
  s4
  s4

  \bar "|" % 0:50

  s4
  s4
  s4
  s4
  s4

  \bar "|" % 1:00

  threeC4
  s4
  s4
  s4
  s4

  \bar "|" % 1:10

  s4
  s4
  threeC8\fltabKTrans s8
  s8 threeH8
  s4

  \bar "|" % 1:20

  threeC4
  s4
  s4
  s4
  s4

  \bar "|" % 1:30

  s4
  s4
  s4
  s4
  s4

  \bar "|" % 1:40

  threeC4
  s8 threeC8
  s4
  s4
  s4

  \bar "|" % 1:50

  s4
  s4
  s4
  s4
  s4

  \bar "|" % 2:00

  threeC4\fltabKTrans
  s16 threeH8.\fltabKTrans
  s4
  threeC4
  s4

  \bar "|" % 2:10

  s4
  s16  threeN8.\fltabKTrans
  threeO16\fltabKTrans threeC8.
  s16 threeN8.\fltabKTrans
  s4

  \bar "|" % 2:20
  s8 threeO8
  s4*4
  \bar "|" % 2:30
  s4*5
  \bar "|" % 2:40


}