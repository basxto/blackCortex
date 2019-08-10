convert::=$(shell command -v convert 2> /dev/null)
montage::=$(shell command -v montage 2> /dev/null)
title=Base.rte/Title/
skin=Base.rte/GUIs/Skins
texture=Base.rte/Scenes/Textures
palette= -dither FloydSteinberg -remap Base.rte/palette.bmp 
textures=Water Soil Snow Sand RockRed RockDarkRed RockBlack Ice Grass DirtRough DirtMedium DirtFine DirtDark
titles=Planet Moon Title Nebula
skins=Cursive1 goldgui NeoSans pointer resize text tom_thumb_shadow

ifndef convert
$(error "convert is not available, please install imagemagick")
else
# BMP3 is BMP with a palette
convert+= -define bmp:format=bmp3
endif

ifndef montage
$(error "montage is not available, please install imagemagick")
endif

.PHONY: cc
all: palette_cc titles textures skins

.PHONY: 16
16: palette_16 titles textures skins

.PHONY: db16
db16: palette_db16 titles textures skins

.PHONE: gen
cc: palette_gen titles textures skins

.PHONY: titles
titles: $(foreach img,$(titles),$(title)/$(img).bmp)

.PHONY: textures
textures: $(foreach img,$(textures),$(texture)/$(img).bmp)

.PHONY: skins
skins: $(foreach img,$(skins),$(skin)/MainMenu/$(img).bmp)

.PHONY: palette_gen
palette_gen: $(foreach img,$(textures),$(texture)/$(img)_128.bmp) $(foreach img,$(titles),$(title)/$(img).png)
	$(montage) $^ -background black -geometry +0+0 Base.rte/palette.bmp
	$(convert) Base.rte/palette.bmp -dither FloydSteinberg -colors 256 -unique-colors -crop 16x16 -append Base.rte/palette.bmp
	$(convert) -type palette Base.rte/palette.bmp Base.rte/palette.bmp

# will only have 16 colors from db16
.PHONY: palette_16
palette_16:
	cp Base.rte/palette16.bmp Base.rte/palette.bmp

# 255 colors with dawn bringer 16 in it
.PHONY: palette_db16
palette_db16:
	cp Base.rte/palette255_db16.bmp Base.rte/palette.bmp

# palette of Cortex Command
.PHONY: palette_cc
palette_cc:
	cp Base.rte/palette_cc.bmp Base.rte/palette.bmp

.PRECIOUS: $(title)%Alpha.bmp
$(title)%Alpha.bmp: $(title)%.png
	$(convert) -alpha extract "$<" "$@"

$(title)%.bmp: $(title)%.png | Base.rte/palette.bmp $(title)/%Alpha.bmp
	$(convert) -background black -flatten "$<" "$@"
#	$(convert) "$@" $(palette) "$@"
	
$(texture)%_128.bmp: $(texture)%.png
	$(convert) -resize 128x128 "$<" "$@"

$(texture)%_128.bmp: $(texture)%.jpg
	$(convert) -resize 128x128 "$<" "$@"

$(texture)%.bmp: $(texture)%_128.bmp | Base.rte/palette.bmp
	$(convert) -type palette "$<" $(palette) "$@"

# main menu needs true color versions
$(skin)/MainMenu/%.bmp: $(skin)/Base/%.bmp
	$(convert) "$<" -colorspace rgb -type truecolor "$@"

.PHONY: clean
clean:
	rm Base.rte/palette.bmp
	rm $(foreach img,$(titles),$(title)/$(img).bmp)
	rm $(foreach img,$(titles),$(title)/$(img)Alpha.bmp)
	rm $(foreach img,$(textures),$(texture)/$(img).bmp)
	rm $(foreach img,$(textures),$(texture)/$(img)_128.bmp)
	rm $(foreach img,$(skins),$(skin)/MainMenu/$(img).bmp)
