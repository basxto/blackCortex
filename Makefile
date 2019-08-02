convert=convert -define bmp:format=bmp3
montage=montage
title=Base.rte/Title/
texture=Base.rte/Scenes/Textures
palette= -dither FloydSteinberg -remap Base.rte/palette.bmp 

.PHONY: build
build: palette_gen build_titles build_textures

.PHONY: build16
build16: palette_16 build_titles build_textures

.PHONY: builddb16
builddb16: palette_db16 build_titles build_textures

.PHONY: build_titles
build_titles: $(title)/Planet.bmp $(title)/Moon.bmp $(title)/Title.bmp $(title)/Nebula.bmp

.PHONY: build_textures
build_textures: $(texture)/Water.bmp $(texture)/Soil.bmp $(texture)/Snow.bmp $(texture)/Sand.bmp $(texture)/RockRed.bmp $(texture)/RockDarkRed.bmp $(texture)/RockBlack.bmp  $(texture)/Ice.bmp  $(texture)/Grass.bmp $(texture)/DirtRough.bmp $(texture)/DirtMedium.bmp $(texture)/DirtFine.bmp $(texture)/DirtDark.bmp

.PHONY: palette_gen
palette_gen: $(texture)/Water_128.bmp $(texture)/Soil_128.bmp $(texture)/Snow_128.bmp $(texture)/Sand_128.bmp $(texture)/RockRed_128.bmp $(texture)/RockDarkRed_128.bmp $(texture)/RockBlack_128.bmp  $(texture)/Ice_128.bmp  $(texture)/Grass_128.bmp $(texture)/DirtRough_128.bmp $(texture)/DirtMedium_128.bmp $(texture)/DirtFine_128.bmp $(texture)/DirtDark_128.bmp $(title)/Planet.png $(title)/Moon.png $(title)/Title.png $(title)/Nebula.png
	$(montage) $^ -background black -geometry +0+0 Base.rte/palette.bmp
	$(convert) Base.rte/palette.bmp -dither FloydSteinberg -colors 256 -unique-colors -crop 16x16 -append Base.rte/palette.bmp
	$(convert) -define bmp:format=bmp3 -type palette Base.rte/palette.bmp Base.rte/palette.bmp

# will only have 16 colors from db16
.PHONY: palette_16
palette_16:
	cp Base.rte/palette16.bmp Base.rte/palette.bmp

# 255 colors with dawn bringer 16 in it
.PHONY: palette_db16
palette_db16:
	cp Base.rte/palette255_db16.bmp Base.rte/palette.bmp

.PRECIOUS: $(title)%Alpha.bmp
$(title)%Alpha.bmp: $(title)%.png
	$(convert) -alpha extract -type palette "$<" "$@"

$(title)%.bmp: $(title)%.png | Base.rte/palette.bmp $(title)/%Alpha.bmp
	$(convert) -background black -flatten "$<" "$@"
	#$(convert) "$@" $(palette) "$@"
	
$(texture)%_128.bmp: $(texture)%.png
	$(convert) -resize 128x128 "$<" "$@"

$(texture)%_128.bmp: $(texture)%.jpg
	$(convert) -resize 128x128 "$<" "$@"

$(texture)%.bmp: $(texture)%_128.bmp | Base.rte/palette.bmp
	$(convert) -type palette "$<" $(palette) "$@"

.PHONY: clean
clean:
	rm Base.rte/palette.bmp
	rm $(title)/Planet{,Alpha}.bmp $(title)/Moon{,Alpha}.bmp $(title)/Title{,Alpha}.bmp
	rm $(texture)/*_128.bmp
	rm $(texture)/Water.bmp $(texture)/Soil.bmp $(texture)/Snow.bmp $(texture)/Sand.bmp $(texture)/RockRed.bmp $(texture)/RockDarkRed.bmp $(texture)/RockBlack.bmp  $(texture)/Ice.bmp  $(texture)/Grass.bmp $(texture)/DirtRough.bmp $(texture)/DirtMedium.bmp $(texture)/DirtFine.bmp $(texture)/DirtDark.bmp
