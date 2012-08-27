.BANK 0 SLOT 0
.ORG 0
.SECTION "Video_SETUP" semiFREE


;============================================================================
; SetupVideo -- Sets up the video mode and tile-related registers
;----------------------------------------------------------------------------
; In: None
;----------------------------------------------------------------------------
; Out: None
;----------------------------------------------------------------------------






SetupVideo:
	;UpdateBGMode
    ;lda bg_mode
    ;sta $2105           ; Set Video mode 1, 8x8 tiles, 16 color BG1/BG2, 4 color BG3

	;UpdateALLBG

    lda #$01            ; Enable BG1
    sta $212C

    rts


;============================================================================


.ENDS