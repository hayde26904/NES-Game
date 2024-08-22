
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

.segment "DATA"

    MAX_MARIO = 64

    marioXPos: .res MAX_MARIO
    marioYPos: .res MAX_MARIO

.segment "ZEROPAGE" ; LSB 0 - FF



.segment "CODE"

  .include "resetroutine.s"

  ldx #1
  lda $79
  sta marioXPos
  lda $42
  sta marioXPos,X

  inf_loop:
    jmp inf_loop

  
  NMI:
    rti

.segment "VECTORS" ; for interrupt handlers and shiz
  .word NMI
  .word Reset

.segment "CHARS"
  .incbin "bin/mario.chr"
