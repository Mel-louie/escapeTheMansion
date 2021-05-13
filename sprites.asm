;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.4 #11941 (Mac OS X x86_64)
;--------------------------------------------------------
	.module sprites
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _init_player
	.globl _init_fire
	.globl _set_sprite_data
	.globl _init_sprites
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
;src/sprites.c:11: void	init_fire(s *fire) {
;	---------------------------------
; Function init_fire
; ---------------------------------
_init_fire::
	add	sp, #-4
;src/sprites.c:13: fire->sprite_pos_world[0] = 7;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0002
	add	hl, bc
	inc	sp
	inc	sp
	push	hl
	pop	hl
	push	hl
	ld	(hl), #0x07
;src/sprites.c:14: fire->sprite_pos_world[1] = 6;
	ld	hl, #0x0003
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x06
;src/sprites.c:15: fire->sprite_pos_screen[0] = fire->sprite_pos_world[0] * 8;
	pop	de
	push	de
	ld	a, (de)
	add	a, a
	add	a, a
	add	a, a
	ld	(bc), a
;src/sprites.c:16: fire->sprite_pos_screen[1] = fire->sprite_pos_world[1] * 10;
	ld	l, c
	ld	h, b
	inc	hl
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	e, a
	add	a, a
	add	a, a
	add	a, e
	add	a, a
	pop	hl
	push	hl
	ld	(hl), a
;src/sprites.c:17: fire->sprite_animation_frame = 0;
	ld	hl, #0x0005
	add	hl, bc
	ld	(hl), #0x00
;src/sprites.c:18: fire->frame_skip = 6;
	ld	hl, #0x0006
	add	hl, bc
	ld	(hl), #0x06
;src/sprites.c:22: set_sprite_data(0, FIRE_TILE_COUNT, FIRE);
	ld	hl, #_FIRE
	push	hl
	ld	a, #0x18
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;src/../include/../gbdk2020/include/gb/gb.h:999: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x0006)
	ld	(hl), #0x02
;src/../include/../gbdk2020/include/gb/gb.h:1045: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 0x0003)
	ld	(hl), #0x10
	ld	hl, #(_shadow_OAM + 0x0007)
	ld	(hl), #0x10
;src/sprites.c:27: move_sprite(0, fire->sprite_pos_screen[0], fire->sprite_pos_screen[1]);
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl), a
	ld	a, (bc)
	inc	hl
	ld	(hl), a
;src/../include/../gbdk2020/include/gb/gb.h:1072: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
;src/../include/../gbdk2020/include/gb/gb.h:1073: itm->y=y, itm->x=x;
	dec	hl
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src/sprites.c:28: move_sprite(1, fire->sprite_pos_screen[0] + 8, fire->sprite_pos_screen[1]);
	pop	de
	push	de
	ld	a, (de)
	ld	(hl), a
	ld	a, (bc)
	add	a, #0x08
	ld	c, a
;src/../include/../gbdk2020/include/gb/gb.h:1072: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+4
;src/../include/../gbdk2020/include/gb/gb.h:1073: itm->y=y, itm->x=x;
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, c
	ld	(de), a
;src/sprites.c:28: move_sprite(1, fire->sprite_pos_screen[0] + 8, fire->sprite_pos_screen[1]);
;src/sprites.c:29: }
	add	sp, #4
	ret
;src/sprites.c:31: void	init_player(s *pl) {
;	---------------------------------
; Function init_player
; ---------------------------------
_init_player::
	add	sp, #-4
;src/sprites.c:33: pl->sprite_pos_world[0] = 12;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0002
	add	hl, bc
	inc	sp
	inc	sp
	push	hl
	pop	hl
	push	hl
	ld	(hl), #0x0c
;src/sprites.c:34: pl->sprite_pos_world[1] = 9;
	ld	hl, #0x0003
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x09
;src/sprites.c:35: pl->sprite_pos_screen[0] = pl->sprite_pos_world[0] * 8;
	pop	de
	push	de
	ld	a, (de)
	add	a, a
	add	a, a
	add	a, a
	ld	(bc), a
;src/sprites.c:36: pl->sprite_pos_screen[1] = pl->sprite_pos_world[1] * 8;
	ld	l, c
	ld	h, b
	inc	hl
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, a
	add	a, a
	add	a, a
	pop	hl
	push	hl
	ld	(hl), a
;src/sprites.c:37: pl->sprite_animation_frame = 0;
	ld	hl, #0x0005
	add	hl, bc
	ld	(hl), #0x00
;src/sprites.c:38: pl->frame_skip = 6;
	ld	hl, #0x0006
	add	hl, bc
	ld	(hl), #0x06
;src/sprites.c:39: set_sprite_data(38, PLAYER_TILE_COUNT, PLAYER);
	ld	hl, #_PLAYER
	push	hl
	ld	de, #0x2426
	push	de
	call	_set_sprite_data
	add	sp, #4
;src/../include/../gbdk2020/include/gb/gb.h:999: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x000e)
	ld	(hl), #0x26
	ld	hl, #(_shadow_OAM + 0x0012)
	ld	(hl), #0x28
;src/sprites.c:42: move_sprite(3, pl->sprite_pos_screen[0], pl->sprite_pos_screen[1]);
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl), a
	ld	a, (bc)
	inc	hl
	ld	(hl), a
;src/../include/../gbdk2020/include/gb/gb.h:1072: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+12
;src/../include/../gbdk2020/include/gb/gb.h:1073: itm->y=y, itm->x=x;
	dec	hl
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src/sprites.c:43: move_sprite(4, pl->sprite_pos_screen[0] + 8, pl->sprite_pos_screen[1]);
	pop	de
	push	de
	ld	a, (de)
	ld	(hl), a
	ld	a, (bc)
	add	a, #0x08
	ld	c, a
;src/../include/../gbdk2020/include/gb/gb.h:1072: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+16
;src/../include/../gbdk2020/include/gb/gb.h:1073: itm->y=y, itm->x=x;
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, c
	ld	(de), a
;src/sprites.c:43: move_sprite(4, pl->sprite_pos_screen[0] + 8, pl->sprite_pos_screen[1]);
;src/sprites.c:44: }
	add	sp, #4
	ret
;src/sprites.c:46: void	init_sprites(s *fire, s *pl) {
;	---------------------------------
; Function init_sprites
; ---------------------------------
_init_sprites::
;src/sprites.c:48: fire->o = 1;
	pop	bc
	pop	de
	push	de
	push	bc
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x01
;src/sprites.c:49: init_fire(fire);
	push	de
	call	_init_fire
	add	sp, #2
;src/sprites.c:50: init_player(pl);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_init_player
	add	sp, #2
;src/sprites.c:51: }
	ret
	.area _CODE
	.area _CABS (ABS)
