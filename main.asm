; Engine - VROOOOooooommmm
;
; Its my attempt at making something sweet
; To make coding SNES easier and more standard
; and English ;)
;-----------------------------------------

; Super-Mega Include File
.include "header/includes.asm"

;==========================================
; Main Code
;==========================================

.BANK 0 SLOT 0
.ORG 0
.SECTION "MainCode" SEMIFREE

Start:
	; Clear EVERYTHING
    InitSNES
;--------------
    rep #$10
    sep #$20

	; Typical Init Routines
	;--------------------
	; Global Variables
	;init_global_variables ; include/code/init/...
	
	LoadPalette mario3_font_palette, 0, 16 ; Macro
	LoadPalette mario3_font_palette 32,16
	LoadPalette mario3_font_palette 64,16
	LoadPalette mario3_font_palette 96,16
	LoadPalette mario3_font_palette 0,16
	
	; Load Tile data to VRAM
	
	;LoadBlockToVRAM font_mario3_tiles, $1000, font_mario3_tiles_end-font_mario3_tiles
	
	; You need to setup what You want as far as bg_mode etc.
	; Make a MaCRO
	;
	;lda #$80
	;sta $2115
	;ldx #$1400
	;stx $2116
	;lda #$01
	;sta $2118
	
	StoreMario3Font $0000, 2
	rep #$10
	sep #$20
	
	SetBGMode 1
	;SetBG3 sc_800, map32x32, chr_0
	;SetBG1 sc_1400, map32x32, chr_1000
	SetBG3 sc_800, map32x32, chr_0
	;LoadBlockToVRAM Tiles, $1000, $0040	; 2 tiles, 2bpp, = 32 bytes
	;SetBG2 sc_400, map32x32, chr_0
	
	;rep #$10
	;sep #$20
	;ldx.w #$800
	;stx.w $2116
	;lda #'A'
	;sta $7f0000
	
	;SetBG4 sc_400, map32x32, chr_0
	
    MainScreen bg3

	
	lda #$ff
	sta $210E
	sta $210E
	
	lda #$0F
    sta $2100           ; Turn on screen, full Brightness
	
	lda #$80
    sta $4200       ; Enable NMI
	
    

Infinity:
	;ldx #2*32
	;stx Cursor
	
	;lda #'A'
	;jsr Print
	; works
	rep #$10
	sep #$20
	SetCursorPos 5,5
	ldx #mario3_font_sequence
	jsr PrintF
	;ldy #mario3_font_sequence
	;PrintString "%s"
	
	
    WAI

_done:
    JMP Infinity

heyyy:
.DB "HEYYY", 0

;============================================================================
VBlank:
	;php
    rep	#$10
	sep #$20
	
	
	jsr transfer_font_bg
	;ldx	VBlankPointer
	;jsr	(irqtab,x)
	
	LDA $4210
	;plp
	sep #$20
    RTI
;============================================================================

.ENDS

.BANK 1 SLOT 0
.ORG 0
.SECTION "CharacterData"

Tiles:
	; Blank Tile
	.rept 16
	.dw $0000
	.endr
	; Smiley Face
	.db %00000000
	.db %00000000
	.db %00100100
	.db %00000000
	.db %00100100
	.db %00000000
	.db %00100100
	.db %00000000
	.db %00000000
	.db %00000000
	.db %10000001
	.db %00000000
	.db %11111111
	.db %00000000
	.db %00000000
	.db %00000000
	.rept 16
		.db 0
	.endr

    .db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00
    .db $FF, $00, $DB, $00, $DB, $00, $DB, $00, $FF, $00, $7E, $00, $00, $00, $FF, $00

BG_Palette:
	
	.db $00
	.db $00
	.db $FF
	.db $03
	.db $00, $00, $00, $00
    .DB $00, $00, $FF, $03
    .DW $0000, $0000, $0000
    .DB $1F, $00
    .DW $0000, $0000, $0000
    .DB $E0, $5D
    .DW $0000, $0000, $0000
    .DB $E0, $02

.ENDS
