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

  marioX .set $00
  page1: .res 2
  page2: .res 2

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

    ; tell PPU that we want to write to address $3F00. $3F00 is the starting address for palette information in PPU memory
    lda #$3F
    sta $2006 ; this is the PPU address register. It allows us to communicate with the PPU from the CPU.
    lda #$00
    sta $2006

    ldx #$00

  LoadPalettes: ; for loop that loops through palette data and places it in ppu memory
    lda PaletteData, X
    sta $2007 ; while $2006 is for the read/write location, $2007 is for the actual read write data. They are like 2 peas in a pod!
    ; the ppu also automatically increments the address we are writing at each time we write a byte. This is very nifty indeed. Finally, the machine does something for me.
    inx
    cpx #$20 ; 20 in hex is 32 in decimal. We are loading 32 bytes of palette data in this case.
    bne LoadPalettes

    
  InitWorldData:
    ;Initialize world to point to world data
    lda #<chunk1page1 ; < gets the lo byte
    sta page1
    lda #>chunk1page1 ; > gets the hi byte
    sta page1+1 ; +1 just gets the address of the byte one after the world var

    ; setup address in PPU for nametable data
    bit $2002
    lda #$20 ; 2000 is the first top left nametable
    sta $2006
    lda #$00
    sta $2006


    ldx #$00
    ldy #$00
  ;this is like a double for loop. X is I. Y is J
  LoadWorld: ; a screen of background tiles consists of 960 bytes. 960 in hex is 03C0.
    lda (page1), Y
    sta $2007
    iny
    cpx #$07
    bne :+
    cpy #$80
    beq WorldLoadingFinished
  :
    cpy #$00 ; y will be 0 after it has gone past 255 or FF in hex
    bne LoadWorld
    inx
    inc page1+1
    jmp LoadWorld

  WorldLoadingFinished:
    ldx #$00
    lda #<chunk1page2 ; < gets the lo byte
    sta page2
    lda #>chunk1page2 ; > gets the hi byte
    sta page2+1 ; +1 just gets the address of the byte one after the world var

    bit $2002
    lda #$24 ; 2400 is the first top right nametable
    sta $2006
    lda #$00
    sta $2006
  LoadWorld2: ; a screen of background tiles consists of 960 bytes. 960 in hex is 03C0.
    lda (page2), Y
    sta $2007
    iny
    cpx #$07
    bne :+
    cpy #$80
    beq WorldLoadingFinished2
  :
    cpy #$00 ; y will be 0 after it has gone past 255 or FF in hex
    bne LoadWorld2
    inx
    inc page1+1
    jmp LoadWorld2

  WorldLoadingFinished2:
    ldx #$00

  SetAttributes: ; so basically, the attribute table is a table that divides the screen into 64 sections (64 bytes) so you can give attributes to these sections on the background like color pallette and stuff
    lda #$55 ; this is palette. Dont worry how this works
    sta $2007 ; stores into nametable
    inx
    ;cpx #$40 ; 64 in hex
    cpx #$80
    bne SetAttributes

    ldx #$00
    ldy #$00
  LoadSprites: ; for loop that loops through sprite data and places it in our previously set sprite data address
    lda SpriteData, X
    sta $0200, X ; Stores the sprite byte offsetted by X into our previously set sprite address also offsetted by X
    inx
    cpx #$20
    bne LoadSprites

    cli ; Turn interrupts back on (because we had them off before for initialization purposes)

    lda #%10010000 ; tells ppu that we want to be interrupted for NMI and that we want to use tileset 2 for background tiles instead of tileset1
    sta $2000 ; store in ppu control reg
    lda #%00011110 ; tells ppu that we want to enable rendering for first leftmost 8px for sprites and background and to enable rendering of sprites and background in general
    sta $2001


  Loop: ; looping so we don't run the NMI code when there isn't an NMI, pluh. THIS IS NOT A GAMELOOP!!!!!
    jmp Loop

  NMI: ; occurs in between the drawing of frames.
    ldx marioX ; gets the value before adding the speed
    lda #02
    adc marioX
    sta marioX
    cpx marioX
    bcc :+; no rollover
    lda $2000
    eor #%00000001 ; flip bit to switch nametables
    sta $2000
    :
      lda marioX
      sta $2005
      lda #$00
      sta $2005
      lda #$02
      sta $4014 ; tell ppu where to find sprite data (we have to do this every frame)
      rti ;  RTS but for interrupts because it needs to be a different thing for some reason.
  
  PaletteData:
    .byte $22,$29,$1A,$0F,$22,$36,$17,$0f,$22,$30,$21,$0f,$22,$27,$17,$0F  ;background palette data
    .byte $22,$16,$27,$18,$22,$1A,$30,$27,$22,$16,$30,$27,$22,$0F,$36,$17  ;sprite palette data

  chunk1page1:
    .incbin "testlevel.nam"
  chunk1page2:
    .incbin "testlevel2.nam"

  SpriteData:
    .byte $08, $00, $00, $08 ; Ypos, Tile, Attributes, Xpos
    .byte $08, $01, $00, $10
    .byte $10, $02, $00, $08
    .byte $10, $03, $00, $10
    .byte $18, $04, $00, $08
    .byte $18, $05, $00, $10
    .byte $20, $06, $00, $08
    .byte $20, $07, $00, $10

.segment "VECTORS" ; for interrupt handlers and shiz
  .word NMI
  .word Reset
  ;

.segment "CHARS"
  .incbin "shapes.chr"