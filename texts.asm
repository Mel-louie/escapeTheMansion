;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.4 #11941 (Mac OS X x86_64)
;--------------------------------------------------------
	.module texts
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _set_win_tiles
	.globl _set_bkg_data
	.globl _text_load_font
	.globl _text_putchar_win
	.globl _text_putstr_win
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
;src/texts.c:9: void	text_load_font(UINT8 code) {
;	---------------------------------
; Function text_load_font
; ---------------------------------
_text_load_font::
;src/texts.c:10: if (code == 0) {
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	NZ, 00107$
;src/texts.c:11: set_bkg_data(TEXT_OFFSET, FONT_COUNT, FONT_TILESET);
	ld	hl, #_FONT_TILESET
	push	hl
	ld	de, #0x30d0
	push	de
	call	_set_bkg_data
	add	sp, #4
	ret
00107$:
;src/texts.c:13: else if (code == 1) {
	ldhl	sp,	#2
	ld	a, (hl)
	dec	a
	jr	NZ, 00104$
;src/texts.c:14: set_bkg_data(TEXT_OFFSET, FONT_COUNT, FONT_TILESET_BLCK);
	ld	hl, #_FONT_TILESET_BLCK
	push	hl
	ld	de, #0x30d0
	push	de
	call	_set_bkg_data
	add	sp, #4
	ret
00104$:
;src/texts.c:16: else if (code == 2) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x02
	ret	NZ
;src/texts.c:17: set_bkg_data(TEXT_OFFSET, FONT_COUNT, FONT_BLCK);
	ld	hl, #_FONT_BLCK
	push	hl
	ld	de, #0x30d0
	push	de
	call	_set_bkg_data
	add	sp, #4
;src/texts.c:19: }
	ret
;src/texts.c:21: void	text_putchar_win(UINT8 x, UINT8 y, unsigned char c) {
;	---------------------------------
; Function text_putchar_win
; ---------------------------------
_text_putchar_win::
	add	sp, #-2
;src/texts.c:22: UINT16	tile = TEXT_CHAR_QS_MARK;
	ldhl	sp,	#0
	ld	(hl), #0xfb
	xor	a, a
	inc	hl
	ld	(hl), a
;src/texts.c:24: if (c >= 'A' && c <= 'Z') {
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x41
	jr	C, 00121$
	ld	a, #0x5a
	sub	a, (hl)
	jr	C, 00121$
;src/texts.c:25: tile = TEXT_CHAR_A + c - 'A';
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x008f
	add	hl, bc
	inc	sp
	inc	sp
	push	hl
	jp	00122$
00121$:
;src/texts.c:27: else if (c >= 'a' && c <= 'z') {
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x61
	jr	C, 00117$
	ld	a, #0x7a
	sub	a, (hl)
	jr	C, 00117$
;src/texts.c:28: tile = TEXT_CHAR_A + c - 'a';
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x006f
	add	hl, bc
	inc	sp
	inc	sp
	push	hl
	jp	00122$
00117$:
;src/texts.c:30: else if (c >= '0' && c <= '9') {
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x30
	jr	C, 00113$
	ld	a, #0x39
	sub	a, (hl)
	jr	C, 00113$
;src/texts.c:31: tile = TEXT_CHAR_0 + c - '0';
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x00ba
	add	hl, bc
	inc	sp
	inc	sp
	push	hl
	jp	00122$
00113$:
;src/texts.c:34: switch (c) {
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x20
	jr	Z, 00101$
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x21
	jr	Z, 00108$
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x27
	jr	Z, 00102$
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x28
	jr	Z, 00109$
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x29
	jr	Z, 00110$
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x2c
	jr	Z, 00105$
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x2d
	jr	Z, 00103$
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x2e
	jr	Z, 00104$
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x3a
	jr	Z, 00106$
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x3b
	jr	Z, 00107$
	jr	00122$
;src/texts.c:35: case ' ':
00101$:
;src/texts.c:36: tile = TEXT_CHAR_SPACE;
	ldhl	sp,	#0
	ld	(hl), #0xff
	xor	a, a
	inc	hl
	ld	(hl), a
;src/texts.c:37: break ;
	jr	00122$
;src/texts.c:38: case '\'':
00102$:
;src/texts.c:39: tile = TEXT_CHAR_QUOTE;
	ldhl	sp,	#0
	ld	(hl), #0xf4
	xor	a, a
	inc	hl
	ld	(hl), a
;src/texts.c:40: break ;
	jr	00122$
;src/texts.c:41: case '-':
00103$:
;src/texts.c:42: tile = TEXT_CHAR_DASH;
	ldhl	sp,	#0
	ld	(hl), #0xf5
	xor	a, a
	inc	hl
	ld	(hl), a
;src/texts.c:43: break ;
	jr	00122$
;src/texts.c:44: case '.':
00104$:
;src/texts.c:45: tile = TEXT_CHAR_DOT;
	ldhl	sp,	#0
	ld	(hl), #0xf6
	xor	a, a
	inc	hl
	ld	(hl), a
;src/texts.c:46: break ;
	jr	00122$
;src/texts.c:47: case ',':
00105$:
;src/texts.c:48: tile = TEXT_CHAR_COMMA;
	ldhl	sp,	#0
	ld	(hl), #0xf7
	xor	a, a
	inc	hl
	ld	(hl), a
;src/texts.c:49: break ;
	jr	00122$
;src/texts.c:50: case ':':
00106$:
;src/texts.c:51: tile = TEXT_CHAR_DL_DOTS;
	ldhl	sp,	#0
	ld	(hl), #0xf8
	xor	a, a
	inc	hl
	ld	(hl), a
;src/texts.c:52: break ;
	jr	00122$
;src/texts.c:53: case ';':
00107$:
;src/texts.c:54: tile = TEXT_CHAR_SEMICOLON;
	ldhl	sp,	#0
	ld	(hl), #0xf9
	xor	a, a
	inc	hl
	ld	(hl), a
;src/texts.c:55: break ;
	jr	00122$
;src/texts.c:56: case '!':
00108$:
;src/texts.c:57: tile = TEXT_CHAR_EX_MARK;
	ldhl	sp,	#0
	ld	(hl), #0xfa
	xor	a, a
	inc	hl
	ld	(hl), a
;src/texts.c:58: break ;
	jr	00122$
;src/texts.c:59: case '(':
00109$:
;src/texts.c:60: tile = TEXT_CHAR_BRK_L;
	ldhl	sp,	#0
	ld	(hl), #0xfc
	xor	a, a
	inc	hl
	ld	(hl), a
;src/texts.c:61: break ;
	jr	00122$
;src/texts.c:62: case ')':
00110$:
;src/texts.c:63: tile = TEXT_CHAR_BRK_R;
	ldhl	sp,	#0
	ld	(hl), #0xfd
	xor	a, a
	inc	hl
	ld	(hl), a
;src/texts.c:65: }
00122$:
;src/texts.c:67: set_win_tiles(x, y, 1, 1, &tile);
	ldhl	sp,	#0
	push	hl
	ld	de, #0x0101
	push	de
	ldhl	sp,	#9
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_win_tiles
	add	sp, #6
;src/texts.c:68: }
	add	sp, #2
	ret
;src/texts.c:70: void	text_putstr_win(UINT8 x, UINT8 y, unsigned char *str) {
;	---------------------------------
; Function text_putstr_win
; ---------------------------------
_text_putstr_win::
	add	sp, #-3
;src/texts.c:72: UINT8 tmpX = x;
	ldhl	sp,	#5
	ld	c, (hl)
	ldhl	sp,	#0
	ld	(hl), c
;src/texts.c:73: UINT8 tmpY = y;
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;src/texts.c:75: while (str[i]) {
	xor	a, a
	inc	hl
	ld	(hl), a
00104$:
;c
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	or	a, a
	jr	Z, 00107$
;src/texts.c:76: if (str[i] == '\n') {
	cp	a, #0x0a
	jr	NZ, 00102$
;src/texts.c:77: tmpY++;
	ldhl	sp,	#1
	inc	(hl)
;src/texts.c:78: tmpX = x;
	dec	hl
	ld	(hl), c
	jr	00103$
00102$:
;src/texts.c:81: text_putchar_win(tmpX, tmpY, str[i]);
	push	bc
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_text_putchar_win
	add	sp, #3
	pop	bc
;src/texts.c:82: tmpX++;
	ldhl	sp,	#0
	inc	(hl)
00103$:
;src/texts.c:84: i++;
	ldhl	sp,	#2
	inc	(hl)
	jr	00104$
00107$:
;src/texts.c:86: }
	add	sp, #3
	ret
	.area _CODE
	.area _CABS (ABS)
