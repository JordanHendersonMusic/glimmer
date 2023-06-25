\version "2.21.82"
\language "english"
\include "../../util/durline_stencil_fix.ly"

\layout {
  \context {
    \Voice
    \name fltabHarmonicVoice
    \alias Voice

    \remove "Dots_engraver"
    \remove "Tuplet_engraver"
    \consists "Glissando_engraver"
    \consists "Duration_line_engraver"
    \override DurationLine.stencil = #my_duration-line::print % fix

    \omit Stem
    \omit Flag
    \omit Beam

    \override TextSpanner.padding = #3

    \override NoteHead.transparent = ##t
    \override NoteHead.no-ledgers = ##t
    \override NoteHead.stencil = #ly:text-interface::print
    \override NoteHead.text = \markup\null

    \override Glissando.thickness = #4
    \override Glissando.style = #'beam
    \override Glissando.gap = #0
    \override Glissando.padding = #0
    \override Glissando.bound-details.left.padding = #0
    \override Glissando.bound-details.right.padding = #0
    \override Glissando.breakable = ##t
    
    \override DurationLine.style = #'line
    \override DurationLine.bound-details.left.padding = #0
    \override DurationLine.bound-details.right.padding = #0
    \override DurationLine.breakable = ##t
  }

  \context {
    \Staff
    \alias Staff
    \name fltabHarmonicStaff
    \remove "Time_signature_engraver"

    \override StaffSymbol.line-positions =  #'(0)

    \override Clef.stencil = #ly:text-interface::print
    \override Clef.text = \markup\concat{
      \null \lower #1.0 
      \with-dimensions #'(0 . 3) #'(0 . 0)
      \fontsize #-1 \whiteout \pad-markup #0.5
      \concat{ \italic "F" \sans \fontsize #-8 \raise #0.125 "0" }
    }

    \accepts fltabHarmonicVoice
    \defaultchild fltabHarmonicVoice
    instrumentName = \markup\tiny"harm."
    \clef C
  }

  \context { \StaffGroup \accepts fltabHarmonicStaff }
  \context { \Score \accepts fltabHarmonicStaff }
}
