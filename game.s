.segment "HEADER"

  .byte "NES"
  .byte $1A
  .byte $02 ; 2 16kb PRG ROM chips
  .byte $01 ; 1 8kb CHR ROM chip
  .byte %00000000 ; mapper and mirroring
  .byte $00
  .byte $00
  .byte $00
  .byte $00
  .byte $00, $00, $00, $00, $00 ; filler bytes

.segment "STARTUP"

  Reset:

    sei ; Disables all interrupts so this code is not interrupted, my son.
    cld ; disables decimal mode because NES doesn't support decimals, my child.

    ; Disable sound IRQ to make sure values aren't interpreted as sound data and random sounds don't play when we load the program.
    ldx #$40
    stx $4017 ; APU Frame Counter

    ; Initialize the stack register. Shhh, be nice to it. We wouldn't want it to overflow...
    ldx #$FF ; We load FF because the stack register decrements with each addition to stack instead of incrementing like you'd expect
    txs ; Transfer X to Stack Register

    inx ;  #$FF + 1 = #$00

    ; Zero out PPU registers se we don't see random graphics when we load the program
    stx $2000 ; PPU control address
    stx $2001 ; PPU mask address. Stores whether background and sprites are enabled and some other options like that, fam.

    stx $4010 ; This also disables sounds and shiz.
  
    ;We need to check that the console has attempted to draw its first V-Blank. This tells us that it is ready to rumble!
    ; BIT gets the 7th bit from an address and evaluates that value to either branch or continue. The 7th bit signifies whether the value is signed or not
:
    bit $2002
    bpl :- ; branch to previous anonymous label, if positive. if we are in a vblank, $2002 will be signed negative and the 7th bit will be 1. Otherwise, it is 0 and it is positive.

    txa ; transfers X reg to A reg. The value is currently 0

  CLEARMEM: ; This is basically a low level for loop that clears out the NES memory.
    sta $0000, X ; X is the offset, so its value will be added to the address to clear out every column of memory at the address
    sta $0100, X
    sta $0300, X ; Notice how we don't clear $0200 because we usin that for sprite data and shiz
    sta $0400, X
    sta $0500, X
    sta $0600, X
    sta $0700, X

    ;initializing our Sprite data address
    lda #$FF
    sta $0200, X ; stores FF into all memory columns of address $0200
    lda #$00 ; set back to 00 so we can go back to for loopin like nothin ever happened

    inx
    bne CLEARMEM ; we loop back until X equals A, or 0 in this case

  : ; Waiting for a second Vblank to make extra extra sure that the PPU is ready for us to grace it with our fabulous art.
    bit $2002 ; branch to previous anonymous label, if positive.
    bpl :-

    lda #$02 ; The HIbyte of our PPU data address.
    sta $4014 ; OAM DMA Register. Tells the OAM where our sprite data is or some shiz not entirely sure.
    nop ; PPU needs some time, so give it some time with the new No Operation instruction!

.segment "ZEROPAGE" ; LSB 0 - FF

  Ball: .res 1

.segment "DATA"

  MaxBalls = 16

  BallPosX: .res MaxBalls, $00
  BallPosY: .res MaxBalls, $00

.segment "CODE"

  ;.include "lib/ppu.s"

  LoadPalettes:
    lda $2002 ; reset hatch or smth
    lda #$3F
    sta $2006
    lda #$00
    sta $2006
    ldx #$00
    :
      lda background_palette, X
      sta $2007
      inx
      cpx #$10
      bne :-

    ldx #$00
  LoadSprite:
    lda BallSprite, X
    sta $0200, X
    inx
    cpx #$04
    bne LoadSprite

  Loop: ; looping so we don't run the NMI code when there isn't an NMI, pluh. THIS IS NOT A GAMELOOP!!!!!
    jmp Loop

  NMI: ; occurs in between the drawing of frames.
    lda #$02
    sta $4014 ; tell ppu where to find sprite data (we have to do this every frame)
    rti ;  RTS but for interrupts because it needs to be a different thing for some reason.

  background_palette:
  .byte $22,$29,$1A,$0F	;background palette 1
  .byte $22,$36,$17,$0F	;background palette 2
  .byte $22,$30,$21,$0F	;background palette 3
  .byte $22,$27,$17,$0F	;background palette 4

  BallSprite:
    .byte $08, $75, $00, $08 ; Ypos, Tile, Attributes, Xpos

.segment "VECTORS" ; for interrupt handlers and shiz
  .word NMI
  .word Reset
  ;

.segment "CHARS"
  .incbin "mario.chr"