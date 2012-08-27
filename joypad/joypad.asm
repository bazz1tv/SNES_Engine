

.BANK 0 slot 0
.org 0
.SECTION "JoypadCode" semifree
;============================================================================
; Joypad -- Gets joypad data
;============================================================================
Joypad:
	rep #$10
	sep #$20
	;jsr UpdatePad	
	
	lda Joy1Press+1

_Up:	
	bit #B_Up
	beq _Down
	pha
	;jsr moverowup
	pla
_Down:
	bit #B_Down
	beq _Left
	pha
	;jsr moverowdown
	pla
_Left:
	bit #B_Left
	beq _Right
	pha
	;jsr movecoleft
	pla
_Right:
	bit #B_Right
	beq _Select
	pha
	;jsr movecolright
	pla
_Select:
	bit #B_Select
	beq _Start
	pha
	;jsr moverowdown
	pla
_Start:
	bit #B_Start
	beq _Y
	pha
	;jsr commandoredit
	pla
_Y:
	bit #B_Y
	beq _Low
	; Y CODE HERE
	
_Low:
	lda Joy1Press
_A:	bit #B_A
	beq _X
	pha
	;jsr commandoredit
	pla
_X:	bit #B_X
	beq _L
	pha
	; X CODE HERE
	pla
	
_L:	bit #B_L
	beq _R
	pha
	; L CODE HERE
	pla
	
_R:	bit #B_R
	beq _exit
	; R CODE HERE

_exit:
	rts

	
UpdatePad:
    php
    rep #$10
    sep #$20
_test1:	
	lda $4212       ; auto-read joypad status
	and #$01        ; 
	bne _test1     	; read is done when 0
	
	rep #$30        ; A/X/Y - 16 bit
	
	; Player 1
	ldx Joy1Raw		; load log of last frame's RAW read of $4218
	ldy Joy1Held
	                ; the log will be 0 the first time read of course..
	lda $4218       ; Read current frame's RAW joypad data
	sta Joy1Raw     ; save it for next frame.. (last frame log is still in X)
	txa             ; transfer last frame input from X -&gt; A (it's still in X too)
	eor Joy1Raw     ; Xor last frame input with current frame input
	                ; shows the changes in input
	                ; buttons just pressed or just released become set.
	                ; Held or unactive buttons are 0
	and Joy1Raw     ; AND changes to current frame's input.
	                ; this ends up leaving you with the only the buttons that are pressed..
	                ; It's MAGIC!
	sta Joy1Press	; Store just pressed buttons
	txa             ; Transfer last frame input from X -&gt; A again
    and Joy1Raw		; Find buttons that are still pressed (held)
    sta Joy1Held    ; by storing only buttons that are pressed both frames
    tya
    eor Joy1Held
    bne ++
    inc Joy1HeldCount
    lda Joy1HeldCount
    cmp #$04
    bne +
    lda Joy1Held
    sta Joy1HeldLong
+   cmp #$0D
    bne +++
    lda Joy1Held
    sta Joy1HeldLonger
    bra +++
++	stz Joy1HeldCount
	stz Joy1HeldLong
	stz Joy1HeldLonger
+++
    ; Player 2      ; Repeat :)
	ldx Joy2Raw		; load log of last frame's RAW read of $4218
	ldy Joy2Held
	                ; the log will be 0 the first time read of course..
	lda $421A       ; Read current frame's RAW joypad data
	sta Joy2Raw     ; save it for next frame.. (last frame log is still in X)
	txa             ; transfer last frame input from X -&gt; A (it's still in X too)
	eor Joy2Raw     ; Xor last frame input with current frame input
	                ; shows the changes in input
	                ; buttons just pressed or just released become set.
	                ; Held or unactive buttons are 0
	and Joy2Raw     ; AND changes to current frame's input.
	                ; this ends up leaving you with the only the buttons that are pressed..
	                ; It's MAGIC!
	sta Joy2Press	; Store just pressed buttons
	txa             ; Transfer last frame input from X -&gt; A again
    and Joy2Raw		; Find buttons that are still pressed (held)
    sta Joy2Held    ; by storing only buttons that are pressed both frames
    tya
    eor Joy2Held
    bne ++
    inc Joy2HeldCount
    lda Joy2HeldCount
    cmp #$04
    bne +
    lda Joy2Held
    sta Joy2HeldLong
+   cmp #$0D
    bne +++
    lda Joy2Held
    sta Joy2HeldLonger
    bra +++
++	stz Joy2HeldCount
	stz Joy2HeldLong
	stz Joy2HeldLonger
+++
    
    ; Joypads standard (ie not a mouse or superscope..) and connected?
    sep #$20
    ldx #$0000          ; we'll clear recorded input if pad is invalid
    
    lda $4016           ; Pad 1 - now we read this (after we stored a 0 to it earlier)
    bne _check2         ; $4016 returns 0 if not connected, 1 if connected - branch if not 0
    stx Joy1Raw         ; otherwise clear all recorded input.. it's not valid..
    stx Joy1Press
    stx Joy1Held

_check2:    
   	lda $4017           ; Pad 2
    bne _done           ; 0=not connected,
    stx Joy2Raw
    stx Joy2Press
    stx Joy2Held

_done:
    plp
    RTS
    
.ENDS