;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.2 #14228 (MINGW64)
;--------------------------------------------------------
	.module smoketest
	.optsdcc -mmos6502
	
	.globl __TEMP
	.globl __DPTR
	.area _ZP      (PAG)
__TEMP:	.ds 8
__DPTR:	.ds 2
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _grav
	.globl _dudeHeight
	.globl _dudeWidth
	.globl _dudeSprite
	.globl _tilemap
	.globl _tiledata
	.globl _main
	.globl _copy_dude
	.globl _create_dude
	.globl _randRange
	.globl _set_sprite_data
	.globl _display_on
	.globl _vsync
	.globl _joypad
	.globl _rand
	.globl _initrand
	.globl _dudesLen
	.globl _sprPalette
	.globl _bkgPalette
	.globl _screenH
	.globl _screenW
	.globl _copy_dude_PARM_2
	.globl _create_dude_PARM_6
	.globl _create_dude_PARM_5
	.globl _create_dude_PARM_4
	.globl _create_dude_PARM_3
	.globl _create_dude_PARM_2
	.globl _randRange_PARM_2
	.globl _OAMDMA
	.globl _PPUDATA
	.globl _PPUADDR
	.globl _PPUSCROLL
	.globl _OAMDATA
	.globl _OAMADDR
	.globl _PPUSTATUS
	.globl _PPUMASK
	.globl _PPUCTRL
;--------------------------------------------------------
; ZP ram data
;--------------------------------------------------------
	.area _ZP      (PAG)
_main_sloc0_1_0:
	.ds 2
_main_sloc1_1_0:
	.ds 2
_main_sloc2_1_0:
	.ds 2
_main_sloc3_1_0:
	.ds 2
;--------------------------------------------------------
; overlayable items in ram
;--------------------------------------------------------
	.area	OSEG    (PAG, OVR)
_create_dude_sloc0_1_0:
	.ds 2
	.area	OSEG    (PAG, OVR)
_copy_dude_sloc0_1_0:
	.ds 2
_copy_dude_sloc1_1_0:
	.ds 2
;--------------------------------------------------------
; uninitialized external ram data
;--------------------------------------------------------
	.area _BSS
_PPUCTRL	=	0x2000
_PPUMASK	=	0x2001
_PPUSTATUS	=	0x2002
_OAMADDR	=	0x2003
_OAMDATA	=	0x2004
_PPUSCROLL	=	0x2005
_PPUADDR	=	0x2006
_PPUDATA	=	0x2007
_OAMDMA	=	0x4014
_randRange_PARM_2:
	.ds 2
_randRange_min_65536_137:
	.ds 2
_randRange_range_65536_138:
	.ds 2
_create_dude_PARM_2:
	.ds 2
_create_dude_PARM_3:
	.ds 2
_create_dude_PARM_4:
	.ds 2
_create_dude_PARM_5:
	.ds 2
_create_dude_PARM_6:
	.ds 2
_copy_dude_PARM_2:
	.ds 2
_copy_dude_original_65536_141:
	.ds 2
_main_dudes_65537_145:
	.ds 4080
_main_new_dude_65537_145:
	.ds 16
_main_new_dude_196610_148:
	.ds 16
_main_spd_196610_148:
	.ds 2
_main_xv_196610_148:
	.ds 2
_main___3276810010_327681_159:
	.ds 1
_main___3276810011_327681_159:
	.ds 1
_main_itm_458753_161:
	.ds 2
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS    (ABS)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area _DATA
_screenW::
	.ds 2
_screenH::
	.ds 2
_bkgPalette::
	.ds 8
_sprPalette::
	.ds 8
_dudesLen::
	.ds 2
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;------------------------------------------------------------
;Allocation info for local variables in function 'randRange'
;------------------------------------------------------------
;max                       Allocated with name '_randRange_PARM_2'
;min                       Allocated with name '_randRange_min_65536_137'
;range                     Allocated with name '_randRange_range_65536_138'
;randomValue               Allocated to registers a x 
;result                    Allocated to registers a x 
;------------------------------------------------------------
;	smoketest.c: 72: int randRange(int min, int max) {
;	-----------------------------------------
;	 function randRange
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_randRange:
	sta	_randRange_min_65536_137
	stx	(_randRange_min_65536_137 + 1)
;	smoketest.c: 74: int range = max - min + 1;
	lda	_randRange_PARM_2
	sec
	sbc	_randRange_min_65536_137
	pha
	lda	(_randRange_PARM_2 + 1)
	sbc	(_randRange_min_65536_137 + 1)
	tax
	pla
	clc
	adc	#0x01
	sta	_randRange_range_65536_138
	txa
	adc	#0x00
	sta	(_randRange_range_65536_138 + 1)
;	smoketest.c: 77: int randomValue = rand() % 256;
	jsr	_rand
	ldx	#0x00
;	smoketest.c: 80: int result = min + (randomValue % range);
	ldy	_randRange_range_65536_138
	sty	__modsint_PARM_2
	ldy	(_randRange_range_65536_138 + 1)
	sty	(__modsint_PARM_2 + 1)
	jsr	__modsint
	clc
	adc	_randRange_min_65536_137
	pha
	txa
	adc	(_randRange_min_65536_137 + 1)
	tax
	pla
;	smoketest.c: 82: return result;
;	smoketest.c: 83: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'create_dude'
;------------------------------------------------------------
;y                         Allocated with name '_create_dude_PARM_2'
;xv                        Allocated with name '_create_dude_PARM_3'
;yv                        Allocated with name '_create_dude_PARM_4'
;id                        Allocated with name '_create_dude_PARM_5'
;d                         Allocated with name '_create_dude_PARM_6'
;x                         Allocated to registers a x 
;sloc0                     Allocated with name '_create_dude_sloc0_1_0'
;------------------------------------------------------------
;	smoketest.c: 85: void create_dude(int x, int y, int xv, int yv, int id, struct dude *d)
;	-----------------------------------------
;	 function create_dude
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_create_dude:
;	smoketest.c: 87: d->x = x;
	ldy	_create_dude_PARM_6
	sty	*_create_dude_sloc0_1_0
	ldy	(_create_dude_PARM_6 + 1)
	sty	*(_create_dude_sloc0_1_0 + 1)
	ldy	#0x00
	sta	[*_create_dude_sloc0_1_0],y
	txa
	iny
	sta	[*_create_dude_sloc0_1_0],y
;	smoketest.c: 88: d->y = y;
	lda	*_create_dude_sloc0_1_0
	ldx	*(_create_dude_sloc0_1_0 + 1)
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	lda	_create_dude_PARM_2
	iny
	sta	[__DPTR],y
	lda	(_create_dude_PARM_2 + 1)
	iny
	sta	[__DPTR],y
;	smoketest.c: 89: d->xv = xv;
	lda	*_create_dude_sloc0_1_0
	ldx	*(_create_dude_sloc0_1_0 + 1)
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	lda	_create_dude_PARM_3
	ldy	#0x08
	sta	[__DPTR],y
	lda	(_create_dude_PARM_3 + 1)
	iny
	sta	[__DPTR],y
;	smoketest.c: 90: d->yv = yv;
	lda	*_create_dude_sloc0_1_0
	ldx	*(_create_dude_sloc0_1_0 + 1)
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	lda	_create_dude_PARM_4
	iny
	sta	[__DPTR],y
	lda	(_create_dude_PARM_4 + 1)
	iny
	sta	[__DPTR],y
;	smoketest.c: 91: d->onGround = 0;
	lda	*_create_dude_sloc0_1_0
	ldx	*(_create_dude_sloc0_1_0 + 1)
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	lda	#0x00
	iny
	sta	[__DPTR],y
	iny
	sta	[__DPTR],y
;	smoketest.c: 92: d->id = id;
	lda	*_create_dude_sloc0_1_0
	ldx	*(_create_dude_sloc0_1_0 + 1)
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	lda	_create_dude_PARM_5
	iny
	sta	[__DPTR],y
	lda	(_create_dude_PARM_5 + 1)
	iny
	sta	[__DPTR],y
;	smoketest.c: 93: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'copy_dude'
;------------------------------------------------------------
;copy                      Allocated with name '_copy_dude_PARM_2'
;original                  Allocated with name '_copy_dude_original_65536_141'
;sloc0                     Allocated with name '_copy_dude_sloc0_1_0'
;sloc1                     Allocated with name '_copy_dude_sloc1_1_0'
;------------------------------------------------------------
;	smoketest.c: 95: void copy_dude(struct dude *original, struct dude *copy)
;	-----------------------------------------
;	 function copy_dude
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_copy_dude:
	sta	_copy_dude_original_65536_141
	stx	(_copy_dude_original_65536_141 + 1)
;	smoketest.c: 98: copy->x = original->x;
	lda	_copy_dude_PARM_2
	sta	*_copy_dude_sloc0_1_0
	lda	(_copy_dude_PARM_2 + 1)
	sta	*(_copy_dude_sloc0_1_0 + 1)
	lda	_copy_dude_original_65536_141
	sta	*(__DPTR+0)
	lda	(_copy_dude_original_65536_141 + 1)
	sta	*(__DPTR+1)
	ldy	#0x01
	lda	[__DPTR],y
	tax
	dey
	lda	[__DPTR],y
	sta	[*_copy_dude_sloc0_1_0],y
	txa
	iny
	sta	[*_copy_dude_sloc0_1_0],y
;	smoketest.c: 99: copy->y = original->y;
	lda	*_copy_dude_sloc0_1_0
	sta	*_copy_dude_sloc1_1_0
	lda	*(_copy_dude_sloc0_1_0 + 1)
	sta	*(_copy_dude_sloc1_1_0 + 1)
	lda	_copy_dude_original_65536_141
	ldx	(_copy_dude_original_65536_141 + 1)
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	ldy	#0x03
	lda	[__DPTR],y
	tax
	dey
	lda	[__DPTR],y
	sta	[*_copy_dude_sloc1_1_0],y
	txa
	iny
	sta	[*_copy_dude_sloc1_1_0],y
;	smoketest.c: 100: copy->xv = original->xv;
	lda	*_copy_dude_sloc0_1_0
	sta	*_copy_dude_sloc1_1_0
	lda	*(_copy_dude_sloc0_1_0 + 1)
	sta	*(_copy_dude_sloc1_1_0 + 1)
	lda	_copy_dude_original_65536_141
	ldx	(_copy_dude_original_65536_141 + 1)
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	ldy	#0x09
	lda	[__DPTR],y
	tax
	dey
	lda	[__DPTR],y
	sta	[*_copy_dude_sloc1_1_0],y
	txa
	iny
	sta	[*_copy_dude_sloc1_1_0],y
;	smoketest.c: 101: copy->yv = original->yv;
	lda	*_copy_dude_sloc0_1_0
	sta	*_copy_dude_sloc1_1_0
	lda	*(_copy_dude_sloc0_1_0 + 1)
	sta	*(_copy_dude_sloc1_1_0 + 1)
	lda	_copy_dude_original_65536_141
	ldx	(_copy_dude_original_65536_141 + 1)
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	ldy	#0x0b
	lda	[__DPTR],y
	tax
	dey
	lda	[__DPTR],y
	sta	[*_copy_dude_sloc1_1_0],y
	txa
	iny
	sta	[*_copy_dude_sloc1_1_0],y
;	smoketest.c: 102: copy->id = original->id;
	lda	*_copy_dude_sloc0_1_0
	sta	*_copy_dude_sloc1_1_0
	lda	*(_copy_dude_sloc0_1_0 + 1)
	sta	*(_copy_dude_sloc1_1_0 + 1)
	lda	_copy_dude_original_65536_141
	ldx	(_copy_dude_original_65536_141 + 1)
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	ldy	#0x0f
	lda	[__DPTR],y
	tax
	dey
	lda	[__DPTR],y
	sta	[*_copy_dude_sloc1_1_0],y
	txa
	iny
	sta	[*_copy_dude_sloc1_1_0],y
;	smoketest.c: 104: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;sloc0                     Allocated with name '_main_sloc0_1_0'
;sloc1                     Allocated with name '_main_sloc1_1_0'
;sloc2                     Allocated with name '_main_sloc2_1_0'
;sloc3                     Allocated with name '_main_sloc3_1_0'
;dudes                     Allocated with name '_main_dudes_65537_145'
;new_dude                  Allocated with name '_main_new_dude_65537_145'
;new_dude                  Allocated with name '_main_new_dude_196610_148'
;spd                       Allocated with name '_main_spd_196610_148'
;xv                        Allocated with name '_main_xv_196610_148'
;yv                        Allocated to registers 
;__2621460006              Allocated to registers a 
;__2621460007              Allocated to registers 
;nb                        Allocated to registers 
;tile                      Allocated to registers 
;i                         Allocated to registers 
;__3276810009              Allocated to registers a 
;__3276810010              Allocated with name '_main___3276810010_327681_159'
;__3276810011              Allocated with name '_main___3276810011_327681_159'
;nb                        Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;itm                       Allocated with name '_main_itm_458753_161'
;------------------------------------------------------------
;	smoketest.c: 106: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	smoketest.c: 108: initrand(69);
	ldx	#0x00
	lda	#0x45
	jsr	_initrand
;	smoketest.c: 112: create_dude(100, 25, -1, 1, dudesLen, &new_dude);
	lda	#_main_new_dude_65537_145
	sta	_create_dude_PARM_6
	lda	#>_main_new_dude_65537_145
	sta	(_create_dude_PARM_6 + 1)
	ldx	#0x19
	stx	_create_dude_PARM_2
	ldx	#0x00
	stx	(_create_dude_PARM_2 + 1)
	dex
	stx	_create_dude_PARM_3
	stx	(_create_dude_PARM_3 + 1)
	ldx	#0x01
	stx	_create_dude_PARM_4
	dex
	stx	(_create_dude_PARM_4 + 1)
	lda	_dudesLen
	sta	_create_dude_PARM_5
	lda	(_dudesLen + 1)
	sta	(_create_dude_PARM_5 + 1)
	lda	#0x64
	jsr	_create_dude
;	smoketest.c: 113: dudes[dudesLen] = new_dude;
	lda	_dudesLen
	ldx	(_dudesLen + 1)
	stx	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	ldx	*(__TEMP+0)
	clc
	adc	#_main_dudes_65537_145
	pha
	txa
	adc	#>_main_dudes_65537_145
	tax
	pla
	ldy	#_main_new_dude_65537_145
	sty	___memcpy_PARM_2
	ldy	#>_main_new_dude_65537_145
	sty	(___memcpy_PARM_2 + 1)
	ldy	#0x10
	sty	___memcpy_PARM_3
	ldy	#0x00
	sty	(___memcpy_PARM_3 + 1)
	jsr	___memcpy
;	smoketest.c: 114: dudesLen++;
	inc	_dudesLen
	bne	00175$
	inc	(_dudesLen + 1)
00175$:
;	smoketest.c: 128: set_sprite_data(0, 1, dudeSprite);
	lda	#_dudeSprite
	sta	_set_sprite_data_PARM_3
	lda	#>_dudeSprite
	sta	(_set_sprite_data_PARM_3 + 1)
	lda	#0x00
	ldx	#0x01
	jsr	_set_sprite_data
;	smoketest.c: 130: DISPLAY_ON;
	jsr	_display_on
;	smoketest.c: 131: SHOW_SPRITES;
	lda	_shadow_PPUMASK
	ora	#0x10
	sta	_shadow_PPUMASK
;	smoketest.c: 133: while (1)
00117$:
;	smoketest.c: 135: vsync();
	jsr	_vsync
;	smoketest.c: 137: switch (joypad())
	jsr	_joypad
	cmp	#0x10
	beq	00176$
	jmp	00134$
00176$:
;	smoketest.c: 141: int spd = randRange(1,5);
	ldx	#0x05
	stx	_randRange_PARM_2
	ldx	#0x00
	stx	(_randRange_PARM_2 + 1)
	lda	#0x01
	jsr	_randRange
;	smoketest.c: 142: int xv = spd;
	sta	_main_spd_196610_148
	stx	(_main_spd_196610_148 + 1)
	sta	_main_xv_196610_148
	stx	(_main_xv_196610_148 + 1)
;	smoketest.c: 144: if(randRange(0,10) > 5){xv = -xv;}
	ldx	#0x0a
	stx	_randRange_PARM_2
	ldx	#0x00
	stx	(_randRange_PARM_2 + 1)
	txa
	jsr	_randRange
	sta	*(__TEMP+0)
	lda	#0x05
	sec
	sbc	*(__TEMP+0)
	lda	#0x00
	stx	*(__TEMP+0)
	sbc	*(__TEMP+0)
	bvc	00178$
	bpl	00177$
	bmi	00103$
00178$:
	bpl	00103$
00177$:
	lda	#0x00
	sec
	sbc	_main_spd_196610_148
	sta	_main_xv_196610_148
	lda	#0x00
	sbc	(_main_spd_196610_148 + 1)
	sta	(_main_xv_196610_148 + 1)
00103$:
;	smoketest.c: 145: if(randRange(0,10) > 5){yv = -yv;}
	ldx	#0x0a
	stx	_randRange_PARM_2
	ldx	#0x00
	stx	(_randRange_PARM_2 + 1)
	txa
	jsr	_randRange
;	smoketest.c: 147: create_dude(rand(), rand(), xv, 1, dudesLen, &new_dude);
	jsr	_rand
	sta	*_main_sloc0_1_0
	ldx	#0x00
	stx	*(_main_sloc0_1_0 + 1)
	jsr	_rand
	sta	_create_dude_PARM_2
	ldx	#0x00
	stx	(_create_dude_PARM_2 + 1)
	lda	#_main_new_dude_196610_148
	sta	_create_dude_PARM_6
	lda	#>_main_new_dude_196610_148
	sta	(_create_dude_PARM_6 + 1)
	lda	_main_xv_196610_148
	sta	_create_dude_PARM_3
	lda	(_main_xv_196610_148 + 1)
	sta	(_create_dude_PARM_3 + 1)
	inx
	stx	_create_dude_PARM_4
	dex
	stx	(_create_dude_PARM_4 + 1)
	lda	_dudesLen
	sta	_create_dude_PARM_5
	lda	(_dudesLen + 1)
	sta	(_create_dude_PARM_5 + 1)
	ldx	*(_main_sloc0_1_0 + 1)
	lda	*_main_sloc0_1_0
	jsr	_create_dude
;	smoketest.c: 148: dudes[dudesLen] = new_dude;
	lda	_dudesLen
	ldx	(_dudesLen + 1)
	stx	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	ldx	*(__TEMP+0)
	clc
	adc	#_main_dudes_65537_145
	pha
	txa
	adc	#>_main_dudes_65537_145
	tax
	pla
	ldy	#_main_new_dude_196610_148
	sty	___memcpy_PARM_2
	ldy	#>_main_new_dude_196610_148
	sty	(___memcpy_PARM_2 + 1)
	ldy	#0x10
	sty	___memcpy_PARM_3
	ldy	#0x00
	sty	(___memcpy_PARM_3 + 1)
	jsr	___memcpy
;	smoketest.c: 149: set_sprite_tile(dudesLen, 0);
	lda	_dudesLen
;	c:\gbdk\include\nes\nes.h: 1007: shadow_OAM[nb].tile=tile;
	ldx	#0x00
	stx	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	ldx	*(__TEMP+0)
	clc
	adc	#_shadow_OAM
	pha
	txa
	adc	#>_shadow_OAM
	tax
	pla
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	lda	#0x00
	ldy	#0x01
	sta	[__DPTR],y
;	smoketest.c: 150: dudesLen++;
	inc	_dudesLen
	bne	00180$
	inc	(_dudesLen + 1)
00180$:
;	smoketest.c: 154: for (int i = 0; i < dudesLen; i++)
00134$:
	ldx	#0x00
	stx	*_main_sloc0_1_0
	stx	*(_main_sloc0_1_0 + 1)
00122$:
	lda	*_main_sloc0_1_0
	ldx	*(_main_sloc0_1_0 + 1)
	sec
	sbc	_dudesLen
	txa
	sbc	(_dudesLen + 1)
	bcc	00181$
	jmp	00117$
00181$:
;	smoketest.c: 166: if(dudes[i].x + dudeWidth >= screenW || dudes[i].x <= 0){
	lda	*_main_sloc0_1_0
	ldx	*(_main_sloc0_1_0 + 1)
	stx	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	ldx	*(__TEMP+0)
	clc
	adc	#<(_main_dudes_65537_145+0)
	sta	*(__DPTR+0)
	txa
	adc	#>(_main_dudes_65537_145+0)
	sta	*(__DPTR+1)
	ldy	#0x00
	lda	[__DPTR],y
	sta	*_main_sloc1_1_0
	iny
	lda	[__DPTR],y
	sta	*(_main_sloc1_1_0 + 1)
	lda	*_main_sloc1_1_0
	ldx	*(_main_sloc1_1_0 + 1)
	clc
	adc	_dudeWidth
	pha
	txa
	adc	(_dudeWidth + 1)
	tax
	pla
	sec
	sbc	_screenW
	txa
	sbc	(_screenW + 1)
	bcs	00107$
	lda	#0x00
	sec
	sbc	*_main_sloc1_1_0
	lda	#0x00
	sbc	*(_main_sloc1_1_0 + 1)
	bvs	00184$
	bpl	00183$
	bmi	00108$
00184$:
	bpl	00108$
00183$:
00107$:
;	smoketest.c: 167: dudes[i].xv = -dudes[i].xv;
	lda	*_main_sloc0_1_0
	ldx	*(_main_sloc0_1_0 + 1)
	stx	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	ldx	*(__TEMP+0)
	clc
	adc	#_main_dudes_65537_145
	pha
	txa
	adc	#>_main_dudes_65537_145
	tax
	pla
	sta	*_main_sloc1_1_0
	stx	*(_main_sloc1_1_0 + 1)
	ldy	#0x09
	lda	[*_main_sloc1_1_0],y
	tax
	dey
	lda	[*_main_sloc1_1_0],y
	eor	#0xff
	clc
	adc	#0x01
	pha
	lda	#0x00
	stx	*(__TEMP+0)
	sbc	*(__TEMP+0)
	tax
	pla
	sta	[*_main_sloc1_1_0],y
	txa
	iny
	sta	[*_main_sloc1_1_0],y
00108$:
;	smoketest.c: 170: if(dudes[i].y + dudeHeight >= screenH || dudes[i].y <= 0){
	lda	*_main_sloc0_1_0
	ldx	*(_main_sloc0_1_0 + 1)
	stx	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	ldx	*(__TEMP+0)
	clc
	adc	#_main_dudes_65537_145
	pha
	txa
	adc	#>_main_dudes_65537_145
	tax
	pla
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	ldy	#0x02
	lda	[__DPTR],y
	sta	*_main_sloc1_1_0
	iny
	lda	[__DPTR],y
	sta	*(_main_sloc1_1_0 + 1)
	lda	*_main_sloc1_1_0
	ldx	*(_main_sloc1_1_0 + 1)
	clc
	adc	_dudeHeight
	pha
	txa
	adc	(_dudeHeight + 1)
	tax
	pla
	sec
	sbc	_screenH
	txa
	sbc	(_screenH + 1)
	bcs	00110$
	lda	#0x00
	sec
	sbc	*_main_sloc1_1_0
	lda	#0x00
	sbc	*(_main_sloc1_1_0 + 1)
	bvs	00188$
	bpl	00187$
	bmi	00111$
00188$:
	bpl	00111$
00187$:
00110$:
;	smoketest.c: 171: dudes[i].yv = -dudes[i].yv;
	lda	*_main_sloc0_1_0
	ldx	*(_main_sloc0_1_0 + 1)
	stx	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	ldx	*(__TEMP+0)
	clc
	adc	#_main_dudes_65537_145
	pha
	txa
	adc	#>_main_dudes_65537_145
	tax
	pla
	sta	*_main_sloc1_1_0
	stx	*(_main_sloc1_1_0 + 1)
	ldy	#0x0b
	lda	[*_main_sloc1_1_0],y
	tax
	dey
	lda	[*_main_sloc1_1_0],y
	eor	#0xff
	clc
	adc	#0x01
	pha
	lda	#0x00
	stx	*(__TEMP+0)
	sbc	*(__TEMP+0)
	tax
	pla
	sta	[*_main_sloc1_1_0],y
	txa
	iny
	sta	[*_main_sloc1_1_0],y
00111$:
;	smoketest.c: 178: if(dudes[i].onGround == 0){
	lda	*_main_sloc0_1_0
	ldx	*(_main_sloc0_1_0 + 1)
	stx	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	ldx	*(__TEMP+0)
	clc
	adc	#_main_dudes_65537_145
	sta	*_main_sloc1_1_0
	txa
	adc	#>_main_dudes_65537_145
	sta	*(_main_sloc1_1_0 + 1)
	lda	*_main_sloc1_1_0
	ldx	*(_main_sloc1_1_0 + 1)
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	ldy	#0x0d
	lda	[__DPTR],y
	tax
	dey
	lda	[__DPTR],y
	cmp	#0x00
	bne	00190$
	cpx	#0x00
00190$:
	bne	00114$
;	smoketest.c: 179: dudes[i].yv += grav;
	lda	*_main_sloc1_1_0
	sta	*_main_sloc2_1_0
	lda	*(_main_sloc1_1_0 + 1)
	sta	*(_main_sloc2_1_0 + 1)
	dey
	lda	[*_main_sloc2_1_0],y
	tax
	dey
	lda	[*_main_sloc2_1_0],y
	clc
	adc	#0x01
	sta	*_main_sloc3_1_0
	txa
	adc	#0x00
	sta	*(_main_sloc3_1_0 + 1)
	lda	*_main_sloc3_1_0
	sta	[*_main_sloc2_1_0],y
	lda	*(_main_sloc3_1_0 + 1)
	iny
	sta	[*_main_sloc2_1_0],y
;	smoketest.c: 180: dudes[i].y += dudes[i].yv;
	lda	*_main_sloc1_1_0
	sta	*_main_sloc2_1_0
	lda	*(_main_sloc1_1_0 + 1)
	sta	*(_main_sloc2_1_0 + 1)
	ldy	#0x03
	lda	[*_main_sloc2_1_0],y
	tax
	dey
	lda	[*_main_sloc2_1_0],y
	clc
	adc	*_main_sloc3_1_0
	pha
	txa
	adc	*(_main_sloc3_1_0 + 1)
	tax
	pla
	sta	[*_main_sloc2_1_0],y
	txa
	iny
	sta	[*_main_sloc2_1_0],y
00114$:
;	smoketest.c: 185: dudes[i].x += dudes[i].xv;
	lda	*_main_sloc0_1_0
	ldx	*(_main_sloc0_1_0 + 1)
	stx	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	ldx	*(__TEMP+0)
	sta	*_main_sloc3_1_0
	stx	*(_main_sloc3_1_0 + 1)
	sta	*(__TEMP+0)
	stx	*(__TEMP+1)
	clc
	lda	*_main_sloc3_1_0
	adc	#<(_main_dudes_65537_145+0)
	sta	*(__DPTR+0)
	lda	*(_main_sloc3_1_0 + 1)
	adc	#>(_main_dudes_65537_145+0)
	sta	*(__DPTR+1)
	ldy	#0x00
	lda	[__DPTR],y
	sta	*_main_sloc2_1_0
	iny
	lda	[__DPTR],y
	sta	*(_main_sloc2_1_0 + 1)
	ldx	*(__TEMP+1)
	lda	*(__TEMP+0)
	clc
	adc	#_main_dudes_65537_145
	sta	*_main_sloc1_1_0
	txa
	adc	#>_main_dudes_65537_145
	sta	*(_main_sloc1_1_0 + 1)
	lda	*_main_sloc1_1_0
	ldx	*(_main_sloc1_1_0 + 1)
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	ldy	#0x09
	lda	[__DPTR],y
	tax
	dey
	lda	[__DPTR],y
	clc
	adc	*_main_sloc2_1_0
	sta	*_main_sloc2_1_0
	txa
	adc	*(_main_sloc2_1_0 + 1)
	sta	*(_main_sloc2_1_0 + 1)
	clc
	lda	*_main_sloc3_1_0
	adc	#<(_main_dudes_65537_145+0)
	sta	*(__DPTR+0)
	lda	*(_main_sloc3_1_0 + 1)
	adc	#>(_main_dudes_65537_145+0)
	sta	*(__DPTR+1)
	lda	*_main_sloc2_1_0
	ldy	#0x00
	sta	[__DPTR],y
	lda	*(_main_sloc2_1_0 + 1)
	iny
	sta	[__DPTR],y
;	smoketest.c: 186: move_sprite(dudes[i].id, dudes[i].x, dudes[i].y);
	lda	*_main_sloc1_1_0
	ldx	*(_main_sloc1_1_0 + 1)
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	iny
	lda	[__DPTR],y
	sta	_main___3276810011_327681_159
	ldy	#0x00
	lda	[*_main_sloc1_1_0],y
	sta	_main___3276810010_327681_159
	lda	*_main_sloc1_1_0
	ldx	*(_main_sloc1_1_0 + 1)
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	ldy	#0x0e
	lda	[__DPTR],y
;	c:\gbdk\include\nes\nes.h: 1077: OAM_item_t * itm = &shadow_OAM[nb];
	ldx	#0x00
	stx	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	asl	a
	rol	*(__TEMP+0)
	ldx	*(__TEMP+0)
	clc
	adc	#_shadow_OAM
	pha
	txa
	adc	#>_shadow_OAM
	tax
	pla
;	c:\gbdk\include\nes\nes.h: 1078: itm->y=y, itm->x=x;
	sta	_main_itm_458753_161
	stx	(_main_itm_458753_161 + 1)
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	lda	_main___3276810011_327681_159
	ldy	#0x00
	sta	[__DPTR],y
	lda	_main_itm_458753_161
	ldx	(_main_itm_458753_161 + 1)
	sta	*(__DPTR+0)
	stx	*(__DPTR+1)
	lda	_main___3276810010_327681_159
	ldy	#0x03
	sta	[__DPTR],y
;	smoketest.c: 154: for (int i = 0; i < dudesLen; i++)
	inc	*_main_sloc0_1_0
	bne	00192$
	inc	*(_main_sloc0_1_0 + 1)
00192$:
	jmp	00122$
;	smoketest.c: 192: }
	rts
	.area _CODE
_tiledata:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xc1	; 193
	.db #0xc1	; 193
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xf8	; 248
	.db #0xf8	; 248
_tilemap:
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x12	; 18
	.db #0x15	; 21
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x17	; 23
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1a	; 26
	.db #0x04	; 4
	.db #0x1b	; 27
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1d	; 29
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x21	; 33
	.db #0x22	; 34
	.db #0x23	; 35
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x12	; 18
	.db #0x25	; 37
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x29	; 41
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2b	; 43
	.db #0x2c	; 44
	.db #0x2d	; 45
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2e	; 46
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x2f	; 47
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x32	; 50	'2'
	.db #0x33	; 51	'3'
	.db #0x00	; 0
	.db #0x34	; 52	'4'
	.db #0x35	; 53	'5'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x36	; 54	'6'
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x37	; 55	'7'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x39	; 57	'9'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3d	; 61
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x46	; 70	'F'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x47	; 71	'G'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x36	; 54	'6'
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x3e	; 62
	.db #0x48	; 72	'H'
	.db #0x49	; 73	'I'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x4a	; 74	'J'
	.db #0x49	; 73	'I'
	.db #0x4b	; 75	'K'
	.db #0x4c	; 76	'L'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x4d	; 77	'M'
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x3e	; 62
	.db #0x4e	; 78	'N'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x4f	; 79	'O'
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x51	; 81	'Q'
	.db #0x52	; 82	'R'
	.db #0x53	; 83	'S'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x54	; 84	'T'
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x56	; 86	'V'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x57	; 87	'W'
	.db #0x58	; 88	'X'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x59	; 89	'Y'
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x2f	; 47
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x2a	; 42
	.db #0x5b	; 91
	.db #0x5c	; 92
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5d	; 93
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5e	; 94
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x5f	; 95
	.db #0x00	; 0
	.db #0x32	; 50	'2'
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3a	; 58
	.db #0x61	; 97	'a'
	.db #0x62	; 98	'b'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x63	; 99	'c'
	.db #0x64	; 100	'd'
	.db #0x62	; 98	'b'
	.db #0x00	; 0
	.db #0x65	; 101	'e'
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x67	; 103	'g'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x68	; 104	'h'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x69	; 105	'i'
	.db #0x6a	; 106	'j'
	.db #0x6b	; 107	'k'
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x6c	; 108	'l'
	.db #0x6d	; 109	'm'
	.db #0x6e	; 110	'n'
	.db #0x6f	; 111	'o'
	.db #0x70	; 112	'p'
	.db #0x71	; 113	'q'
	.db #0x72	; 114	'r'
	.db #0x73	; 115	's'
	.db #0x73	; 115	's'
	.db #0x74	; 116	't'
	.db #0x75	; 117	'u'
	.db #0x76	; 118	'v'
	.db #0x77	; 119	'w'
	.db #0x78	; 120	'x'
	.db #0x79	; 121	'y'
	.db #0x7a	; 122	'z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7b	; 123
	.db #0x7c	; 124
	.db #0x7d	; 125
	.db #0x7e	; 126
	.db #0x7f	; 127
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x82	; 130
_dudeSprite:
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0xa5	; 165
	.db #0xa5	; 165
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0xdb	; 219
	.db #0xdb	; 219
	.db #0xc3	; 195
	.db #0xc3	; 195
	.db #0x3c	; 60
	.db #0x3c	; 60
_dudeWidth:
	.dw #0x0008
_dudeHeight:
	.dw #0x0008
_grav:
	.db #0x01	;  1
	.area _XINIT
__xinit__screenW:
	.dw #0x0100
__xinit__screenH:
	.dw #0x00f0
__xinit__bkgPalette:
	.dw #0x0003
	.dw #0x003f
	.dw #0x0016
	.dw #0x0008
__xinit__sprPalette:
	.dw #0x0019
	.dw #0x0001
	.dw #0x0006
	.dw #0x0028
__xinit__dudesLen:
	.dw #0x0000
	.area _CABS    (ABS)
