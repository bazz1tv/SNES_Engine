; All of these macros expect 
; Accum 8 bit


; EQU's 
;-----------------------------------------
; bg_mode
; bg1_sc_address_bits - bg4_sc_address_bits
; bg1_chr_address_bits - bg4_chr_address_bits
; bg1_tilesize - bg4_tilesize
; bg1_mapsize - bg4_mapsize


; SetBGMode ----
; Store \1 into bg_mode and $2105
.macro SetBGMode
	lda #\1
	sta bg_mode
	sta $2105
.endm

; UpdateBGMode
; Takes bg_mode and sets into $2105
.macro UpdateBGMode
	lda bg_mode
	sta $2105
.endm

; UpdateBG1CHR
; ------------
; loads bg2+bg1 chr address bits
; and loads into $210B
.macro UpdateBG1CHR
	lda bg2_chr_address_bits
	asl
	asl
	asl
	asl
	ora bg1_chr_address_bits
	sta $210B
.endm

; UpdateBG1SC
; ------------
; loads bg1_sc_address_bits
; ORS them with the mapsize
; and loads into $2107
.macro UpdateBG1SC
	lda bg1_sc_address_bits
	ora bg1_mapsize
	sta $2107
.endm

; UpdateBG1
.macro UpdateBG1
	UpdateBG1SC
	UpdateBG1CHR
.endm

;-------------
; We repeat the same functions
; for BG2 - BG4 now....
;-----------------------
;bg2
;-----
.macro UpdateBG2CHR
	lda bg2_chr_address_bits
	asl
	asl
	asl
	asl
	ora bg1_chr_address_bits
	sta $210B
.endm

.macro UpdateBG2SC
	lda bg2_sc_address_bits
	ora bg2_mapsize
	sta $2108
.endm

.macro UpdateBG2
	UpdateBG2SC
	UpdateBG2CHR
.endm

;bg3 
;-----------
.macro UpdateBG3CHR
	lda bg4_chr_address_bits
	asl
	asl
	asl
	asl
	ora bg3_chr_address_bits
	sta $210C
.endm

.macro UpdateBG3SC
	lda bg3_sc_address_bits
	ora bg3_mapsize
	sta $2109
.endm

.macro UpdateBG3
	UpdateBG3SC
	UpdateBG3CHR
.endm

;bg4
;-------------
.macro UpdateBG4CHR
	lda bg4_chr_address_bits
	asl
	asl
	asl
	asl
	ora bg3_chr_address_bits
	sta $210C
.endm

.macro UpdateBG4SC
	lda bg4_sc_address_bits
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

; SetBGxMapSize
;---------------
; Sets \1 into bgx_mapsize
; ORS the mapsize bits with 
; bgx_sc_address_bits
; and stores into $210x
;----------------------
.macro SetBG1MapSize
	lda #\1
	sta bg1_mapsize
	ora bg1_sc_address_bits
	sta $2107
.endm

.macro SetBG2MapSize
	lda #\1
	sta bg2_mapsize
	ora bg2_sc_address_bits
	sta $2108
.endm

.macro SetBG3MapSize
	lda #\1
	sta bg3_mapsize
	ora bg3_sc_address_bits
	sta $2109
.endm

.macro SetBG4MapSize
	lda #\1
	sta bg4_mapsize
	ora bg4_sc_address_bits
	sta $210a
.endm

; SetBGxSC
;----------
; \1 : sc_0 -> sc_7c00  
; \2 : tilemapsize | ie. map32x32,
; stores to $210x

;bg1
;----
.macro SetBG1SC
	lda #\1
	sta bg1_sc_address_bits
	xba
	lda #\2
	sta bg1_mapsize
	xba
	ora #\2
	sta $2107
.endm

;bg2
;-----
.macro SetBG2SC
	lda #\1
	sta bg2_sc_address_bits
	xba
	lda #\2
	sta bg2_mapsize
	xba
	ora #\2
	sta $2108
.endm

;bg3
;-----
.macro SetBG3SC
	lda #\1
	sta bg3_sc_address_bits
	xba
	lda #\2
	sta bg3_mapsize
	xba
	ora #\2
	sta $2109
.endm

;bg4
;-------
.macro SetBG4SC
	lda #\1
	sta bg4_sc_address_bits
	xba
	lda #\2
	sta bg4_mapsize
	xba
	ora #\2
	sta $210a
.endm


; Non-BG Specific Support Macro
; SAFE function (it operates in 8-bit mode)
; It's safe to use only with CHR bits because
; they cannot be greater than 4 bits.
; so the << 4 will never destroy the full contents
.macro shiftleft12
	.rept 4
		asl
	.endr
	xba		; swaps high and low parts of accumulator
			; xba is effectively << 8
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


; SetBGxCHR
;------------
; \1 into bgx_chr_address_bits (not shifted) chr_0 -> chr_7000
; finds the CHR vram address and stores into bgx_chr_address
; ORS chr_address_bits with corresponding bg_chr_address_bits to store into
; $210B / $210C ($210B = BG1,BG2 | $210C = BG3,BG4)

;bg1
;----
.macro SetBG1CHR
	lda #\1
	sta bg1_chr_address_bits
	
	shiftleft12
	sta bg1_chr_address+1
	stz bg1_chr_address
	
	lda bg2_chr_address_bits
	asl
	asl
	asl
	asl
	ora #\1
	sta $210B
.endm

;bg2
;----
.macro SetBG2CHR
	lda #\1
	sta bg2_chr_address_bits
	
	pha
	shiftleft12
	sta bg2_chr_address+1
	stz bg2_chr_address
	pla
	
	asl
	asl
	asl
	asl
	ora bg1_chr_address_bits
	sta $210b
.endm

;bg3
;----
.macro SetBG3CHR
	lda #\1
	sta bg3_chr_address_bits
	
	shiftleft12
	sta bg3_chr_address+1
	stz bg3_chr_address
	
	lda bg4_chr_address_bits
	asl
	asl
	asl
	asl
	ora #\1
	sta $210c
.endm

;bg4
;----
.macro SetBG4CHR
	lda #\1
	sta bg4_chr_address_bits
	
	pha
	shiftleft12
	sta bg4_chr_address+1
	stz bg4_chr_address
	pla
	
	asl
	asl
	asl
	asl
	ora bg3_chr_address_bits
	sta $210c
.endm

; SetBG1 sc_address_bits, mapsize, chr_address_bits
.macro SetBG1
	.redefine sc_loc \1 
	.redefine mapsize \2 
	.redefine chr_loc \3 
	
	SetBG1SC sc_loc, mapsize
	SetBG1CHR chr_loc
.endm

; SetBG2 sc_address_bits, mapsize, chr_address_bits
.macro SetBG2
	.redefine sc_loc \1 
	.redefine mapsize \2 
	.redefine chr_loc \3 
	
	SetBG2SC sc_loc, mapsize
	SetBG2CHR chr_loc
.endm

; SetBG3 sc_address_bits, mapsize, chr_address_bits
.macro SetBG3
	.redefine sc_loc \1 
	.redefine mapsize \2 
	.redefine chr_loc \3 
	
	SetBG3SC sc_loc, mapsize
	SetBG3CHR chr_loc
.endm

; SetBG4 sc_address_bits, mapsize, chr_address_bits
.macro SetBG4
	.redefine sc_loc \1 
	.redefine mapsize \2 
	.redefine chr_loc \3 
	
	SetBG4SC sc_loc, mapsize
	SetBG4CHR chr_loc
.endm


