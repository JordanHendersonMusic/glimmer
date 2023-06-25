\version "2.21.82"
\include "include/lilypond/hairpin_text/load.ly"

dynamics = {
  \override Hairpin.circled-tip = ##t
  
  
  s8 s8\!\hairtxtCresc #"poco a poco" 
  s2
  \override Hairpin.circled-tip = ##f
  s4\p\>
  s4
  \bar "|" % 0:10

  s4\ppp
  s8 s8\<
  s8.  s16\mf
  s64 s8...\ppp
  s4
  \bar "|" % 0:20

  s4*5 \bar "|" % 0:30

  s4\!\<
  s32 s8..\p\>
  s8 s8\ppp\<
  s4
  s4\mf
  \bar "|" % 0:40

  s8 s8\>
  s8. s16\p\hairtxtCresc #"poco a poco"
  s4*3
  \bar "|" % 0:50

  s4\f\>
  s16 s8.\pp
  s4
  s2\<
  \bar "|" % 1:00

  s4
  s4\sf
  s8 s8\>
  s8 s8\mp
  s4
  \bar "|" % 1:10

  s2\>  s2.\ppp
  \bar "|" % 1:20

  s4*5 \bar "|" % 1:30

  s4*3
  s8 s8\<
  s8\mf\> s8
  \bar "|" % 1:40

  s4\!\hairtxtCresc #"explosive"
  s8 s8\ff
  s4
  s8. s16\>
  s4
  \bar "|" % 1:50

  s4
  s2\mp
  s2\<
  \bar "|" % 2:00

  s2\mf
  s8 s8
  s4\fff
  s8. s16\ppp\<
  \bar "|" % 2:10

  s16 s8.\f
  s16 s8.\p\<
  s4
  s16\ff s8.\>
  s8 s8\pp\<
  \bar "|" % 2:20

  s16 s8\f\> s16
  s4
  s2.\p\<
  \bar "|" % 2:30

  s4*4
  s4\fff
  \bar "|" % 2:40

}