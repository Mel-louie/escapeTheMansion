;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.4 #11941 (Mac OS X x86_64)
;--------------------------------------------------------
	.module screens
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _perform_delay_joypad
	.globl _perform_delay
	.globl _text_putstr_win
	.globl _text_load_font
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _set_bkg_palette
	.globl _palette_splash
	.globl _clear_title_screen
	.globl _splash_screen
	.globl _title_screen
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
;src/screens.c:21: void	clear_title_screen(void) {
;	---------------------------------
; Function clear_title_screen
; ---------------------------------
_clear_title_screen::
;src/screens.c:23: perform_delay(15);
	ld	a, #0x0f
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/screens.c:24: BGP_REG = 0xf9;
	ld	a, #0xf9
	ldh	(_BGP_REG+0),a
;src/screens.c:25: set_bkg_palette( 0, 1, &palette_splash[4] );
	ld	hl, #(_palette_splash + 0x0008)
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
;src/screens.c:26: perform_delay(20);
	ld	a, #0x14
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/screens.c:27: BGP_REG = 0xfe;
	ld	a, #0xfe
	ldh	(_BGP_REG+0),a
;src/screens.c:28: set_bkg_palette( 0, 1, &palette_splash[8] );
	ld	hl, #(_palette_splash + 0x0010)
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
;src/screens.c:29: perform_delay(25);
	ld	a, #0x19
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/screens.c:30: BGP_REG = 0xff;
	ld	a, #0xff
	ldh	(_BGP_REG+0),a
;src/screens.c:31: set_bkg_palette( 0, 1, &palette_splash[12] );
	ld	hl, #(_palette_splash + 0x0018)
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
;src/screens.c:32: perform_delay(30);
	ld	a, #0x1e
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/screens.c:33: BGP_REG = 0xe4;
	ld	a, #0xe4
	ldh	(_BGP_REG+0),a
;src/screens.c:34: set_bkg_palette( 0, 1, &palette_splash[0] );
	ld	hl, #_palette_splash
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
;src/screens.c:35: HIDE_WIN;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xdf
	ldh	(_LCDC_REG+0),a
;src/screens.c:36: HIDE_BKG;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xfe
	ldh	(_LCDC_REG+0),a
;src/screens.c:37: }
	ret
_palette_splash:
	.dw #0x5ff9
	.dw #0x3fb3
	.dw #0x4209
	.dw #0x1884
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
;src/screens.c:39: void	splash_screen(void) {
;	---------------------------------
; Function splash_screen
; ---------------------------------
_splash_screen::
;src/screens.c:41: set_bkg_data(0, TILESET_TILE_COUNTSP, TILESETSP);
	ld	hl, #_TILESETSP
	push	hl
	ld	a, #0x8c
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_data
	add	sp, #4
;src/screens.c:42: set_bkg_tiles(0, 0, TILEMAP_WIDTHSP, TILEMAP_HEIGHTSP, TILEMAPSP);
	ld	hl, #_TILEMAPSP
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
;src/screens.c:43: SHOW_BKG;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x01
	ldh	(_LCDC_REG+0),a
;src/screens.c:45: BGP_REG = 0xFF;
	ld	a, #0xff
	ldh	(_BGP_REG+0),a
;src/screens.c:46: set_bkg_palette( 0, 1, &palette_splash[12] );
	ld	hl, #(_palette_splash + 0x0018)
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
;src/screens.c:47: perform_delay(60);  // ~ 1s
	ld	a, #0x3c
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/screens.c:50: BGP_REG = 0xff;
	ld	a, #0xff
	ldh	(_BGP_REG+0),a
;src/screens.c:51: set_bkg_palette( 0, 1, &palette_splash[12] );
	ld	hl, #(_palette_splash + 0x0018)
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
;src/screens.c:52: perform_delay(15);
	ld	a, #0x0f
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/screens.c:53: BGP_REG = 0xfe;
	ld	a, #0xfe
	ldh	(_BGP_REG+0),a
;src/screens.c:54: set_bkg_palette( 0, 1, &palette_splash[8] );
	ld	hl, #(_palette_splash + 0x0010)
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
;src/screens.c:55: perform_delay(15);
	ld	a, #0x0f
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/screens.c:56: BGP_REG = 0xf9;
	ld	a, #0xf9
	ldh	(_BGP_REG+0),a
;src/screens.c:57: set_bkg_palette( 0, 1, &palette_splash[4] );
	ld	hl, #(_palette_splash + 0x0008)
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
;src/screens.c:58: perform_delay(15);
	ld	a, #0x0f
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/screens.c:59: BGP_REG = 0xe4;
	ld	a, #0xe4
	ldh	(_BGP_REG+0),a
;src/screens.c:60: set_bkg_palette( 0, 1, &palette_splash[0] );
	ld	hl, #_palette_splash
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
;src/screens.c:61: perform_delay(15);
	ld	a, #0x0f
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/screens.c:63: perform_delay(90);  // ~ 1.5s
	ld	a, #0x5a
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/screens.c:66: BGP_REG = 0xe4; // normal palette
	ld	a, #0xe4
	ldh	(_BGP_REG+0),a
;src/screens.c:67: set_bkg_palette( 0, 1, &palette_splash[0] );
	ld	hl, #_palette_splash
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
;src/screens.c:68: perform_delay(15);
	ld	a, #0x0f
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/screens.c:69: BGP_REG = 0xf9;
	ld	a, #0xf9
	ldh	(_BGP_REG+0),a
;src/screens.c:70: set_bkg_palette( 0, 1, &palette_splash[4] );
	ld	hl, #(_palette_splash + 0x0008)
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
;src/screens.c:71: perform_delay(15);
	ld	a, #0x0f
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/screens.c:72: BGP_REG = 0xfe;
	ld	a, #0xfe
	ldh	(_BGP_REG+0),a
;src/screens.c:73: set_bkg_palette( 0, 1, &palette_splash[8] );
	ld	hl, #(_palette_splash + 0x0010)
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
;src/screens.c:74: perform_delay(15);
	ld	a, #0x0f
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/screens.c:75: BGP_REG = 0xff;
	ld	a, #0xff
	ldh	(_BGP_REG+0),a
;src/screens.c:76: set_bkg_palette( 0, 1, &palette_splash[12] );
	ld	hl, #(_palette_splash + 0x0018)
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
;src/screens.c:77: perform_delay(15);
	ld	a, #0x0f
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/screens.c:79: perform_delay(60);
	ld	a, #0x3c
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/screens.c:80: HIDE_BKG;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xfe
	ldh	(_LCDC_REG+0),a
;src/screens.c:81: }
	ret
;src/screens.c:83: void	title_screen(void) {
;	---------------------------------
; Function title_screen
; ---------------------------------
_title_screen::
;src/screens.c:85: perform_delay(10);
	ld	a, #0x0a
	push	af
	inc	sp
	call	_perform_delay
	inc	sp
;src/screens.c:87: set_bkg_data(0, TILESET_SCREEN_TILE_COUNT, TILESET_SCREEN);
	ld	hl, #_TILESET_SCREEN
	push	hl
	ld	a, #0xcd
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_data
	add	sp, #4
;src/screens.c:88: set_bkg_tiles(0, 0, TILEMAP_SCREEN_WIDTH, TILEMAP_SCREEN_HEIGHT, TILEMAP_SCREEN);
	ld	hl, #_TILEMAP_SCREEN
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
;src/screens.c:90: BGP_REG = 0xe4; // puts back the PALETTE to its init point, very important to not have a forever with/black background
	ld	a, #0xe4
	ldh	(_BGP_REG+0),a
;src/screens.c:91: set_bkg_palette( 0, 1, &palette_splash[0] );
	ld	hl, #_palette_splash
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
;src/screens.c:92: SHOW_BKG;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x01
	ldh	(_LCDC_REG+0),a
;src/screens.c:95: text_load_font(1);
	ld	a, #0x01
	push	af
	inc	sp
	call	_text_load_font
	inc	sp
;src/../include/../gbdk2020/include/gb/gb.h:888: WX_REG=x, WY_REG=y;
	ld	a, #0x00
	ldh	(_WX_REG+0),a
	ld	a, #0x80
	ldh	(_WY_REG+0),a
;src/screens.c:97: text_putstr_win(0, 0, "     press start     \n                   ");
	ld	hl, #___str_0
	push	hl
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_text_putstr_win
	add	sp, #4
;src/screens.c:99: SHOW_WIN;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x20
	ldh	(_LCDC_REG+0),a
;src/screens.c:101: while (1) {
00106$:
;src/screens.c:102: if (perform_delay_joypad(45))
	ld	a, #0x2d
	push	af
	inc	sp
	call	_perform_delay_joypad
	inc	sp
	ld	a, e
	or	a, a
	ret	NZ
;src/screens.c:104: HIDE_WIN;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xdf
	ldh	(_LCDC_REG+0),a
;src/screens.c:105: if (perform_delay_joypad(25))
	ld	a, #0x19
	push	af
	inc	sp
	call	_perform_delay_joypad
	inc	sp
	ld	a, e
	or	a, a
	ret	NZ
;src/screens.c:107: SHOW_WIN;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x20
	ldh	(_LCDC_REG+0),a
;src/screens.c:109: }
	jr	00106$
___str_0:
	.ascii "     press start     "
	.db 0x0a
	.ascii "                   "
	.db 0x00
	.area _CODE
	.area _CABS (ABS)
