
; Main/Sub Screen definitions
; specify how many times to shift #1 to set correct position in the screen register
.define bg1 0
.define bg2 1
.define bg3 2
.define bg4 3
.define sprites 4

.define BG1 0
.define BG2 1
.define BG3 2
.define BG4 3
.define SPRITES 4

.export bg1,BG1,bg2,BG2,bg3,BG3,bg4,BG4,sprites, SPRITES
;-----------------------



; Tilemap map-size Defines
.define map32x32 $0
.define map64x32 $1
.define map32x64 $2
.define map64x64 $3
;----------------
.export map32x32,map64x32,map32x64,map64x64

;.export map32x32, map64x32, map32x64, map64x64

; SC VRAM Defines
.define sc_0 0
.define sc_400 1<<2
.define sc_800 2<<2
.define sc_c00 3<<2
.define sc_1000 4<<2
.define sc_1400 5<<2
.define sc_1800 6<<2
.define sc_1c00 7<<2
.define sc_2000 8<<2
.define sc_2400 9<<2
.define sc_2800 10<<2
.define sc_2c00 11<<2
.define sc_3000 12<<2
.define sc_3400 13<<2
.define sc_3800 14<<2
.define sc_3c00 15<<2
.define sc_4000 16<<2
.define sc_4400 17<<2
.define sc_4800 18<<2
.define sc_4c00 19<<2
.define sc_5000 20<<2
.define sc_5400 21<<2
.define sc_5800 22<<2
.define sc_5c00 23<<2
.define sc_6000 24<<2
.define sc_6400 25<<2
.define sc_6800 26<<2
.define sc_6c00 27<<2
.define sc_7000 28<<2
.define sc_7400 29<<2
.define sc_7800 30<<2
.define sc_7c00 31<<2

.export sc_0
.export sc_400 
.export sc_800 
.export sc_c00 
.export sc_1000
.export sc_1400
.export sc_1800
.export sc_1c00
.export sc_2000
.export sc_2400
.export sc_2800
.export sc_2c00
.export sc_3000
.export sc_3400
.export sc_3800
.export sc_3c00
.export sc_4000
.export sc_4400
.export sc_4800
.export sc_4c00
.export sc_5000
.export sc_5400
.export sc_5800
.export sc_5c00
.export sc_6000
.export sc_6400
.export sc_6800
.export sc_6c00
.export sc_7000
.export sc_7400
.export sc_7800
.export sc_7c00

; CHR VRAM DEFINES 0-7
.define chr_0 0
.define chr_1000 1
.define chr_2000 2
.define chr_3000 3
.define chr_4000 4
.define chr_5000 5
.define chr_6000 6
.define chr_7000 7

.export chr_0
.export chr_1000
.export chr_2000
.export chr_3000
.export chr_4000
.export chr_5000
.export chr_6000
.export chr_7000