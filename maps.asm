;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.4 #11941 (Mac OS X x86_64)
;--------------------------------------------------------
	.module maps
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _init_map
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
;src/maps.c:9: void		init_map(void) {
;	---------------------------------
; Function init_map
; ---------------------------------
_init_map::
;src/maps.c:11: set_bkg_data(0, TILESET_KITCHEN_TILE_COUNT, TILESET_KITCHEN);
	ld	hl, #_TILESET_KITCHEN
	push	hl
	ld	a, #0x4b
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_data
	add	sp, #4
;src/maps.c:12: set_bkg_tiles(0, 0, TILEMAP_KITCHEN_WIDTH, TILEMAP_KITCHEN_HEIGHT, TILEMAP_KITCHEN);
	ld	hl, #_TILEMAP_KITCHEN
	push	hl
	ld	de, #0x1214
	push	de
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src/maps.c:13: SHOW_BKG;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x01
	ldh	(_LCDC_REG+0),a
;src/maps.c:14: }
	ret
	.area _CODE
	.area _CABS (ABS)
