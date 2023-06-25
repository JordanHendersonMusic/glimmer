\include "include/lilypond/flute_tab/harmonics/load.ly"
\include "include/lilypond/text_transitions/load.ly"

#(define show-debug-info #f)

curveEaseSlowFast =
#(define-event-function (parser location) ()
   #{ \fltabHCurveLong #'((0.2 . 0.0) (0.2 . 0.6) (0.4 . 0.1) (0.4 . 0.0)) #show-debug-info #})

curveEaseFastSlow=
#(define-event-function (parser location) ()
   #{ \fltabHCurveLong #'((0.2 . 0.0) (0.3 . 0.6) (0.5 . 0.8) (0.2 . 0.0)) #show-debug-info #})

curveBalanced=
#(define-event-function (parser location) ()
   #{ \fltabHCurveLong #'((0.2 . 0.0) (0.2 . 1) (0.5 . 0.5) (0.2 . 0.0)) #show-debug-info #})

curveExp=
#(define-event-function (parser location) ()
   #{ \fltabHCurveLong #'((0.05 . 0.0) (0.3 . 0.8) (0.6 . 0.15) (0.4 . 1)) #show-debug-info #})


harmonicLine = \relative c' {

  s8 \tempo \markup "still, gradually emerging"
  a8\curveEaseSlowFast
  \ttBeginTransition #'("air" "tone")  #'()
  s4
  s4
  d4\curveBalanced \ttEndTransition
  s4
  \bar "|" % 0:10

  s4
  s8 a8\curveEaseSlowFast
  s4 d64 a8...\fltabHHold
  s4

  \bar "|" % 0:20

  s4*4 \ttBeginTransition
  #(list
    "(tone)"
    #{ \markup { \fraction "1" "2" "air" } #}
    "only air"
    "tone"
    )
  #'(0.2 0.7)

  a4\curveEaseSlowFast
  \bar "|" % 0:30

  s4
  s32\ttEndTransition
  d8..\curveEaseFastSlow
  s4
  a4\curveEaseSlowFast
  <c e>8\fltabHHold e8\fltabHHold
  \bar "|" % 0:40

  s8 <c e>8\fltabHHold
  c8.\curveEaseFastSlow a16\curveBalanced
  s16 c16\fltabHHold <c e>8\fltabHHold
  s8.. e32\fltabHHold
  s8
  <e g>8\fltabHHold
  \ttBeginTransition
  #(list "(tone)" #{ \markup { \fraction "1" "2" "air"} #} "tone" ) #'(0.3)

  \bar "|" % 0:50

  g16\fltabHHold
  g16\fltabHCurveLong #'((0.7 . 0.0) (0.3 . 1) (0.5 . 1.7) (0.2 . 0.0)) #show-debug-info
  s8

  s4
  s4
  s8 s8\ttEndTransition
  s8 c,8\fltabHHold
  \bar "|" % 1:00

  s8 <c e>8\fltabHHold
  <e g>64\fltabHHold e8...\fltabHHold
  s16 <c e>8\fltabHHold s32 c32\fltabHHold
  s4
  s8 <c e>16\fltabHHold c16\fltabHHold
  \bar "|" % 1:10

  <<
    {
      \tempo \markup "static airy tone with fluid bursts of whistles"
      s4*5 \bar "|" % 1:20
      s4*5 \bar "|" % 1:30
      s4*3
      c8\fltabHCurveLong #'((0.4 . 0) (2.5 . -1.45) (0.5 . 0.6) (0.5 . 0)) #show-debug-info
      s8
      s8 a8\curveExp
      \bar "|" % 1:40
    }

    \new fltabHarmonicVoice {
      \voiceTwo
      \override DurationLine.color = #grey
      \override DurationLine.style = #'trill
      \override DurationLine.thickness = #'2

      g'4\- ^\markup\smaller{ "unstable whistles" }
      s4*4 \bar "|" % 1:20
      s4*5 \bar "|" % 1:30
      s4*3 g4 s4 \bar "|" % 1:40
    }
  >>

  \tempo \markup "gettering more energetic"
  s4
  s8 {
    \once \override DurationLine.bound-details.left.padding = #1.25
    \fltabHShowLedgersUpTo {g8}  b8\fltabHHold
  }
  s4
  s8. b16\curveExp
  s8. e,16\fltabHHold
  \bar "|" % 1:50

  s16 <c e>8.\fltabHHold
  s4
  c8\fltabHHold c8\curveEaseFastSlow
  s8. a16\curveBalanced
  <c e>4\fltabHHold
  \bar "|" % 2:00

  s16 c8.\fltabHHold
  s4
  s8.
  c16\curveExp
  \set glissandoMap = #'((0 . 1) (0 . 0))
  b'16\curveBalanced
  \fltabHShowLedgersUpTo {e8} <g b>8.\fltabHHold
  s8. c16\fltabHHold
  \bar "|" % 2:10

  \set glissandoMap = #'((0 . 1) (0 . 0))
  c8\curveBalanced <e g>8\fltabHHold
  s16 c16\fltabHHold
  \set glissandoMap = #'((0 . 1) (0 . 0))
  c8\curveBalanced
  \set glissandoMap = #'((0 . 0) (1 . 1))
  <e g>16\curveBalanced <b f'>8.\curveBalanced
  \set glissandoMap = #'((0 . 0) (1 . 0))
  <c g'>8.\curveEaseSlowFast
  d16\curveBalanced
  s8. a16\fltabHTrans
  \bar "|" % 2:20

  s16 <c e>8\fltabHHold
  c16\curveEaseSlowFast s4
  \set glissandoMap = #'((0 . 1) (0 . 0))
  a4\curveEaseFastSlow
  s8
  \set glissandoMap = #'((0 . 0) (1 . 1))
  <c e>8\curveBalanced
  s4
  \bar "|" % 2:30

  s4
  s8 <b d'>16\fltabHHold <e g>16\fltabHHold
  s8 <g b>8\fltabHHold
  s16 <b d>16\fltabHHold <c, e>8\fltabHHold
  s8 <e g>16
  \bar "|" % 2:40

  %   s4*5 \bar "|" % 3:10
  %   s4*5 \bar "|" % 3:20
  %   s4*5 \bar "|" % 3:30
  %   s4*5 \bar "|" % 3:40
  %   s4*5 \bar "|" % 3:50
  %   s4*5 \bar "|" % 4:00
  %   s4*5 \bar "|" % 4:10
  %   s4*5 \bar "|" % 4:20
  %   s4*5 \bar "|" % 4:30
  %   s4*5 \bar "|" % 4:40
  %   s4*5 \bar "|" % 4:50
  %   s4*5 \bar "|" % 5:00
  %   s4*5 \bar "|" % 5:10
}
