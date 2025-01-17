VERSION = "NiPreps_BRAIN_Nov2022"


all: render-talk render-site render-pdf

render-talk:
	-git rm -rf docs/talk/*
	cd talk && quarto render talk.qmd
	# fix quarto bug
	# need to use sed inline mode
	-git add docs/talk/*
	-git add docs/talk/images/*
	-git add talk/images/*
	# sed -i.bak 's-LICENSE-talk-' docs/talk/index.html
	git commit -a -m"updating changed files"
	git push origin main

render-site:
	-rm docs/index.html
	git commit -a -m"updating site files"
	cd site && quarto render index.qmd
	git add docs/*
	git commit -m"updating changed files"
	git push origin main

render-pdf:
	-mkdir docs/pdfs
	decktape reveal docs/talk/talk.html docs/pdfs/$(VERSION).pdf
	git add docs/pdfs/$(VERSION).pdf
	git commit -m"adding pdf [skip ci]"
	git push origin main

