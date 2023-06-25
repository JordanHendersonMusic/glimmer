\version "2.22.2"
\include "include/lilypond/flute_tab/fingering/load.ly"

fingerFive = \new fltabFingerVoice \drummode {
  \voiceTwo

  s8 fiveH8\fltabKTrans
  s4
  fiveC8 fiveN8\fltabKTrans
  s2
  \bar "|" % 0:10

  fiveO4
  s4
  fiveN4\fltabKTrans
  s2
  \bar "|" % 0:20

  s8 fiveC8\fltabKTrans
  s4*3
  fiveO4
  \bar "|" % 0:30

  s4
  s4
  fiveN4\fltabKTrans
  s8 fiveC8
  s4
  \bar "|" % 0:40

  fiveC4
  fiveN4\fltabKTrans
  fiveO4
  s8 s16. fiveC64 fiveO64\fltabKTrans
  s8 fiveC8\fltabKTrans
  \bar "|" % 0:50

  s4
  s8 fiveO8
  s4*3
  \bar "|" % 1:00

  fiveO8. fiveN16\fltabKTrans
  s4
  s16 fiveC8.
  s2
  \bar "|" % 1:10

  s4*5 \bar "|" % 1:20

  fiveC4
  s4*4
  \bar "|" % 1:30

  s4*5  \bar "|" % 1:40

  fiveC8 fiveN8\fltabKTrans
  s8 fiveO8
  s4*3
  \bar "|" % 1:50


  s8 fiveO8\fltabKWiggle #0
  s4*4
  \bar "|" % 2:00
  
  fiveN4\fltabKWiggle #0
  s4
  s8 fiveN8\fltabKWiggle #0.4
  fiveN16\fltabKWiggle #0.8 
  fiveN8.\fltabKWiggle #0.2
  s4
  \bar "|" % 2:10
  
  s4*5 \bar "|" % 2:20

  fiveO4\fltabKWiggle #0.1
  s2
  fiveN16\fltabKWiggle #1 fiveN16\fltabKWiggle #0
  fiveN16\fltabKWiggle #0.9 fiveN16\fltabKWiggle #0.2
  fiveN4\fltabKWiggle #0
  \bar "|" % 2:30
  
  s4*5

}