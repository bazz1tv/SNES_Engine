;.include "code/video/bg/bg_equates.inc"
;------------------------
; SC Bits : $2107 - $210A
;------------------------
; first 2 bits decide map size
; 00 = 32x32	01=64x32
; 10 = 32x64	11=64x64

;  See SNES-Manual A-14
;
; the other bits are multiples of $400
; that decide VRAM location for Tilemap SC Data



; EQU's that will probably be necessary'
;-----------------------------------------
; bg_mode
; bg1_sc_location - bg4_sc_location
; bg1_chr_location - bg4_sc_location
; bg_1_tilesize - bg4_tilesize

;;;
;; ---------------
;; -------------
;;     -----
;;;
; SetBGMode ----
.macro SetBGMode
	lda #\1
	sta bg_mode
.endm

.macro UpdateBGMode
	lda bg_mode
	sta $2105
.endm

;UpdateBG1
; - UpdateBG1SC
; - UpdateBG1CHR
.macro UpdateBG1CHR
	lda bg2_chr_location
	asl
	asl
	asl
	asl
	ora bg1_chr_location
	;ora $210B
	sta $210B
.endm

.macro UpdateBG1SC
	lda bg1_sc_location
	ora bg1_mapsize
	sta $2107
.endm

.macro UpdateBG1
	UpdateBG1SC
	UpdateBG1CHR
.endm

;UpdateBG2
; - UpdateBG2SC
; - UpdateBG2CHR
.macro UpdateBG2CHR
	lda bg2_chr_location
	asl
	asl
	asl
	asl
	ora bg1_chr_location
	sta $210B
.endm

.macro UpdateBG2SC
	lda bg2_sc_location
	ora bg2_mapsize
	sta $2108
.endm

.macro UpdateBG2
	UpdateBG2SC
	UpdateBG2CHR
.endm

;UpdateBG3
; - UpdateBG3SC
; - UpdateBG3CHR
.macro UpdateBG3CHR
	lda bg4_chr_location
	asl
	asl
	asl
	asl
	ora bg3_chr_location
	sta $210C
.endm

.macro UpdateBG3SC
	lda bg3_sc_location
	ora bg3_mapsize
	sta $2109
.endm

.macro UpdateBG3
	UpdateBG3SC
	UpdateBG3CHR
.endm

;UpdateBG4
; - UpdateBG4SC
; - UpdateBG4CHR
.macro UpdateBG4CHR
	lda bg4_chr_location
	asl
	asl
	asl
	asl
	ora bg3_chr_location
	sta $210C
.endm

.macro UpdateBG4SC
	lda bg4_sc_location
	ora bg4_mapsize
	sta $210A
.endm

.macro UpdateBG4
	UpdateBG4SC
	UpdateBG4CHR
.endm
;;;
;;
; UpdateAllBG
.macro UpdateALLBG
	UpdateBG1
	UpdateBG2
	UpdateBG3
	UpdateBG4
.endm

; SetBG1SC $2107 SetBG1TilemapSize
; SetBG2SC $2108 SetBG2TilemapSize
; SetBG3SC $2109 SetBG3TilemapSize
; SetBG4SC $210A SetBG4TileMapSize
.macro SetBG1MapSize
	lda #\1
	sta bg1_mapsize
.endm

.macro SetBG2MapSize
	lda #\1
	sta bg2_mapsize
.endm

.macro SetBG3MapSize
	lda #\1
	sta bg3_mapsize
.endm

.macro SetBG4MapSize
	lda #\1
	sta bg4_mapsize
.endm

; \1 : sc_0 -> sc_4c00  : redefine more.. ? 
; \2 : tilemapsize : map32x32, map .. .  .
.macro SetBG1SC
	lda #\1
	sta bg1_sc_location
.endm

; \1 : sc_0 -> sc_4c00  : redefine more.. ? 
; \2 : tilemapsize : map32x32, map .. .  .
.macro SetBG2SC
	lda #\1
	sta bg2_sc_location
.endm

; \1 : sc_0 -> sc_4c00  : redefine more.. ? 
; \2 : tilemapsize : map32x32, map .. .  .
.macro SetBG3SC
	lda #\1
	sta bg3_sc_location
.endm

; \1 : sc_0 -> sc_4c00  : redefine more.. ? 
; \2 : tilemapsize : map32x32, map .. .  .
.macro SetBG4SC
	lda #\1
	sta bg4_sc_location
.endm


; SetBG1CHR - $210B
; SetBG2CHR /
; SetBG3CHR - $210C
; SetBG4CHR /
;------------------------
; CHR bits $210B/$210C
;------------------------
; Bits are multiples of $1000 to select CHR locations

; \1  : chr_0 -> chr_7000
.macro SetBG1CHR
	lda #\1
	sta bg1_chr_location
.endm
; \1  : chr_0 -> chr_7000
.macro SetBG2CHR
	lda #\1
	sta bg2_chr_location
.endm
; \1  : chr_0 -> chr_7000
.macro SetBG3CHR
	lda #\1
	sta bg3_chr_location
.endm
; \1  : chr_0 -> chr_7000
.macro SetBG4CHR
	lda #\1
	sta bg4_chr_location
.endm

; SetBG1 SC_location, mapsize, chr_location
.macro SetBG1
	.redefine sc_loc \1 
	.redefine mapsize \2 
	.redefine chr_loc \3 
	
	SetBG1SC sc_loc
	SetBG1MapSize mapsize
	SetBG1CHR chr_loc
.endm

; SetBG2 SC_location, mapsize, chr_location
.macro SetBG2
	.redefine sc_loc \1 
	.redefine mapsize \2 
	.redefine chr_loc \3
	
	SetBG2SC sc_loc
	SetBG2MapSize mapsize
	SetBG2CHR chr_loc
.endm

; SetBG3 SC_location, mapsize, chr_location
.macro SetBG3
	.redefine sc_loc \1 
	.redefine mapsize \2 
	.redefine chr_loc \3
	
	SetBG3SC sc_loc
	SetBG3MapSize mapsize
	SetBG3CHR chr_loc
.endm

; SetBG4 SC_location, mapsize, chr_location
.macro SetBG4
	.redefine sc_loc \1 
	.redefine mapsize \2 
	.redefine chr_loc \3
	
	SetBG4SC sc_loc
	SetBG4MapSize mapsize
	SetBG4CHR chr_loc
.endm
; All these communicate with $212C 
; But that doesn't include SubScreen'
; .redefine ON 1
; .redefine OFF 0
; BG1_MainScreen [On/Off]
; BG2_MainScreen  .. 
; BG3_MainScreen  .. 
; BG4_MainScreen  .. 

; All of these macros expect 
; Accum 8 bit

