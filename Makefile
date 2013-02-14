# make

R = cpp_style
STY = *.sty

pdf: $(R).pdf

$(R).bbl: *.bib
	pdflatex $(R)
	bibtex $(R)
	pdflatex $(R)

$(R).pdf: *.tex $(STY) $(R).bbl
	pdflatex $(R)
	pdflatex $(R)

clean:
	rm -f *.aux *.bbl *.blg *.lof *.log *.lot *.toc *.brf *.nav *.out *.snm *.dvi *.ps *.backup *~
