\version "2.22.2"
\include "include/lilypond/flute_tab/fingering/load.ly"

fingerTwo = \new fltabFingerVoice \drummode {
  \voiceTwo

  s8 twoC8\fltabKWiggle #0
  twoN8\fltabKWiggle #0.2 twoN8\fltabKWiggle #0
  s4
  twoN8\fltabKWiggle #0.4 twoN8\fltabKWiggle #0
  s4
  \bar "|" % 0:10

  s4 s4 s4 s4 s4 \bar "|" % 0:20

  twoC4\fltabKWiggle #0
  s4
  s4
  s4
  s4
  \bar "|" % 0:30

  s4
  twoN16.\fltabKWiggle #0.3 twoN32\fltabKWiggle #0 s8
  s4
  twoN8\fltabKWiggle #0.6 twoN8\fltabKWiggle #0
  s4
  \bar "|" % 0:40

  twoC8\fltabKWiggle #0.1 twoN8\fltabKWiggle #0.45
  s8 twoN8\fltabKWiggle #0
  s4
  s4
  s8 twoN8\fltabKWiggle #0.4
  \bar "|" % 0:50

  twoN4\fltabKWiggle #0
  s4
  s4
  s4
  s8 twoN16\fltabKWiggle #0.7 twoN16\fltabKWiggle #0
  \bar "|" % 1:00

  twoC4\fltabKWiggle #0
  s8 twoN8\fltabKWiggle #0.9
  twoN8\fltabKWiggle #0.1 twoN8\fltabKWiggle #0.3
  s4
  s8 twoN8\fltabKWiggle #0
  \bar "|" % 1:10

  s4 s4 s4 s4 s4 \bar "|" % 1:20

  twoC4\fltabKWiggle #0 s4 s4 s4 s4 \bar "|" % 1:30

  s4 s4 s4 s4
  twoN8\fltabKWiggle #0.4 twoN8\fltabKWiggle #0.95
  \bar "|" % 1:40

  twoC8\fltabKWiggle #0.8 twoN8\fltabKWiggle #0.0
  s16. twoN32
  twoO8
  s4
  twoN4\fltabKTrans
  s4
  \bar "|" % 1:50

  s4 s8 twoH8 s4 s4 s4 \bar "|" % 2:00

  twoH4 s4 s4 s4 s4 \bar "|" % 2:10

  twoN4\fltabKTrans
  s16 twoO8.
  s16 twoN8.\fltabKTrans
  s8 s16 twoC16
  s4
  \bar "|" % 2:20

  twoC4 s4 s4 twoN4\fltabKTrans s4 \bar "|" % 2:30

  s4 twoO4 s4 s4 s4 \bar "|" % 2:40


}
