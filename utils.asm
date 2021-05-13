;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.4 #11941 (Mac OS X x86_64)
;--------------------------------------------------------
	.module utils
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gbt_update
	.globl _wait_vbl_done
	.globl _joypad
	.globl _perform_delay
	.globl _perform_delay_joypad
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
;src/utils.c:9: void	perform_delay(UINT8 time) {
;	---------------------------------
; Function perform_delay
; ---------------------------------
_perform_delay::
;src/utils.c:12: while (i++ < time) {
	ld	c, #0x00
00101$:
	ld	a, c
	ldhl	sp,	#2
	sub	a, (hl)
	ret	NC
	inc	c
;src/utils.c:13: wait_vbl_done();
	call	_wait_vbl_done
;src/utils.c:15: gbt_update();
	push	bc
	call	_gbt_update
	pop	bc
;src/utils.c:17: }
	jr	00101$
;src/utils.c:19: UINT8	perform_delay_joypad(UINT8 time) {
;	---------------------------------
; Function perform_delay_joypad
; ---------------------------------
_perform_delay_joypad::
;src/utils.c:23: while (i++ < time) {
	ld	c, #0x00
00104$:
	ld	a, c
	ldhl	sp,	#2
	sub	a, (hl)
	jr	NC, 00106$
	inc	c
;src/utils.c:24: keys = joypad();
	call	_joypad
	ld	a, e
;src/utils.c:25: if (keys == J_START || keys == J_A)
	cp	a, #0x80
	jr	Z, 00101$
	cp	a, #0x10
	jr	NZ, 00102$
00101$:
;src/utils.c:26: return (keys);
	ld	e, a
	ret
00102$:
;src/utils.c:27: wait_vbl_done();
	call	_wait_vbl_done
;src/utils.c:29: gbt_update();
	push	bc
	call	_gbt_update
	pop	bc
	jr	00104$
00106$:
;src/utils.c:31: return (0);
	ld	e, #0x00
;src/utils.c:32: }
	ret
	.area _CODE
	.area _CABS (ABS)
