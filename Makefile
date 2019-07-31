convert=convert -define bmp:format=bmp3
title=Base.rte/Title/

.PHONY: build
build: $(title)/Planet.bmp $(title)/PlanetAlpha.bmp $(title)/Moon.bmp $(title)/MoonAlpha.bmp $(title)/Title.bmp $(title)/TitleAlpha.bmp

%Alpha.bmp: %.png
	$(convert) -alpha extract  "$<" "$@"

%.bmp: %.png | %Alpha.bmp
	$(convert) -background black -flatten  "$<" "$@"

.PHONY: clean
clean:
	rm $(title)/Planet{,Alpha}.bmp $(title)/Moon{,Alpha}.bmp $(title)/Title{,Alpha}.bmp
