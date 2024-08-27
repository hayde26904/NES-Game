
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

.segment "DATA"
    MAX_MARIO = 64
    MARIO_SPRITE_INDEX = 0
    MARIO_ANIM_SPEED = 250 ;0 - 255

.segment "BSS"
    marioXPos: .res MAX_MARIO
    marioYPos: .res MAX_MARIO

.segment "ZEROPAGE" ; LSB 0 - FF

  mx: .res 1
  my: .res 1
  mario_anim_frame: .res 1
  mario_anim_countdown: .res 1

.segment "CODE"

  .include "lib/ppu.s"
  .include "lib/util.s"
  .include "resetroutine.s"

  ; todo
  ; look into using structs to store all info about a sprite.

  lda #30
  sta mx
  lda #100
  sta my

  LoadMetaSprite mario, #mario_size, #MARIO_SPRITE_INDEX
  SetMetaSpritePosition #MARIO_SPRITE_INDEX, mario, #mario_size, mx, my

  inf_loop:
    jmp inf_loop

  
  NMI:

    inc mx
    SetMetaSpritePosition #MARIO_SPRITE_INDEX, mario, #mario_size, mx, my

    jsr animate_mario

    lda #$00
    sta OAM_ADDR
    lda #$02
    sta OAM_DMA
    rti

  animate_mario:
    lda #MARIO_ANIM_SPEED
    beq @done
    dec mario_anim_countdown
    cmp mario_anim_countdown
    beq @anim_time
    rts
    @anim_time:
    lda #$FF
    sta mario_anim_countdown
    inc mario_anim_frame
    lda mario_anim_frame
    cmp #4
    bne :+
    lda #0 ;loop anim frame back to 0
    sta mario_anim_frame
    :

    pha ; push original, not multiplied anim frame to stack for later
    multiply mario_anim_frame, #4
    clc
    adc mario_anim_frame
    sta mario_anim_frame

    AnimateMetaSprite #MARIO_SPRITE_INDEX, #mario_size, mario_walk, mario_anim_frame

    pla
    sta mario_anim_frame
    @done:
    rts

.segment "VECTORS" ; for interrupt handlers and shiz
  .word NMI
  .word Reset

.segment "CHARS"
  .incbin "bin/mario.chr"