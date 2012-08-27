; ENUM 
; Allocating Spaces for Variables
;
;
; JOYDATASTART is the first spot after SpriteBuffer+$220
.ENUM JOYDATASTART EXPORT
Joy1Raw     	DW      ; Holder of RAW joypad data from register
Joy2Raw     	DW

Joy1Press   	DW      ; Contains only pressed buttons (not held down)
Joy2Press   	DW

Joy1Held    	DW		; Contains buttons that are Held
Joy1HeldLong	DW
Joy1HeldLonger	DW

Joy2Held    DW
Joy2HeldLong	DW
Joy2HeldLonger	DW

Joy1HeldCount	DB
Joy2HeldCount	DB


; 22 bytes $16 bytes	

; BACKGROUND VARIABLES
;.include "code/video/bg_enum.asm"
;-----------------------------------------

; What will be stored in $2105 BG_MODE
bg_mode				db

; sc_bits bits (pre_shifted) $2107-$210a
bg1_sc_address_bits 		db 
bg2_sc_address_bits		db
bg3_sc_address_bits		db
bg4_sc_address_bits		db

; sc_mapsize bits $2107-$210a
bg1_mapsize			db
bg2_mapsize			db
bg3_mapsize			db
bg4_mapsize			db

; bg CHR bits bits (not pre-shifted)
; When you update a specific BG
; It OR's its bits with the adjacent BG's CHR bits before setting $210b / $210c
bg1_chr_address_bits 	db
bg2_chr_address_bits 	db
bg3_chr_address_bits	db
bg4_chr_address_bits 	db

; I think about the benefits performance tweaks of updating completely
; the buffer before writing to the actual SNES registers
; However, currently, we write multiple (unnecessary) amount of times
; to the SNES registers. However, I'm leaving like that for now.
; The tradeoff is not large enough to consider

bg1_chr_address	dw
bg2_chr_address	dw
bg3_chr_address	dw
bg4_chr_address	dw

bg1_sc_address	dw
bg2_sc_address	dw
bg3_sc_address	dw
bg4_sc_address	dw

bg1_tilesize		db
bg2_tilesize		db
bg3_tilesize		db
bg4_tilesize		db

Cursor				dw

fontbpp				db

font_words_per_tile	dw


; bg_1_tilesize - bg4_tilesize




;
;font_chr_address_bits	db

temp1		DW
temp2		DW
temp3		DW
temp4		DW

.ende