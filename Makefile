convert=convert -define bmp:format=bmp3
title=Base.rte/Title/
texture=Base.rte/Scenes/Textures

.PHONY: build
build: build_titles build_textures

.PHONY: build_titles
build_titles: $(title)/Planet.bmp $(title)/PlanetAlpha.bmp $(title)/Moon.bmp $(title)/MoonAlpha.bmp $(title)/Title.bmp $(title)/TitleAlpha.bmp

.PHONY: build_textures
build_textures: $(texture)/Water.bmp $(texture)/Soil.bmp $(texture)/Snow.bmp $(texture)/Sand.bmp $(texture)/RockRed.bmp $(texture)/RockDarkRed.bmp $(texture)/RockBlack.bmp  $(texture)/Ice.bmp  $(texture)/Grass.bmp $(texture)/DirtRough.bmp $(texture)/DirtMedium.bmp $(texture)/DirtFine.bmp $(texture)/DirtDark.bmp

$(title)%Alpha.bmp: $(title)%.png
	$(convert) -alpha extract  "$<" "$@"

$(title)%.bmp: $(title)%.png | $(title)%Alpha.bmp
	$(convert) -background black -flatten  "$<" "$@"

$(texture)%.bmp: $(texture)%.jpg
	$(convert) -resize 128x128 "$<" "$@"

$(texture)%.bmp: $(texture)%.png
	$(convert) -resize 128x128 "$<" "$@"

.PHONY: clean
clean:
	rm $(title)/Planet{,Alpha}.bmp $(title)/Moon{,Alpha}.bmp $(title)/Title{,Alpha}.bmp
	rm $(texture)/Water.bmp $(texture)/Soil.bmp $(texture)/Snow.bmp $(texture)/Sand.bmp $(texture)/RockRed.bmp $(texture)/RockDarkRed.bmp $(texture)/RockBlack.bmp  $(texture)/Ice.bmp  $(texture)/Grass.bmp $(texture)/DirtRough.bmp $(texture)/DirtMedium.bmp $(texture)/DirtFine.bmp $(texture)/DirtDark.bmp
