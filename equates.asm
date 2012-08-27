; - -- --- 
; Equates | 
;---------
; BG Equates
.include "video/bg/bg_equates.inc"
; JOYpad Equates
.include "joypad/button_equates.inc"

; The Equates file is a place to put all the . . . . .Equates . xD
; There is General Purpose RAM $0000-$1FFF that banks 00-3f can all use easily (shadowed from $7e)
; Then there is banks 7E and 7F 

; Current Layout
;----------------
;Sprite Buffer
.equ SpriteBuffer 	$00
.equ SpriteBuffer_Table1 SpriteBuffer
.equ SpriteBuffer_Table2 SpriteBuffer+$200
.export SpriteBuffer

.DEFINE SprNum 128
.export SprNum
;---------------------
; Joypad Data
.EQU JOYDATASTART SpriteBuffer+$200
.export JOYDATASTART

;--------------------
; HardWare Registers
;--------------------
; Equates for Multiplication
.EQU Multiplicand_A	$4202
.EQU Mult_A			Multiplicand_A
.EQU Multiplicand_B $4203
.EQU Mult_B			Multiplicand_B
.EQU Product		$4216

.equ bpp2	$2
.equ bpp4	$4



; Regarding Strings.asm
;------------------------------
;text buffer - is copied to VRAM during VBlank
; $7F0000 - $7F03FF
.DEFINE TextBuffer	$7F0000
.Define TextBuffer16 $0000
.DEFINE TextBufferBank $7F