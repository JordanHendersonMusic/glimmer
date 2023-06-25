\version "2.22.2"
\include "include/lilypond/flute_tab/fingering/load.ly"

fingerFour = \new fltabFingerVoice \drummode {
  \voiceTwo
  
  s8 fourC8
  s4*4 \bar "|" % 0:10

  fourN4\fltabKTrans
  s4
  s8 fourO32 fourH16.\fltabKTrans
  s8 fourO8
  s4 
  \bar "|" % 0:20

  fourO4
  s4
  s4
  s4
  fourN4\fltabKTrans
  \bar "|" % 0:30

  s4
  fourC4
  s4
  s4
  fourN8\fltabKTrans fourH8\fltabKTrans
  \bar "|" % 0:40

  s8 fourC8
  s4*4
  \bar "|" % 0:50

  s4
  s16 fourN8.\fltabKTrans
  s4
  fourO4\fltabKTrans
  s4
  \bar "|" % 1:00

  s4
  fourC4
  s4*3
  \bar "|" % 1:10

  fourN4\fltabKTrans
  s4
  s8. fourO16
  s4*2
  \bar "|" % 1:20

  fourO4\fltabKTrans
  s4*4
  \bar "|" % 1:30

  s2
  s8.. fourC32
  fourO4
  fourH4
  \bar "|" % 1:40

  fourO4
  s8 fourO8
  s4*3
  \bar "|" % 1:50

  s4*5 \bar "|" % 2:00
  
  fourO4
  s4*3
  s8 s16 fourC16
  \bar "|" % 2:10

  s4
  s16 fourO8.
  s4*3
  \bar "|" % 2:20

  fourO4
  s8 fourN8\fltabKTrans
  s8 fourH8
  s2
  \bar "|" % 2:30
}