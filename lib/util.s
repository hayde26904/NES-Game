.macro multiply op1, op2
    lda op1 ; if one of the operands is zero, exit
    beq :++
    lda op2
    beq :++

    ldx #0
    lda #0
:
    clc
    adc op1
    inx
    cpx op2
    bne :-
:
    bne :+
    lda #0
:
.endmacro