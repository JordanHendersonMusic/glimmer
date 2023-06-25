\version "2.22.2"
\language "english"

\include "../../smufl/bravura.ly"
\include "../../util/staffSize.ly"

\include "../fingering/load.ly"

\include "../harmonics/context.ly"
\include "../harmonics/extention-lines.ly"

\paper {
  ragged-right = ##f
}
\layout{
  \context{
    \Score
    \bravuraOn % not necessary, but will produce warning if not enabled.
    proportionalNotationDuration = #(ly:make-moment 1/9) % probably want this

    \override SpacingSpanner.uniform-stretching = ##f
    \override SpacingSpanner.strict-grace-spacing = ##f
    \override SpacingSpanner.strict-note-spacing = ##f

    \override PaperColumn.used = ##t
    \override BarLine.break-visibility = ##(#t #f #f)
  }
}

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
   #{ \fltabHCurveLong #'((0.15 . 0.0) (0.2 . 0.9) (0.6 . 0.15) (0.4 . 1)) #show-debug-info #})

\score {
  \new StaffGroup
  <<
    \new fltabFingerStaff 
    \drummode {
      \time 4/4
      oneC2.. \fltabKTrans oneO8 |
      <<
       \new fltabFingerVoice { \voiceTwo <oneC twoC>2.\fltabKTrans  <oneO twoO>4 | }
       \new fltabFingerVoice { \voiceTwo <fourH fiveC sixH>4\fltabKTrans  <fourO fiveH sixC>2. | }
       \new fltabFingerVoice { \voiceTwo \afterGrace threeC1\fltabKWiggle #0.1 threeN | }
      >>
    }
    
    \new fltabHarmonicStaff \with {\staffSize #1 }
    \relative c'{
      c4\ppp\<\fltabHHold c4\fltabHTrans a2\fltabHHold |
      a4.\curveExp b'8\fltabHHold \afterGrace a,2\curveEaseSlowFast b'2\f
    }

  >>
}