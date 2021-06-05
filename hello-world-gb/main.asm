INCLUDE "hardware.inc"

SECTION "Header", ROM0[$100]
    EntryPoint:
    di
    jp Start 

REPT $150 - $104
    db 0
ENDR 

SECTION "Game code", ROM0

Start:
    ; turn off the LCD
    .waitVBlank
    ld a, [rLY]
    cp 144 ; Check if the LCD is past the VBlank 
    jr c, .waitVBlank
    xor a ; ld a, 0 ;  We only need to reset a value with bit 7 reset, but 0 does the job
    ld [rLCDC], a ; 

    ld hl, $9000
    ld de, FontTiles
    ld bc, FontTilesEnd - FontTiles 
.copyFont
    ld a, [de] ; grabs a byte from source 
    ld [hli], a ; Place it at the destination, incrementing hl
    inc de ; Move to the next byte
    dec bc ; Decrement count
    ld a, b ; Check if the count is 0, since `dec bc` doesnt update flags
    or c 
    jr nz, .copyFont

    ld hl, $9800 ; This will print in the top left corner of the screen
    ld de, HelloWorldStr
    ld hl, $9700 ; 
    ld de, OtherStr
.copyString
    ld a, [de]
    ld [hli], a
    inc de
    and a ; 
    jr nz, .copyString ; 

    ; Init display registers
    ld a, %11100100
    ld [rBGP], a 

    xor a ; ld a, 0
    ld [rSCY], a 
    ld [rSCX], a 

    ; Shut sound down 
    ld [rNR52], a

    ; Turn the screen on, display background 
    ld a, %10000001
    ld [rLCDC], a

    ; Lock up
.lockup
    jr .lockup 


SECTION "Font", ROM0

FontTiles:
INCBIN "font.chr"
FontTilesEnd:


SECTION  "Hello World string", ROM0

HelloWorldStr:
    db  "Hello world!", 0

OtherStr:
    db "By Lindsey :-) <3", 0
