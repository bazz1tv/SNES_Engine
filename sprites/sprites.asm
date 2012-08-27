; Sprites.asm
;----------------
; Various Sprite-related functions
;  - Sprite Init to 0 & off-screen
;  - 

.BANK 0 SLOT 0
.ORG 0
.SECTION "SpriteCode" SEMIFREE

SpriteInit:
	php	

	rep	#$30	;16bit mem/A, 16 bit X/Y
	
	lda #SpriteBuffer
	TCD
	ldy #$0020
	ldx #$0000
    lda #$0001
_setoffscr:
    sta $00,X
    sty $02,X
    inx
    inx
    inx
    inx
    cpx #$0200
    bne _setoffscr
;==================
	lda #SpriteBuffer+$200
	TCD
	ldx #$0000
	lda #$5555
_clr:
	sta $00, X	;initialize all sprites to be off the screen
	inx
	inx
	cpx #$0020
	bne _clr
;==================       
	plp
	rts
	
	
	
	rts
	
.ENDS