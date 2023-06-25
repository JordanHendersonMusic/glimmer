\version "2.22.2"
%% setup
\include "layoutAndPaper.ly"

%% music
\include "fingerOne.ly"
\include "fingerTwo.ly"
\include "fingerThree.ly"
%-------------------------
\include "fingerFour.ly"
\include "fingerFive.ly"
\include "fingerSix.ly"

\include "harmonicLine.ly"
\include "dynamics.ly"
\include "timeline.ly"

\header {
  tagline = ##f
  title = \markup\sans{\fontsize #8 "glimmer"}
  subtitle = \markup\normal-text\smaller"Baroque Flute, Video Projection / Video Score"
  composer = \markup\caps"Jordan Henderson"
}


\score {
  \new StaffGroup
  \with { systemStartDelimiter = #'SystemStartBar }
  <<

    \new FluteGroup
    <<
      \new fltabFingerStaff
      \with {
        \staffSize #2
        instrumentName=\markup\tiny"fingering"
      }
      <<
        \fingerOne
        \fingerTwo
        \fingerThree
        \fingerFour
        \fingerFive
        \fingerSix
      >>

      \new fltabHarmonicStaff
      \with {
        \staffSize #0
        instrumentName=\markup\tiny"harmonic"
      }
      \harmonicLine

      \new Dynamics \dynamics

    >>

    \new RhythmicStaff \with { \staffSize #-2 }
    \timeline
  >>
}
