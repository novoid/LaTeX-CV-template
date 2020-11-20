FILENAME = "main"
FIRSTNAME = "First"
LASTNAME = "Last"

## -----------------------------------------
##       DO NOT EDIT BELOW THIS LINE
## -----------------------------------------

## Makefile von Karl Voit (Karl@Voit.net)
## fuer LaTeX-Vorlagen nach Dinopolis

## (urspruengliche Fassung: Harald Krottmaier)

## some Makefile-hints taken from: 
## http://www.ctan.org/tex-archive/help/uk-tex-faq/Makefile


## COMMANDS:
PDFLATEX_CMD = pdflatex
TIMESTAMP = `/bin/date +%Y-%m-%d`
DE_TIMESTAMP_AND_PROJECT = ${TIMESTAMP}_${FIRSTNAME}_${LASTNAME}_-_Lebenslauf_deutsch.pdf
EN_TIMESTAMP_AND_PROJECT = ${TIMESTAMP}_${FIRSTNAME}_${LASTNAME}_-_CV_english.pdf
PDFVIEWER = okular

#help
#helpThe main targets of this Makefile are:
#help	help	this help
.PHONY: help
help:
	@sed -n 's/^#help//p' < Makefile

#help	all	makes the german version and the english version
.PHONY: all
all: pdfen pdfde

#help	pdfen	makes the english pdf-file
.PHONY: pdfen
pdfen: clean
	-rm -r *.aux language.tex *CV_english.pdf
	ln -s en.tex language.tex
	${PDFLATEX_CMD} ${FILENAME}
	${PDFLATEX_CMD} ${FILENAME}
	-mv ${FILENAME}.pdf ${EN_TIMESTAMP_AND_PROJECT}

#help	pdfde	makes the german pdf-file
.PHONY: pdfde
pdfde: clean
	-rm -r *.aux language.tex *Lebenslauf_deutsch.pdf
	ln -s de.tex language.tex
	${PDFLATEX_CMD} ${FILENAME}
	${PDFLATEX_CMD} ${FILENAME}
	-mv ${FILENAME}.pdf ${DE_TIMESTAMP_AND_PROJECT}

# --------------------------------------------------------

#help	view	open PDF files in reader
.PHONY: view
view:
	${PDFVIEWER} *pdf

#help	clean	clean up temporary files
.PHONY: clean
clean:
	-rm -r *.bcf *.run.xml _*_.* *~ *.aux *.bbl *.blg *.idx *.ilg *.ind *.toc *.log *.log *.brf *.out *.lof *.lot *.gxg *.glx *.gxs *.glo *.gls -f

#help	purge	cleaner than clean ;-)
.PHONY: purge
purge: clean
	-rm *.pdf *.ps -f

#help	force	force rebuild next run
.PHONY: force
force:
	touch *tex

# TOOLS:

#help	zip	create ZIP-file only of the two PDF-files(!)
.PHONY: zip
zip: clean all
	-rm cv.zip
	zip cv.zip *_${FIRSTNAME}_${LASTNAME}_-_Lebenslauf_deutsch.pdf *_${FIRSTNAME}_${LASTNAME}_-_CV_english.pdf
	unzip -l cv.zip


#end
