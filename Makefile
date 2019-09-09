ifeq ($(OS),Windows_NT) 
 convert=imagemagick\convert.exe
 montage=imagemagick\montage.exe
 cp=copy /Y
 rm=del /Q
else
 convert::=$(shell command -v convert 2> /dev/null)
 montage::=$(shell command -v montage 2> /dev/null)
 cp=cp
 rm=rm
 ifndef convert
  $(error "convert is not available, please install imagemagick")
 endif
 ifndef montage
  $(error "montage is not available, please install imagemagick")
 endif
endif

base=Base.rte/
title=$(base)Title/
skin=$(base)GUIs/Skins/
mainskin=$(skin)MainMenu/
baseskin=$(skin)Base/
texture=$(base)Scenes/Textures/
palette= -dither FloydSteinberg -remap "$(base)palette.bmp"
textures=Water Soil Snow Sand RockRed RockDarkRed RockBlack Ice Grass DirtRough DirtMedium DirtFine DirtDark
titles=Planet Moon Title Nebula
skins=Cursive1 goldgui NeoSans pointer resize text tom_thumb_shadow Corsive2

# BMP3 is BMP with a palette
convert+= -define bmp:format=bmp3

.PHONY: cc
all: palette_cc titles skins

.PHONY: 16
16: palette_16 titles skins

.PHONY: db16
db16: palette_db16 titles skins

.PHONE: gen
cc: palette_gen titles skins

.PHONY: titles
titles: $(foreach img,$(titles),$(title)$(img).bmp)

.PHONY: textures
textures: $(foreach img,$(textures),$(texture)$(img).bmp)

.PHONY: skins
skins: $(foreach img,$(skins),$(mainskin)$(img).bmp)

.PHONY: palette_gen
palette_gen: $(foreach img,$(textures),$(texture)$(img)_128.bmp) $(foreach img,$(titles),$(title)$(img).png)
	$(montage) $^ -background black -geometry +0+0 "$(base)palette.bmp"
	$(convert) $(base)palette.bmp -dither FloydSteinberg -colors 256 -unique-colors -crop 16x16 -append "$(base)palette.bmp"
	$(convert) -type palette "$(base)palette.bmp" "$(base)palette.bmp"

# will only have 16 colors from db16
.PHONY: palette_16
palette_16:
	$(cp) "$(base)palette16.bmp" "$(base)palette.bmp"

# 255 colors with dawn bringer 16 in it
.PHONY: palette_db16
palette_db16:
	$(cp) "$(base)palette255_db16.bmp" "$(base)palette.bmp"

# palette of Cortex Command
.PHONY: palette_cc
palette_cc:
	$(cp) "$(base)palette_cc.bmp" "$(base)palette.bmp"

.PRECIOUS: $(title)%Alpha.bmp
$(title)%Alpha.bmp: $(title)%.png
	$(convert) -alpha extract "$<" "$@"

$(title)%.bmp: $(title)%.png | $(base)palette.bmp $(title)%Alpha.bmp
	$(convert) -background black -flatten "$<" "$@"
#	$(convert) "$@" $(palette) "$@"
	
$(texture)%_128.bmp: $(texture)%.png
	$(convert) -resize 128x128 "$<" "$@"

$(texture)%_128.bmp: $(texture)%.jpg
	$(convert) -resize 128x128 "$<" "$@"

$(texture)%.bmp: $(texture)%_128.bmp | $(base)palette.bmp
	$(convert) -type palette "$<" $(palette) "$@"

# main menu needs true color versions
$(mainskin)%.bmp: $(baseskin)%.bmp
	$(convert) "$<" -colorspace rgb -type truecolor "$@"

.PHONY: clean
clean:
# del does not support unix paths
	cd "$(base)" && $(rm) "palette.bmp"
	cd "$(title)" && $(rm) $(foreach img,$(titles),"$(img).bmp")
	cd "$(title)" && $(rm) $(foreach img,$(titles),"$(img)Alpha.bmp")
	cd "$(texture)" && $(rm) $(foreach img,$(textures),"$(img)_128.bmp")
	cd "$(mainskin)" && $(rm) $(foreach img,$(skins),"$(img).bmp")
