;== Include MemoryMap, HeaderInfo, and interrupt Vector table ==
.INCLUDE "header/header.inc"

;======================================
; DATA
;--------------------------------------
;.include "data/font/mario3.section"

;== Include Library Routines ==
.INCLUDE "init/InitSNES.asm"
.INCLUDE "video/LoadGraphics.asm"


;== EQUates ==
.include "equates.asm"

;== ENuMERATIOS == 
.include "enum.asm"

;== Sprite routines ==
.include "sprites/sprites.asm"

;== Joypad Routines ==
.include "joypad/joypad.asm"


; == Font Routines == 
.include "fonts/fonts.asm"
.include "fonts/strings.asm"

; == Video Routines == 
.include "video/setup.asm"
.include "video/screen.asm"
.include "video/bg/routines.asm"