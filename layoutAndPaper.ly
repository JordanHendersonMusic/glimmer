\version "2.22.2"
%external includes
\include "include/lilypond/util/staffSize.ly"
\include "include/lilypond/smufl/bravura.ly"
\include "include/lilypond/flute_tab/load.ly"

#(set! paper-alist
  (cons '("longer arse score" . (cons (* 80 in) (* 6 in))) paper-alist))


%#(ly:set-option 'crop #t)
#(set-default-paper-size "a4" 'landscape)

\paper {
  %#(set-paper-size "longer arse score")

  #(layout-set-staff-size 22)
  print-page-number = ##f
  ragged-bottom = ##f
  ragged-right = ##f
  ragged-last-bottom = ##f

  % If these aren't installed then comment these lines out
  fonts.roman ="Fraunces 72pt Soft"
  fonts.sans = "Josefin Sans"
  fonts.typewriter = "Luxi Mono"
}

\layout{
  \context {
    \Score
    \bravuraOn
    proportionalNotationDuration = #(ly:make-moment 1/16)
    \override SpacingSpanner.uniform-stretching = ##t
    \override SpacingSpanner.strict-grace-spacing = ##t
    \override SpacingSpanner.strict-note-spacing = ##t
    \override MetronomeMark.outside-staff-priority = #999999
    \override MetronomeMark.padding = #2
    \override BarNumber.stencil = ##f
    \override BarLine.break-visibility = ##(#t #f #f)
    
    \override MetronomeMark.font-size = #1
    \override MetronomeMark.font-family = #'sans
    \override MetronomeMark.font-shape = #'upright
    \override MetronomeMark.font-series = #'normal
    \override MetronomeMark.padding = #0
  }

  \context {
    \StaffGroup
    \name FluteGroup
    \alias StaffGroup
    instrumentName = \markup{\null \raise #1 "Baroque Flute"}
    systemStartDelimiter = #'SystemStartBrace
  }
  \context {  \StaffGroup \accepts FluteGroup }

  \context {
    \RhythmicStaff
    \remove "Clef_engraver"
    \remove "Time_signature_engraver"
    \remove "Ledger_line_engraver"
    \override TextScript.outside-staff-priority = ##f
    \override TextScript.extra-offset = #'(0 . -0.5)
    instrumentName = \markup\tiny "Timeline"
    \override BarLine.bar-extent = #'(0 . 0)
  }

  \context {
    \Dynamics
    \dynamicDown
    \override DynamicLineSpanner.staff-padding = #-3
    \override VerticalAxisGroup.nonstaff-relatedstaff-spacing =
    #'((basic-distance . 0) (padding . 1.5))
    
    \override Hairpin.font-shape = #'italic
  }

  \context {
    \fltabHarmonicStaff
    \override DurationLine.thickness = #4.5
    \override TextSpanner.font-shape = #'upright
    \override TextSpanner.font-family = #'sans
  }

}

