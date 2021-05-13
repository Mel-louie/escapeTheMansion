;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.4 #11941 (Mac OS X x86_64)
;--------------------------------------------------------
	.module game
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _animate_fire
	.globl _init_sprites
	.globl _init_map
	.globl _perform_delay
	.globl _game
	.globl _init_game
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
;src/game.c:9: void	animate_fire(void) {
;	---------------------------------
; Function animate_fire
; ---------------------------------
_animate_fire::
;src/game.c:11: perform_delay(15);
	ld	a, #0x0f
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/../include/../gbdk2020/include/gb/gb.h:999: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), #0x04
	ld	hl, #(_shadow_OAM + 0x0006)
	ld	(hl), #0x06
;src/game.c:14: perform_delay(15);
	ld	a, #0x0f
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/../include/../gbdk2020/include/gb/gb.h:999: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), #0x08
	ld	hl, #(_shadow_OAM + 0x0006)
	ld	(hl), #0x0a
;src/game.c:17: perform_delay(15);
	ld	a, #0x0f
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/../include/../gbdk2020/include/gb/gb.h:999: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), #0x0c
	ld	hl, #(_shadow_OAM + 0x0006)
	ld	(hl), #0x0e
;src/game.c:20: perform_delay(15);
	ld	a, #0x0f
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/../include/../gbdk2020/include/gb/gb.h:999: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x0006)
	ld	(hl), #0x02
;src/game.c:22: set_sprite_tile(1, 2);
;src/game.c:23: }
	ret
;src/game.c:25: void	game(s *fire, s*pl) {
;	---------------------------------
; Function game
; ---------------------------------
_game::
;src/game.c:27: if (!fire->o)
	pop	bc
	pop	de
	push	de
	push	bc
	ld	hl, #0x0007
	add	hl, de
	ld	a, (hl)
	or	a, a
	jp	NZ,_animate_fire
;src/game.c:28: init_sprites(fire, pl);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	de
	call	_init_sprites
	add	sp, #4
;src/game.c:29: animate_fire();
;src/game.c:30: }
	jp  _animate_fire
;src/game.c:32: void	init_game(void) {
;	---------------------------------
; Function init_game
; ---------------------------------
_init_game::
;src/game.c:34: HIDE_BKG;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xfe
	ldh	(_LCDC_REG+0),a
;src/game.c:35: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;src/game.c:36: SPRITES_8x16;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x04
	ldh	(_LCDC_REG+0),a
;src/game.c:37: init_map();
;src/game.c:38: }
	jp  _init_map
	.area _CODE
	.area _CABS (ABS)
