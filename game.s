
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

.segment "DATA"
    MAX_MARIO = 64


.segment "BSS"
    marioXPos: .res MAX_MARIO
    marioYPos: .res MAX_MARIO

.segment "ZEROPAGE" ; LSB 0 - FF

  mario_index: .res 1

  mx: .res 1
  my: .res 1

.segment "CODE"

  .include "lib/ppu.s"
  .include "resetroutine.s"

  ; todo
  ; look into using structs to store all info about a sprite.

  LoadMetaSprite mario, #mario_size, mario_index

  LoadMetaSprite balls, #20

  inf_loop:
    jmp inf_loop

  
  NMI:

    inc mx
    inc my
    SetMetaSpritePosition mario_index, mario, #mario_size, mx, my

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