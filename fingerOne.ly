\version "2.22.2"
\include "include/lilypond/flute_tab/fingering/load.ly"

fingerOne = \new fltabFingerVoice \drummode {
  \voiceTwo

  s8 oneC8 s4 s4 s4 s4 \bar "|" % 0:10
  s4 s4 s4 s4 s4 \bar "|" % 0:20
  oneC4 s4 s4 s4 s4 \bar "|" % 0:30
  s4 s4 s4 s4 s4 \bar "|" % 0:40
  oneC4 s4 s4 s4 s4 \bar "|" % 0:50
  s4 s4 s4 s4 s4 \bar "|" % 1:00
  oneC4 s4 s4 s4 s4 \bar "|" % 1:10
  s4 s4 s4 s4 s4 \bar "|" % 1:20
  oneC4 s4 s4 s4 s4 \bar "|" % 1:30
  s4 s4 s4 s4 s4 \bar "|" % 1:40

  oneC8.  oneN16\fltabKTrans
  s8 oneO8
  s4
  oneN4\fltabKTrans
  s4
  \bar "|" % 1:50

  s4 s8 oneC8\fltabKTrans
  s4 
  s4
  oneH4\fltabKTrans
  \bar "|" % 2:00

  oneC4
  s4
  s4
  s4
  oneN4\fltabKTrans
  \bar "|" % 2:10

  s16 oneO8.
  s4
  s16 oneN8.\fltabKTrans
  oneC4
  s4
  \bar "|" % 2:20

  oneC4
  s4
  s4
  oneN4\fltabKTrans
  s4
  \bar "|" % 2:30

  s4 oneO4 s4 s4 s4 \bar "|" % 2:40



}

