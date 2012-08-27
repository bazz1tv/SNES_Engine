; Main SCreen MACRO
.macro MainScreen
	php
	sep #$30
	stz temp1
	ldx #\1
	jsr set_screen_bits
	.ifdefm \2
		ldx #\2
		jsr set_screen_bits
		.ifdefm \3
			ldx #\3
			jsr set_screen_bits
			.ifdefm \4
				ldx #\4
				jsr set_screen_bits
				.ifdefm \5
					ldx #\5
					jsr set_screen_bits
				.endif
			.endif
		.endif
	.endif
	lda temp1
	sta $212c
	plp
.endm

.bank 0 slot 0
.org 0
.Section "screencode" SEMIFREE

; set_screen_bits
; in: X/8bit : holds main/sub screen definition
; Using the definitions of bg1,bg2,bg3,bg4,sprites
; = 0,1,2,3,4

; This shifts the bits correctly into their screen register
; positions. Ie. bg1 = #%1, bg2 =  #%10, bg3 = %100 etc.
set_screen_bits:
.accu 8
.index 8
	lda #$01
	cpx #$00
	beq +
-	asl
	dex
	bne -
	
+	ora temp1
	sta temp1
	rts
	
.ends