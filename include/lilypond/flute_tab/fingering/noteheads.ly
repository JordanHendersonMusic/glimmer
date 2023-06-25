\version "2.21.82"

% names of notes you can use in \drummode{}
drumPitchNames.oneN = #'hisidestick
drumPitchNames.oneO = #'oneup
drumPitchNames.oneC = #'onedown
drumPitchNames.oneH = #'shortguiro
drumPitchNames.oneT = #'crashcymbala

drumPitchNames.twoN = #'sidestick
drumPitchNames.twoO = #'twoup
drumPitchNames.twoC = #'twodown
drumPitchNames.twoH = #'longguiro
drumPitchNames.twoT = #'crashcymbal

drumPitchNames.threeN = #'losidestick
drumPitchNames.threeO = #'threeup
drumPitchNames.threeC = #'threedown
drumPitchNames.threeH = #'guiro
drumPitchNames.threeT = #'hightom

drumPitchNames.fourN = #'acousticsnare
drumPitchNames.fourO = #'fourup
drumPitchNames.fourC = #'fourdown
drumPitchNames.fourH = #'snare
drumPitchNames.fourT = #'vibraslap

drumPitchNames.fiveN = #'hiconga
drumPitchNames.fiveO = #'fiveup
drumPitchNames.fiveC = #'fivedown
drumPitchNames.fiveH = #'lowtom
drumPitchNames.fiveT = #'ridecymbalb

drumPitchNames.sixN = #'electricsnare
drumPitchNames.sixO = #'handclap
drumPitchNames.sixC = #'hihat
drumPitchNames.sixH = #'cowbell
drumPitchNames.sixT = #'lobongo

drumPitchNames.lowK = #'acousticbassdrum





#(define-markup-command (fltab::sten::align layout props m ) (markup?)
   (interpret-markup
    layout props
    (markup
     #{  \markup{ \general-align #X #-1  \general-align #Y #0  $m } #}
     )
    ))

% markup stencils for different types of key presses, closed, half, open, and the low key
#(define-markup-command (fltab::sten::closed layout props staffSpace) (number?)
   (interpret-markup
    layout props
    (markup #:fltab::sten::align
            (markup
             #:with-dimensions (cons (- (/ staffSpace 2)) (/ staffSpace 2)) (cons (- (/ staffSpace 2)) (/ staffSpace 2))
             #:scale (cons staffSpace staffSpace)
             #:postscript "0.1 setlinewidth
                                   0.5 0 moveto
                                   0.0 0 0.5 0 361 arc
                                   fill"
             ))))

#(define-markup-command (fltab::sten::half layout props staffSpace) (number?)
   (interpret-markup
    layout props
    (markup #:fltab::sten::align
            (markup
             #:with-dimensions (cons (- (/ staffSpace 2)) (/ staffSpace 2)) (cons (- (/ staffSpace 2)) (/ staffSpace 2))
             #:scale (cons staffSpace staffSpace)
             #:postscript "0.1 setlinewidth
                      0.46 0 moveto
                      0.0 0 0.46 0 361 arc
                       stroke
                       0 0 moveto
                       0 0 0.46 45 225 arc
                       fill"

             ))))


#(define-markup-command (fltab::sten::open layout props staffSpace) (number?)
   (interpret-markup
    layout props
    (markup #:fltab::sten::align
            (markup
             #:with-dimensions (cons (- (/ staffSpace 2)) (/ staffSpace 2)) (cons (- (/ staffSpace 2)) (/ staffSpace 2))
             #:scale (cons staffSpace staffSpace)
             #:postscript "0.1 setlinewidth
                                  0.46 0 moveto
                                   0.0 0 0.46 0 361 arc
                                   stroke"

             ))))


#(define-markup-command (fltab::sten::lowK layout props staffSpace) (number?)
   (interpret-markup
    layout props
    (markup #:fltab::sten::align
            (markup  #:fontsize -1  #:italic "k" ))))




#(define (fltab::finger-stencil grob)
   (let* ((log (ly:grob-property grob 'duration-log))
          (style (ly:grob-property grob 'style))
          (space (ly:staff-symbol-staff-space grob)))
     (grob-interpret-markup
      grob
      (cond
       ((eq? style 'nullNoteHead)
        (markup #:null))
       ((eq? style 'closedkey)
        (markup #:fltab::sten::closed space))
       ((eq? style 'halfKey)
        (markup #:fltab::sten::half space))
       ((eq? style 'openKey)
        (markup #:fltab::sten::open space))
       ((eq? style 'greyClosedKey)
        (markup #:with-color grey #:fltab::sten::closed space))
       ((eq? style 'lowKey)
        (markup #:fltab::sten::lowK space))
       ))))


#(define fltab::fingeringChart
   '(
      (hisidestick	nullNoteHead	#f	6)
      (oneup 		openKey		#f	6)
      (onedown		closedkey	#f	6)
      (shortguiro	halfKey 	#f	6)
      (crashcymbala	greyClosedKey	#f	6)

      (sidestick	nullNoteHead	#f	4)
      (twoup 		openKey		#f	4)
      (twodown		closedkey 	#f	4)
      (longguiro	halfKey 	#f	4)
      (crashcymbal	greyClosedKey	#f	4)

      (losidestick 	nullNoteHead	#f	2)
      (threeup 		openKey		#f	2)
      (threedown	closedkey 	#f	2)
      (guiro		halfKey 	#f	2)
      (hightom		greyClosedKey	#f	2)

      (acousticsnare	nullNoteHead 	#f	-2)
      (fourup		openKey 	#f	-2)
      (fourdown		closedkey 	#f	-2)
      (snare		halfKey 	#f	-2)
      (vibraslap	greyClosedKey	#f	-2)

      (hiconga		nullNoteHead 	#f	-4)
      (fiveup		openKey 	#f	-4)
      (fivedown		closedkey 	#f	-4)
      (lowtom		halfKey 	#f	-4)
      (ridecymbalb	greyClosedKey	#f	-4)

      (electricsnare	nullNoteHead 	#f	-6)
      (handclap		openKey 	#f	-6)
      (hihat		closedkey 	#f	-6)
      (cowbell		halfKey 	#f	-6)
      (lobongo		greyClosedKey	#f	-6)

      (acousticbassdrum	lowKey		#f	-9)
      ))
