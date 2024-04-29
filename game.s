.segment "RODATA"

  screenWidth = 255
  screenHeight = 230

  ballXSpd = 4
  ballYSpd = 3

  ballWidth = 40
  ballHeight = 8

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

.segment "ZEROPAGE" ; LSB 0 - FF

  Ball: .res 1
  ballX: .res 1
  ballY: .res 1
  ballXDir: .res 1
  ballYDir: .res 1
  ballRight: .res 1
  ballBottom: .res 1
  flashTimer: .res 1
  ballColor: .res 1

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

    lda #%10010000 ; tells ppu that we want to be interrupted for NMI and that we want to use tileset 2 for background tiles instead of tileset1
    sta $2000 ; store in ppu control reg
    lda #%00011110 ; tells ppu that we want to enable rendering for first leftmost 8px for sprites and background and to enable rendering of sprites and background in general
    sta $2001

.segment "CODE"

  ;.include "lib/ppu.s"

  ;fortnite

  LoadPalettes:
    lda $2002 ; reset hatch or smth
    lda #$3F
    sta $2006
    lda #$00
    sta $2006
    ldx #$00
    loadBgPalettes:
      lda background_palette, X
      sta $2007
      inx
      cpx #16
      bne loadBgPalettes
      ldx #0
    loadSpritePalettes:
      lda sprite_palette, X
      sta $2007
      inx
      cpx #16
      bne loadSpritePalettes

    ldx #0
   LoadSprite:
    lda BallSprite, X
    sta $0200, X
    inx
    cpx #$14
    bne LoadSprite

  Loop: ; looping so we don't run the NMI code when there isn't an NMI, pluh. THIS IS NOT A GAMELOOP!!!!!
    setBallPosOffsets:
      clc
      lda ballX
      adc #ballWidth
      sta ballRight
      clc
      lda ballY
      adc #ballHeight
      sta ballBottom
    jmp Loop

  NMI: ; occurs in between the drawing of frames.
    pha
    clc
    ;lda flashTimer
    ;adc #4
    ;sta flashTimer

    jsr wallCollisionX
    jsr wallCollisionY

    jsr moveBallX
    jsr moveBallY

    ;ldx #$FF
    ldx #0

    UpdateBallSprite:
      clc
      lda BallSprite, X
      adc ballY
      sta $0200, X
      inx
      inx
      lda ballColor
      and #%00000011
      sta $0200, X
      inx
      lda BallSprite, X
      adc ballX
      sta $0200, X
      inx
      cpx #20
      bne UpdateBallSprite

    lda #$02
    sta $4014 ; tell ppu where to find sprite data (we have to do this every frame)

    pla
    rti ;  RTS but for interrupts because it needs to be a different thing for some reason.

  moveBallX:
    lda ballXDir
    cmp #$00
    beq :+

    ;direction is negative
    lda ballX
    sbc #ballXSpd
    sta ballX
    jmp updateBallXPos
    : ;direction is positive
      clc
      lda ballX
      adc #ballXSpd
      sta ballX

    updateBallXPos:
      lda ballX
      sta $0203
      rts
  
  moveBallY:
    lda ballYDir
    cmp #$00
    beq :+ ; direction positive

    ; direction is negative
    lda ballY
    sbc #ballYSpd
    sta ballY
    jmp updateBallYPos
    
    : ; direction is positive
      clc
      lda ballY
      adc #ballYSpd
      sta ballY

    updateBallYPos:
      lda ballY
      sta $0200
      rts

  wallCollisionX:

    lda ballXDir
    cmp #0
    bne :+

    ; test right edge
    lda ballRight
    cmp #screenWidth ; check if its equal just to make sure
    beq RightEdge
    
    adc #ballXSpd ;  get next ball position
    bcs RightEdge


    :
    lda ballXDir
    cmp #1
    bne @done

    ;testing left edge
    lda ballX
    cmp #0
    beq LeftEdge

    sec
    sbc #ballXSpd ;  get next ball position
    bcc LeftEdge

    @done:
    rts

  wallCollisionY:

    lda ballYDir
    cmp #0
    bne :+

    ; test bottom edge
    lda ballBottom
    cmp #screenHeight ; check if its equal just to make sure
    beq BottomEdge

    
    sec
    cmp #screenHeight ; I really hate how the NES verticle resolution is 240. It would make everything so much better if it was 256.
    bcs BottomEdge

    :
    lda ballYDir
    cmp #1
    bne @done

    ;testing top edge
    lda ballY
    cmp #8
    beq TopEdge

    sbc #ballYSpd ;  get next ball position
    sec
    cmp #8
    bcc TopEdge


    @done:
    rts

  LeftEdge:
    lda #0
    sta ballX
    lda #0
    sta ballXDir
    inc ballColor
    rts

  RightEdge:
    lda #screenWidth
    sbc #ballWidth
    sta ballX
    lda #1
    sta ballXDir
    inc ballColor
    rts
  TopEdge:
    lda #8
    sta ballY
    lda #0
    sta ballYDir
    inc ballColor
    rts
  BottomEdge:
    lda #screenHeight
    sbc #ballHeight
    sta ballY
    lda #1
    sta ballYDir
    inc ballColor
    rts

  background_palette:
    .byte $3F,$16,$06,$15 ; background palette 1
    .byte $3F,$36,$17,$0F ; background palette 2
    .byte $3F,$30,$23,$0F ; background palette 3
    .byte $3F,$27,$17,$0F ; background palette 4
  
  sprite_palette:
    .byte $3F,$16,$16,$16
    .byte $3F,$19,$19,$19
    .byte $3F,$01,$01,$01
    .byte $3F,$28,$28,$28


  BallSprite:
    .byte $00, $0B, $01, $00 ; Ypos, Tile, Attributes, Xpos
    .byte $00, $0A, $01, $08
    .byte $00, $15, $01, $10
    .byte $00, $15, $01, $18
    .byte $00, $1C, $01, $20

.segment "VECTORS" ; for interrupt handlers and shiz
  .word NMI
  .word Reset
  ;

.segment "CHARS"
  .incbin "mario.chr"