
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

.segment "RODATA"
  .include "sprites.s"
  .include "anims.s"

.segment "ZEROPAGE" ; LSB 0 - FF

  mx: .res 1
  my: .res 1

.segment "CODE"

  .include "lib/ppu.s"
  ;.include "resetroutine.s"

  Reset:
    ldx #$FF
    txs

  waitVblank:
    bit $2002
    bpl waitVblank

    lda #%10000000
    sta $2000
    lda #%00011110
    sta $2001

  ; todo
  ; look into using structs to store all info about a sprite.

  loadMarioPalette:

    lda #$3F
    sta $2006
    lda #$10
    sta $2006

    lda #$3F
    sta $2007

    lda #$16
    sta $2007

    lda #$27
    sta $2007

    lda #$18
    sta $2007

  lodaMarioSprite:
    lda #$36
    sta $0201
    lda #$37
    sta $0205
    lda #$38
    sta $0209
    lda #$39
    sta $020D

  lda #$00
  sta OAM_ADDR
  lda #$02
  sta OAM_DMA


  inf_loop:
    jmp inf_loop

  
  NMI:

    lda mx
    sta $0203
    sta $020B
    lda mx
    clc
    adc #8
    sta $0207
    sta $020F

    lda my
    sta $0200
    sta $0204
    lda my
    clc
    adc #8
    sta $0208
    sta $020C

    inc mx
    inc mx
    inc my

    lda #$00
    sta OAM_ADDR
    lda #$02
    sta OAM_DMA
    rti

.segment "VECTORS" ; for interrupt handlers and shiz
  .word NMI
  .word Reset

.segment "CHARS"
  .incbin "bin/mario.chr"