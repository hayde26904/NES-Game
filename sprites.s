mario:
    .byte $00, $32, $00, $00
    .byte $00, $33, $00, $08
    .byte $08, $34, $00, $00
    .byte $08, $35, $00, $08

mario_size = 16

balls:
    .byte $00, $0B, $01, $00 ; Ypos, Tile, Attributes, Xpos
    .byte $00, $0A, $01, $08
    .byte $00, $15, $01, $10
    .byte $00, $15, $01, $18
    .byte $00, $1C, $01, $20