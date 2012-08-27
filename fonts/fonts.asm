; StoreMario3Font
; 8 bit A. 16 X/y
; IN: VRAM, bpp
; This code is fragile on the fact that
; all BG CHR values are not pre bit-shifted
.macro StoreMario3Font
	; cleared high byte
	.accu 8
	.index 16
	sep #$20
	lda.b #\2
	sta fontbpp
	rep #$30
	ldx.w #\1
	jsr LoadMario3Font
	
.endm

.BANK 0 SLOT 0
.ORG 0
.SECTION "FontCode" SEMIFREE

; LoadMario3Font
; Takes in VRAM BASE Address in X
LoadMario3Font:
	; Load Font correctly to line up with ASCII standard
	;php
	;rep #$30
	;pha
	;phx
	;phy
	.index 16
	.accu 16
	rep #$10
	sep #$20
	lda #$80
	sta $2115
	; X already contains VRAM address
	stx $2116
	; Get a Temp Variable
	stx temp1
	
	jsr fontbpp_to_wpt ;wpt = words per tile
	
	
	rep #$20
	ldx #$0000
	; Now using X as a Font_tiles counter
	
	
	; ! character .after space
	; 33 * 16 = $210 
	; 33 * words_per_tile
	sep #$20
	lda #'!'
    sta Multiplicand_A
	lda font_words_per_tile
	sta Multiplicand_B
	nop
	nop
	nop
	nop
	rep #$20
	lda Product
	clc
	adc temp1
    sta $2116
    ldy #0001
    jsr upvram
	
	; Space character
	sep #$20
	lda #' '
    sta Multiplicand_A
	lda font_words_per_tile
	sta Multiplicand_B
	nop
	nop
	nop
	nop
	rep #$20
	lda Product
	clc
	adc temp1
	sta $2116
	ldy #0001
	jsr upvram
	
	; comma all the way to numbers to the ;
	; 44 * 16 = $2c0
	sep #$20
	lda #','
    sta Multiplicand_A
	lda font_words_per_tile
	sta Multiplicand_B
	nop
	nop
	nop
	nop
	rep #$20
	lda Product
	clc
	clc
	adc temp1
	sta $2116
	; 10 characters from , to ;
	ldy #$10
	jsr upvram
	
	; question mark
	; 63 * 16
	; $3f0
	sep #$20
	lda #'?'
    sta Multiplicand_A
	lda font_words_per_tile
	sta Multiplicand_B
	nop
	nop
	nop
	nop
	rep #$20
	lda Product
	clc
	adc temp1
	sta $2116
	ldy #0001
	jsr upvram
	
	; A-Z
	sep #$20
	lda #'A'
    sta Multiplicand_A
	lda font_words_per_tile
	sta Multiplicand_B
	nop
	nop
	nop
	nop
	rep #$20
	lda Product
	clc
	adc temp1
	sta $2116
	ldy #26
	jsr upvram
	
	; _
	; 95 * 16
	sep #$20
	lda #'_'
    sta Multiplicand_A
	lda font_words_per_tile
	sta Multiplicand_B
	nop
	nop
	nop
	nop
	rep #$20
	lda Product
	clc
	adc temp1
	sta $2116
	ldy #1
	jsr upvram
	
	rep #$30
	;ply
	;plx
	;pla
	;plp
	rts
	

	
upvram:
		rep #$20
		lda font_words_per_tile
		sta temp2
-	    lda mario3_font_data.w,X
	    sta $2118
	    inx
	    inx
		dec temp2
		bne -
		sep #$20
		lda fontbpp
		cmp #bpp2
		bne _normal_routine
		.rept 8
			inx
			inx
		.endr 
_normal_routine:
		;rep #$30
	    dey
	    bne upvram
	    rts
	
fontbpp_to_wpt:
	lda fontbpp
	cmp #2
	bne +
	lda #8
	sta font_words_per_tile
+	cmp #4
	bne + 
	lda #16
	sta font_words_per_tile
+	rts

.include "fonts/gfx/mario3/4bpp.inc"

.ENDS