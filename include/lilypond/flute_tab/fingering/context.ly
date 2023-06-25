\version "2.21.82"
\include "noteheads.ly"
\include "./util/colour-staff-lines.ly"
\include "../../util/durline_stencil_fix.ly"

\layout{
  \context{
    \DrumVoice
    \name fltabFingerVoice
    \alias DrumVoice

    \consists "Pitch_squash_engraver"
    \consists "Duration_line_engraver"
           
    \override DurationLine.stencil = #my_duration-line::print % fix
    \override DurationLine.to-barline = ##f

    \remove "Dots_engraver"
    %\remove "Clef_engraver"
    \override Clef.stencil = ##f

    \omit Stem
    \omit Flag
    \omit Beam
    \omit TupletBracket
    \omit TupletNumber
    
    \remove "Forbid_line_break_engraver"

    \override NoteHead.stencil = #fltab::finger-stencil
    %\override NoteHead.attachment
    drumStyleTable = #(alist->hash-table fltab::fingeringChart)
  }

  \context {
    \DrumStaff
    \alias Staff
    \name fltabFingerStaff

    \remove "Separating_line_group_engraver"

    \remove "Time_signature_engraver"
    \remove "Ledger_line_engraver"

    \accepts fltabFingerVoice
    \remove "Clef_engraver"

    \override StaffSymbol.line-positions =  #'( -7 0 7 )
    \override StaffSymbol.stencil = #(color-staff-lines white black white)

    \defaultchild fltabFingerVoice
    \stemDown % important! needed to align keys in chords

    instrumentName = \markup\tiny"keys"

  }

  \context {
    \StaffGroup
    \accepts fltabFingerStaff
  }

  \context {
    \Score
    \accepts fltabFingerStaff
  }
}
