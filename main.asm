;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.4 #11941 (Mac OS X x86_64)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _game
	.globl _init_game
	.globl _gbt_update
	.globl _gbt_loop
	.globl _gbt_play
	.globl _wait_vbl_done
	.globl _set_interrupts
	.globl _disable_interrupts
	.globl _enable_interrupts
	.globl _set_sprite_palette
	.globl _set_bkg_palette
	.globl _palette_table
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
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
;src/main.c:23: void	main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-16
;src/main.c:25: set_bkg_palette(0, 1, &palette_table[0]);
	ld	hl, #_palette_table
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
;src/main.c:26: set_sprite_palette(0, 1, &palette_table[8]);
	ld	hl, #(_palette_table + 0x0010)
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_sprite_palette
	add	sp, #4
;src/main.c:29: disable_interrupts();
	call	_disable_interrupts
;src/main.c:30: gbt_play(song_Data, 2, 7);
	ld	de, #0x0702
	push	de
	ld	hl, #_song_Data
	push	hl
	call	_gbt_play
	add	sp, #4
;src/main.c:31: gbt_loop(0);
	xor	a, a
	push	af
	inc	sp
	call	_gbt_loop
	inc	sp
;src/main.c:33: set_interrupts(VBL_IFLAG);
	ld	a, #0x01
	push	af
	inc	sp
	call	_set_interrupts
	inc	sp
;src/main.c:34: enable_interrupts();
	call	_enable_interrupts
;src/main.c:43: fire.o = 0;
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	ld	hl, #0x0007
	add	hl, bc
	ld	(hl), #0x00
;src/main.c:44: init_game();
	push	bc
	call	_init_game
	pop	bc
;src/main.c:45: while (1) {
00102$:
;src/main.c:46: wait_vbl_done();
	call	_wait_vbl_done
;src/main.c:47: game(&fire, &pl);
	ldhl	sp,	#8
	ld	e, c
	ld	d, b
	push	bc
	push	hl
	push	de
	call	_game
	add	sp, #4
	call	_gbt_update
	pop	bc
	jr	00102$
;src/main.c:52: }
	add	sp, #16
	ret
_palette_table:
	.dw #0x5ff9
	.dw #0x3fb3
	.dw #0x4209
	.dw #0x1884
	.dw #0x5ff9
	.dw #0x5ff9
	.dw #0x4209
	.dw #0x1884
	.dw #0x7fbf
	.dw #0x7fbf
	.dw #0x39b4
	.dw #0x1465
	.dw #0x3fb3
	.dw #0x3fb3
	.dw #0x4209
	.dw #0x1884
	.dw #0x4209
	.dw #0x4209
	.dw #0x4209
	.dw #0x1884
	.dw #0x1884
	.dw #0x1884
	.dw #0x1884
	.dw #0x1884
	.area _CODE
	.area _CABS (ABS)
