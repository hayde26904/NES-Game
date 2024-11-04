
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

  xSpd = 2
  ySpd = 1

  dirX: .res 1
  dirY: .res 1

.segment "CODE"

  .include "lib/ppu.s"

  Reset:
    ldy #$06
    sty $01
    ldy #$00
    sty $00
    lda #$00
  inf_loop:
    sta ($00), y
    dey
    bne inf_loop

  done:
    lda #$69
    jmp done
  
  NMI:
    rti

.segment "VECTORS" ; for interrupt handlers and shiz
  .word NMI
  .word Reset

.segment "CHARS"
  .incbin "bin/mario.chr"