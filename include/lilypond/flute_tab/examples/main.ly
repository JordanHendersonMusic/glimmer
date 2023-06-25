\version "2.22.2"
\language "english"

\include "../../smufl/bravura.ly"
\include "../../util/staffSize.ly"

\include "../fingering/load.ly"

\include "../harmonics/context.ly"
\include "../harmonics/extention-lines.ly"

\paper {
  ragged-bottom = ##f
  ragged-last-bottom = ##f
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








fingeringScore = \drummode {

  \time 2/4

  oneC4 twoC4 |
  oneC8 \tuplet 3/2 {threeT8 fourO8 fiveC8} fiveH8 |
  sixO8 lowK8 lowK4 |
  s4 s4 |

  oneC4\fltabKTrans s4 |
  s4... oneH32 |
  oneC2\fltabKTrans |
  <<
    { s16 oneO4..\fltabKTrans | oneH2 }
    \new fltabFingerVoice {\voiceTwo s16 twoC4..}
  >>
  <oneC twoH threeO sixH>4\fltabKTrans s4 |
  <oneC twoO lowK>4 s4 |

  <oneC twoC sixO>4\fltabKTrans s4 |
  s4 s4 |
  s4 s4 |
  s4 s4 |
  s4 s4 |
  <oneO twoO sixH>4 s4 |
  s4 twoC4 |

  oneO4\fltabKWiggle #0.0  s4 |
  oneN4\fltabKWiggle #0.2  s4 |
  oneC4\fltabKWiggle #0.8  s4 |
  oneN4\fltabKWiggle #0.3  s4 |
  oneN4\fltabKWiggle #0.0  s4 |


  <<
    { oneH2 }
    \new fltabFingerVoice {
      \voiceTwo
      fiveC4\fltabKWiggle #0.0  s4 |
      fiveN4\fltabKWiggle #0.2  s4 |
      fiveN4\fltabKWiggle #0.8  s4 |
      fiveN4.\fltabKWiggle #1.0 fiveN8\fltabKWiggle #0.0 |
      fiveN4\fltabKWiggle #0.1 s4 |
      fiveN4\fltabKWiggle #0.3 s4 |
    }
  >>

  <<
    {
      fiveC8.\fltabKTrans s16 s4  |
      s8. fiveH16 fiveC4\fltabKTrans   |
      s2 |
      fiveH2       |
    }
    \new fltabFingerVoice {
      \voiceOne
      oneC4\fltabKTrans s4 |
      s4.. oneH16 |
      oneC2\fltabKTrans |
      s8 oneO4. |
    }
    \new fltabFingerVoice {
      \voiceOne
      twoC4\fltabKWiggle #0.0 s4 |
      twoN4\fltabKWiggle #0.2 s4 |
      s8.. twoN32\fltabKWiggle #0.8 s4 |
      twoN4\fltabKWiggle #0.3 s4 |
    }
  >>
}

#(define show-debug-info #t)
\header{
    tagline = ##f
}
\score {
  \new StaffGroup
  <<


    \new fltabFingerStaff
    %\with { \staffSize #2 \override NoteHead.stem-attachment = #'(1.007 . 0.32) }
    \fingeringScore

    \new fltabHarmonicStaff \with {\staffSize #1 }
    \relative c'{
      c2\fltabHTrans
      a2\fltabHCurveLong #'((1 . 0.5) (0.2 . 0.8) (0.25 . -0.5) (0.5 . 0.0)) #show-debug-info
      s2
      e'2\fltabHHold e2\fltabHHold |
      \fltabHShowLedgersUpTo g <d' b>2\fltabHHold |
      d4\fltabHHold d4\fltabHTrans
      s8 c,8\fltabHHold c'4\fltabHHold |
      c2\fltabHCurveLong #'((0.3 . 0) (2 . -1.56) (0.3 . 1.5) (0 . 0.14)) #show-debug-info
      s2 s2
      s2 s2
      s2 s2
      s2 s2
      s2 s2
      s2
      g'2\fltabHHold
      g2\fltabHHold
      f2\fltabHHold
      f

    }

  >>
}
