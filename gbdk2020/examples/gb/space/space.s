	;; Little demo illustrating how to use the graphical possibilities
	;;  of the GB (background, window and animated sprite)
	;; I have used fixed-point values for both the position and
	;;  speed of objects to get smooth movements
	;;
	;; OBJ data		: 0x8000 -> 0x8FFF (unsigned)
	;; Window data		: 0x8800 -> 0x97FF (signed)
	;; Background data	: 0x8800 -> 0x97FF (signed)
	;;
	;; Tiled 0xFC -> 0xFF are standard tiles (all black -> all white)
	;;
	;; Keys:
	;; Arrow keys		: Change the speed (and direction) of the sprite
	;; Arrow keys + A	: Change the speed (and direction) of the window
	;; Arrow keys + B	: Change the speed (and direction) of the background
	;; START		: Open/close the door
	;; SELECT		: Basic fading effect
	;;
	;; Note that the window is kept in the lower right part of the screen
	;; since it can't be made transparent

	.include	"../../../lib/small/asxxxx/global.s"

	.globl	.init_vram
	.globl	.copy_vram
	.globl	.init_wtt
	.globl	.init_btt
	.globl	.set_xy_wtt
	.globl	.mv_sprite
	.globl	.set_sprite_prop
	.globl	.set_sprite_tile
	.globl	.jpad

	.NBDFRAMES	= .endfilm-.film	; Nb frames for the door
	.NBSFRAMES	= 0x07			; Nb frames for the sprite
	.WINSZX		= 0x80			; Size of the picture in the window
	.WINSZY		= 0x50
	.MINWINX	= .MAXWNDPOSX-.WINSZX+1 ; Bounds of the window origin
	.MINWINY	= .MAXWNDPOSY-.WINSZY+1
	.MAXWINX	= .MAXWNDPOSX
	.MAXWINY	= .MAXWNDPOSY
	.FADESTEP	= 0x10			; Nb steps for the fading effect
	.STARTFADE	= 0x06*.FADESTEP	; Initial value for the fading effect

	.CLOSED		= 0x00
	.OPENING	= 0x01
	.OPENED		= 0x02
	.CLOSING	= 0x03

	.module	Space

	.area	_BSS

.time:				; Global "time" value (counter)
	.ds	0x01

.doorstate:			; State of the door (OPENED, CLOSED...)
	.ds	0x01
.doorpos:			; Current position in the door animation
	.ds	0x01

.color:				; Current color for fading effect
	.ds	0x01

.sframe:			; Current frame of the sprite
	.ds	0x01

.bposx:				; Background position (fixed point)
	.ds	0x02
.bposy:
	.ds	0x02
.bspx:				; Background speed (fixed point)
	.ds	0x02
.bspy:
	.ds	0x02

.wposx:				; Window position (fixed point)
	.ds	0x02
.wposy:
	.ds	0x02
.wspx:				; Window speed (fixed point)
	.ds	0x02
.wspy:
	.ds	0x02

.sposx:				; Sprite position (fixed point)
	.ds	0x02
.sposy:
	.ds	0x02
.sspx:				; Sprite speed (fixed point)
	.ds	0x02
.sspy:
	.ds	0x02

	.area	_CODE

_main::
	DI			; Disable interrupts
	;; Turn the screen off
	CALL	.display_off

	XOR	A
	LD	(.time),A
	LD	(.color),A

	LD	A,#0b11100100
	LDH	(.BGP),A
	LDH	(.OBP0),A

	; Initialize tiles
	LD	HL,#0x8000
	LD	DE,#0x1000
	LD	B,#0x00
	CALL	.init_vram	; Init the tile set at 0x8000 with 0x00
	LD	B,#0xFF
	CALL	.init_btt	; Init the tiles tables with 0xFF
	CALL	.init_wtt

	LD	BC,#.tp0	; Move tiles (standard tiles)
	LD	HL,#0x9000-(.endtp0-.tp0)
	LD	DE,#.endtp0-.tp0
	CALL	.copy_vram

	LD	BC,#.tp1	; Move tiles (earth)
	LD	HL,#0x8000
	LD	DE,#.endtp1-.tp1
	CALL	.copy_vram

	LD	BC,#.tp2	; Move tiles (door)
	LD	HL,#0x8800
	LD	DE,#.endtp2-.tp2
	CALL	.copy_vram

	LD	BC,#.tp3	; Move tiles (background)
	LD	HL,#0x9000
	LD	DE,#.endtp3-.tp3
	CALL	.copy_vram

	;; Draw the background
	LD	BC,#.bkg_tiles
	LD	HL,#0x9800
	LD	DE,#0x0400	; One whole GB Screen
	CALL	.copy_vram

	;; Draw the frame in the window
	LD	BC,#.frame_tiles
	LD	DE,#0x0000/8	; Place image at (0x00,0x00)
	LD	HL,#0x8050/8	; Image size is 0x80 x 0x50
	CALL	.set_xy_wtt

	;; Draw the door in the window
	LD	BC,#.door1_tiles
	LD	DE,#0x1010/8	; Place image at (0x10,0x10)
	LD	HL,#0x6030/8	; Image size is 0x60 x 0x30
	CALL	.set_xy_wtt
	LD	A,#.CLOSED
	LD	(.doorstate),A

	; Initialize background
	XOR	A
	LD	(.bposx),A
	LDH	(.SCX),A
	LD	(.bposx+1),A
	LD	(.bposy),A
	LDH	(.SCY),A
	LD	(.bposy+1),A
	LD	A,#-0x01
	LD	(.bspx),A
	XOR	A
	LD	(.bspx+1),A
	XOR	A
	LD	(.bspy),A
	LD	A,#0x80
	LD	(.bspy+1),A

	; Initialize window
	LD	A,#.MAXWNDPOSX
	LD	(.wposx),A
	LDH	(.WX),A
	XOR	A
	LD	(.wposx+1),A
	LD	A,#.MAXWNDPOSY
	LD	(.wposy),A
	LDH	(.WY),A
	XOR	A
	LD	(.wposy+1),A
	LD	A,#-0x01
	LD	(.wspx),A
	LD	A,#0x80
	LD	(.wspx+1),A
	LD	A,#-0x01
	LD	(.wspy),A
	LD	A,#0xC0
	LD	(.wspy+1),A

	; Initialize sprite
	XOR	A
	LD	(.sframe),A
	LD	C,#0x00		; Sprite 0x00
	LD	D,#0x00		; Default sprite properties
	CALL	.set_sprite_prop
	LD	C,#0x01		; Sprite 0x01
	LD	D,#0x00		; Default sprite properties
	CALL	.set_sprite_prop

	LD	A,#0x10
	LD	(.sposx),A
	XOR	A
	LD	(.sposx+1),A
	LD	A,#0x10
	LD	(.sposy),A
	XOR	A
	LD	(.sposy+1),A
	XOR	A
	LD	(.sspx),A
	LD	A,#0x40
	LD	(.sspx+1),A
	XOR	A
	LD	(.sspy),A
	LD	A,#0x40
	LD	(.sspy+1),A
	CALL	.tile_sprite	; Set sprite tiles
	CALL	.place_sprite	; Place sprites

	LD	A,#0b11100111	; LCD		= On
				; WindowBank	= 0x9C00
				; Window	= On
				; BG Chr	= 0x8800
				; BG Bank	= 0x9800
				; OBJ		= 8x16
				; OBJ		= On
				; BG		= On
	LDH	(.LCDC),A
	EI			; Enable interrupts
1$:
	LD	A,(.time)
	INC	A
	LD	(.time),A

	LD	B,#0x04		; Skip four VBLs (slow down animation)
2$:
	CALL	.wait_vbl_done
	DEC	B
	JR	NZ,2$

	CALL	.fade
	CALL	.door
	CALL	.scroll
	CALL	.animate_sprite

	CALL	.jpad
	LD	D,A

	AND	#.B		; Is B pressed ?
	JP	NZ,10$

	LD	A,D
	AND	#.A		; Is A pressed ?
	JP	NZ,20$

	LD	A,D
	AND	#.SELECT	; Is SELECT pressed ?
	JR	Z,3$
	LD	A,#.STARTFADE
	LD	(.color),A
3$:
	LD	A,D
	AND	#.START		; Is START pressed ?
	JR	Z,5$
	LD	A,(.doorstate)
	CP	#.CLOSED
	JR	NZ,4$
	LD	A,#.OPENING
	LD	(.doorstate),A
	XOR	A
	LD	(.doorpos),A
	JR	5$
4$:
	CP	#.OPENED
	JR	NZ,5$
	LD	A,#.CLOSING
	LD	(.doorstate),A
	LD	A,#.NBDFRAMES
	LD	(.doorpos),A
5$:
	LD	A,D
	AND	#.UP		; Is UP pressed ?
	JR	Z,6$
	LD	BC,#0x0010
	LD	A,(.sspy)	; Load speed into HL
	LD	H,A
	LD	A,(.sspy+1)
	LD	L,A
	LD	A,L		; Substract BC from HL
	SUB	C
	LD	(.sspy+1),A
	LD	A,H
	SBC	B
	LD	(.sspy),A	; Store new speed
	JR	7$
6$:
	LD	A,D
	AND	#.DOWN		; Is DOWN pressed ?
	JR	Z,7$
	LD	BC,#0x0010
	LD	A,(.sspy)	; Load speed into HL
	LD	H,A
	LD	A,(.sspy+1)
	LD	L,A
	ADD	HL,BC		; Add them
	LD	A,H		; Store new speed
	LD	(.sspy),A
	LD	A,L
	LD	(.sspy+1),A
7$:
	LD	A,D
	AND	#.LEFT		; Is LEFT pressed ?
	JR	Z,8$
	LD	BC,#0x0010
	LD	A,(.sspx)	; Load speed into HL
	LD	H,A
	LD	A,(.sspx+1)
	LD	L,A
	LD	A,L		; Substract BC from HL
	SUB	C
	LD	(.sspx+1),A
	LD	A,H
	SBC	B
	LD	(.sspx),A	; Store new speed
	JP	1$
8$:
	LD	A,D
	AND	#.RIGHT		; Is RIGHT pressed ?
	JP	Z,1$
	LD	BC,#0x0010
	LD	A,(.sspx)	; Load speed into HL
	LD	H,A
	LD	A,(.sspx+1)
	LD	L,A
	ADD	HL,BC		; Add them
	LD	A,H		; Store new speed
	LD	(.sspx),A
	LD	A,L
	LD	(.sspx+1),A
	JP	1$

10$:
	LD	A,D
	AND	#.UP		; Is UP pressed ?
	JP	Z,11$
	LD	BC,#0x0010
	LD	A,(.bspy)	; Load speed into HL
	LD	H,A
	LD	A,(.bspy+1)
	LD	L,A
	LD	A,L		; Substract BC from HL
	SUB	C
	LD	(.bspy+1),A
	LD	A,H
	SBC	B
	LD	(.bspy),A	; Store new speed
	JR	12$
11$:
	LD	A,D
	AND	#.DOWN		; Is DOWN pressed ?
	JP	Z,12$
	LD	BC,#0x0010
	LD	A,(.bspy)	; Load speed into HL
	LD	H,A
	LD	A,(.bspy+1)
	LD	L,A
	ADD	HL,BC		; Add them
	LD	A,H		; Store new speed
	LD	(.bspy),A
	LD	A,L
	LD	(.bspy+1),A
12$:
	LD	A,D
	AND	#.LEFT		; Is LEFT pressed ?
	JP	Z,13$
	LD	BC,#0x0010
	LD	A,(.bspx)	; Load speed into HL
	LD	H,A
	LD	A,(.bspx+1)
	LD	L,A
	LD	A,L		; Substract BC from HL
	SUB	C
	LD	(.bspx+1),A
	LD	A,H
	SBC	B
	LD	(.bspx),A	; Store new speed
	JP	1$
13$:
	LD	A,D
	AND	#.RIGHT		; Is RIGHT pressed ?
	JP	Z,1$
	LD	BC,#0x0010
	LD	A,(.bspx)	; Load speed into HL
	LD	H,A
	LD	A,(.bspx+1)
	LD	L,A
	ADD	HL,BC		; Add them
	LD	A,H		; Store new speed
	LD	(.bspx),A
	LD	A,L
	LD	(.bspx+1),A
	JP	1$

20$:
	LD	A,D
	AND	#.UP		; Is UP pressed ?
	JP	Z,21$
	LD	BC,#0x0010
	LD	A,(.wspy)	; Load speed into HL
	LD	H,A
	LD	A,(.wspy+1)
	LD	L,A
	LD	A,L		; Substract BC from HL
	SUB	C
	LD	(.wspy+1),A
	LD	A,H
	SBC	B
	LD	(.wspy),A	; Store new speed
	JR	22$
21$:
	LD	A,D
	AND	#.DOWN		; Is DOWN pressed ?
	JP	Z,22$
	LD	BC,#0x0010
	LD	A,(.wspy)	; Load speed into HL
	LD	H,A
	LD	A,(.wspy+1)
	LD	L,A
	ADD	HL,BC		; Add them
	LD	A,H		; Store new speed
	LD	(.wspy),A
	LD	A,L
	LD	(.wspy+1),A
22$:
	LD	A,D
	AND	#.LEFT		; Is LEFT pressed ?
	JP	Z,23$
	LD	BC,#0x0010
	LD	A,(.wspx)	; Load speed into HL
	LD	H,A
	LD	A,(.wspx+1)
	LD	L,A
	LD	A,L		; Substract BC from HL
	SUB	C
	LD	(.wspx+1),A
	LD	A,H
	SBC	B
	LD	(.wspx),A	; Store new speed
	JP	1$
23$:
	LD	A,D
	AND	#.RIGHT		; Is RIGHT pressed ?
	JP	Z,1$
	LD	BC,#0x0010
	LD	A,(.wspx)	; Load speed into HL
	LD	H,A
	LD	A,(.wspx+1)
	LD	L,A
	ADD	HL,BC		; Add them
	LD	A,H		; Store new speed
	LD	(.wspx),A
	LD	A,L
	LD	(.wspx+1),A
	JP	1$

	RET

	;; Fade the screen (off and on)
.fade:

	LD	A,(.color)	; Load color into A
	CP	#0x00
	RET	Z
	CP	#.STARTFADE
	JR	NZ,1$
	LD	A,#0b11111001
	JR	6$
1$:
	CP	#.STARTFADE-.FADESTEP
	JR	NZ,2$
	LD	A,#0b11111110
	JR	6$
2$:
	CP	#.STARTFADE-0x02*.FADESTEP
	JR	NZ,3$
	LD	A,#0b11111111
	JR	6$
3$:
	CP	#.STARTFADE-0x03*.FADESTEP
	JR	NZ,4$
	LD	A,#0b11111110
	JR	6$
4$:
	CP	#.STARTFADE-0x04*.FADESTEP
	JR	NZ,5$
	LD	A,#0b11111001
	JR	6$
5$:
	CP	#.STARTFADE-0x05*.FADESTEP
	JR	NZ,7$
	LD	A,#0b11100100
6$:
	LDH	(.BGP),A
7$:
	LD	A,(.color)
	DEC	A
	LD	(.color),A
	RET

	;; Scroll the background, the window and the sprite
.scroll:

	;; Update background
	LD	A,(.bposx)	; Load background position into HL
	LD	H,A
	LD	A,(.bposx+1)
	LD	L,A
	LD	A,(.bspx)	; Load background speed into BC
	LD	B,A
	LD	A,(.bspx+1)
	LD	C,A
	ADD	HL,BC		; Add them
	LD	A,L		; Store new background position
	LD	(.bposx+1),A
	LD	A,H
	LD	(.bposx),A
	LDH	(.SCX),A	; Update position

	LD	A,(.bposy)	; Load background position into HL
	LD	H,A
	LD	A,(.bposy+1)
	LD	L,A
	LD	A,(.bspy)	; Load background speed into BC
	LD	B,A
	LD	A,(.bspy+1)
	LD	C,A
	ADD	HL,BC		; Add them
	LD	A,L		; Store new background position
	LD	(.bposy+1),A
	LD	A,H
	LD	(.bposy),A
	LDH	(.SCY),A	; Update position

	;; Update window
	LD	A,(.wspx)	; Load window speed into BC
	LD	B,A
	LD	A,(.wspx+1)
	LD	C,A
	LD	A,(.wposx)	; Load window position into HL
	LD	H,A
	LD	A,(.wposx+1)
	LD	L,A
	ADD	HL,BC		; Add them
	LD	A,L		; Store new window position
	LD	(.wposx+1),A
	LD	A,H
	LD	(.wposx),A

	;; X position
	LD	A,(.wposx)	; Check window position
	LD	H,#0x00		; We must use 16 bit registers since the
	LD	L,A		;  window is not less than 0x80 pixels
	LD	BC,#.MAXWINX
	LD	A,L		; Substract BC from HL
	SUB	C
	LD	A,H
	SBC	B
	AND	#0x80
	JR	NZ,1$		; Maximum value ?
	LD	A,#.MAXWINX
	LD	(.wposx),A	; Correct window position
	LD	A,(.wspx+1)	; Load window speed into BC
	LD	C,A
	LD	A,(.wspx)
	LD	B,A
	AND	#0x80		; Speed is already negative ?
	JR	NZ,3$
	JR	2$
1$:
	LD	A,(.wposx)	; Check window position
	LD	H,#0x00		; We must use 16 bit registers since the
	LD	L,A		;  window is not less than 0x80 pixels
	LD	BC,#.MINWINX+1
	LD	A,L		; Substract BC from HL
	SUB	C
	LD	A,H
	SBC	B
	AND	#0x80
	JR	Z,3$		; Minimum value ?
	LD	A,#.MINWINX
	LD	(.wposx),A	; Correct window position
	LD	A,(.wspx+1)	; Load window speed into BC
	LD	C,A
	LD	A,(.wspx)
	LD	B,A
	AND	#0x80		; Speed is already positive ?
	JR	Z,3$
2$:
	LD	HL,#0x00	; Invert speed
	LD	A,L		; Substract BC from HL
	SUB	C
	LD	(.wspx+1),A
	LD	A,H
	SBC	B
	LD	(.wspx),A	; Store new speed
3$:
	LD	A,(.wposx)
	LDH	(.WX),A		; Update position

	LD	A,(.wspy)	; Load window speed into BC
	LD	B,A
	LD	A,(.wspy+1)
	LD	C,A
	LD	A,(.wposy)	; Load window position into HL
	LD	H,A
	LD	A,(.wposy+1)
	LD	L,A
	ADD	HL,BC		; Add them
	LD	A,L		; Store new window position
	LD	(.wposy+1),A
	LD	A,H
	LD	(.wposy),A

	;; Y position
	LD	A,(.wposy)	; Check window position
	LD	H,#0x00		; We must use 16 bit registers since the
	LD	L,A		;  window is not less than 0x80 pixels
	LD	BC,#.MAXWINY
	LD	A,L		; Substract BC from HL
	SUB	C
	LD	A,H
	SBC	B
	AND	#0x80
	JR	NZ,4$		; Maximum value ?
	LD	A,#.MAXWINY
	LD	(.wposy),A	; Correct window position
	LD	A,(.wspy+1)	; Load window speed into BC
	LD	C,A
	LD	A,(.wspy)
	LD	B,A
	AND	#0x80		; Speed is already negative ?
	JR	NZ,6$
	JR	5$
4$:
	LD	A,(.wposy)	; Check window position
	LD	H,#0x00		; We must use 16 bit registers since the
	LD	L,A		;  window is not less than 0x80 pixels
	LD	BC,#.MINWINY+1
	LD	A,L		; Substract BC from HL
	SUB	C
	LD	A,H
	SBC	B
	AND	#0x80
	JR	Z,6$		; Minimum value ?
	LD	A,#.MINWINY
	LD	(.wposy),A	; Correct window position
	LD	A,(.wspy+1)	; Load window speed into BC
	LD	C,A
	LD	A,(.wspy)
	LD	B,A
	AND	#0x80		; Speed is already positive ?
	JR	Z,6$
5$:
	LD	HL,#0x00	; Invert speed
	LD	A,L		; Substract BC from HL
	SUB	C
	LD	(.wspy+1),A
	LD	A,H
	SBC	B
	LD	(.wspy),A	; Store new speed
6$:
	LD	A,(.wposy)
	LDH	(.WY),A		; Update position

	;; Update sprite
	LD	A,(.sposx)	; Load sprite position into HL
	LD	H,A
	LD	A,(.sposx+1)
	LD	L,A
	LD	A,(.sspx)	; Load sprite speed into BC
	LD	B,A
	LD	A,(.sspx+1)
	LD	C,A
	ADD	HL,BC		; Add them
	LD	A,L		; Store new sprite position
	LD	(.sposx+1),A
	LD	A,H
	LD	(.sposx),A

	LD	A,(.sposy)	; Load sprite position into HL
	LD	H,A
	LD	A,(.sposy+1)
	LD	L,A
	LD	A,(.sspy)	; Load sprite speed into BC
	LD	B,A
	LD	A,(.sspy+1)
	LD	C,A
	ADD	HL,BC		; Add them
	LD	A,L		; Store new sprite position
	LD	(.sposy+1),A
	LD	A,H
	LD	(.sposy),A
	CALL	.place_sprite	; Update position

	RET

	;; Open and close the door
.door:
	LD	A,(.doorstate)
	CP	#.OPENING
	JP	Z,.open_door
	CP	#.CLOSING
	JP	Z,.close_door
	RET

.open_door:
	LD	A,(.doorpos)
	LD	HL,#.film+0x02
	LD	B,#0x00
	LD	C,A
	ADD	HL,BC
	LD	C,(HL)
	INC	HL
	LD	B,(HL)
	LD	DE,#0x1010/8	; Place image at (0x10,0x10)
	LD	HL,#0x6030/8	; Image size is 0x60 x 0x30
	CALL	.set_xy_wtt

	LD	A,(.doorpos)
	ADD	A,#0x02
	LD	(.doorpos),A
	CP	#.NBDFRAMES
	RET	NZ
	LD	A,#.OPENED
	LD	(.doorstate),A
	RET

.close_door:
	LD	A,(.doorpos)
	LD	HL,#.film-0x02
	LD	B,#0x00
	LD	C,A
	ADD	HL,BC
	LD	C,(HL)
	INC	HL
	LD	B,(HL)
	LD	DE,#0x1010/8	; Place image at (0x10,0x10)
	LD	HL,#0x6030/8	; Image size is 0x60 x 0x30
	CALL	.set_xy_wtt

	LD	A,(.doorpos)
	SUB	A,#0x02
	LD	(.doorpos),A
	RET	NZ
	LD	A,#.CLOSED
	LD	(.doorstate),A
	RET

	;; Animate sprite
.animate_sprite:
	LD	A,(.time)
	AND	#0x07
	RET	NZ

	LD	A,(.sframe)
	INC	A
	CP	#.NBSFRAMES
	JR	NZ,1$
	XOR	A
1$:
	LD	(.sframe),A

	CALL	.tile_sprite
	RET

	;; Set sprite tiles
.tile_sprite:
	LD	A,(.sframe)
	LD	HL,#.earth_tiles
	RLCA
	LD	B,#0x00
	LD	C,A
	ADD	HL,BC
	LD	C,#0x00		; Sprite 0x00
	LD	A,(HL+)
	LD	D,A
	PUSH	HL
	CALL	.set_sprite_tile
	POP	HL

	LD	C,#0x01		; Sprite 0x01
	LD	A,(HL+)
	LD	D,A
	CALL	.set_sprite_tile

	RET

	;; Place sprite
.place_sprite:
	LD	C,#0x00		; Sprite 0x00
	LD	A,(.sposx)
	LD	D,A
	LD	A,(.sposy)
	LD	E,A
	PUSH	DE		; Store position
	CALL	.mv_sprite

	LD	C,#0x01		; Sprite 0x01
	POP	DE		; Restore position
	LD	A,#0x08
	ADD	A,D
	LD	D,A
	CALL	.mv_sprite

	RET

	.area	_LIT

.tp0:

.std_data:

	; Basic tiles (0xFC to 0xFF)

	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00
	.byte	0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF
	.byte	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00

.endtp0:

.tp1:

.earth_data:

	; Tile 0x00
	.byte	0x07,0x07,0x18,0x1F,0x32,0x2D,0x71,0x4E,0x70,0x4F,0xF8,0x87,0xF8,0x87,0xF8,0x87
	.byte	0xFC,0x83,0xFE,0x81,0x7F,0x40,0x7F,0x40,0x3F,0x20,0x1F,0x18,0x07,0x07,0x00,0x00
	.byte	0xC0,0xC0,0xF0,0x30,0x78,0x88,0x3C,0xC4,0x5C,0xA4,0x9E,0x62,0x3E,0xC2,0x3E,0xC2
	.byte	0x5E,0xA2,0x7E,0x82,0x0C,0xF4,0x0C,0xF4,0x98,0x68,0xB0,0x70,0xC0,0xC0,0x00,0x00
	.byte	0x07,0x07,0x1F,0x18,0x2F,0x30,0x4F,0x70,0x6F,0x50,0x9F,0xE0,0x9F,0xE0,0xBF,0xC0
	.byte	0xFF,0x80,0xB7,0xC8,0x63,0x5C,0x43,0x7C,0x3F,0x20,0x1F,0x18,0x07,0x07,0x00,0x00
	.byte	0xC0,0xC0,0xB0,0x70,0x18,0xE8,0x0C,0xF4,0x0C,0xF4,0x82,0x7E,0x82,0x7E,0x86,0x7A
	.byte	0xC6,0x3A,0xE6,0x1A,0xF4,0x0C,0xFC,0x04,0xF8,0x08,0xF0,0x30,0xC0,0xC0,0x00,0x00

	; Tile 0x08
	.byte	0x07,0x07,0x1E,0x19,0x20,0x3F,0x40,0x7F,0x42,0x7D,0x81,0xFE,0x81,0xFE,0x83,0xFC
	.byte	0xD7,0xA8,0xBB,0xC4,0x6E,0x51,0x7C,0x43,0x3F,0x20,0x1F,0x18,0x07,0x07,0x00,0x00
	.byte	0xC0,0xC0,0x70,0xB0,0xE8,0x18,0xF4,0x0C,0xF4,0x0C,0xFE,0x02,0xFE,0x02,0xFE,0x02
	.byte	0xFE,0x02,0x7E,0x82,0x3C,0xC4,0x3C,0xC4,0xF8,0x08,0xF0,0x30,0xC0,0xC0,0x00,0x00
	.byte	0x07,0x07,0x1B,0x1C,0x20,0x3F,0x40,0x7F,0x40,0x7F,0xE0,0x9F,0x90,0xEF,0x89,0xF6
	.byte	0x8D,0xF2,0x9F,0xE0,0x5E,0x61,0x6F,0x50,0x3F,0x20,0x1F,0x18,0x07,0x07,0x00,0x00
	.byte	0xC0,0xC0,0xB0,0x70,0x28,0xD8,0x04,0xFC,0x2C,0xD4,0x1E,0xE2,0x1E,0xE2,0x3E,0xC2
	.byte	0x7E,0x82,0xB6,0x4A,0xE4,0x1C,0xC4,0x3C,0xF8,0x08,0xF0,0x30,0xC0,0xC0,0x00,0x00

	; Tile 0x10
	.byte	0x07,0x07,0x18,0x1F,0x20,0x3F,0x40,0x7F,0x40,0x7F,0xEE,0x91,0xF1,0x8E,0xE0,0x9F
	.byte	0xE0,0x9F,0xF1,0x8E,0x71,0x4E,0x72,0x4D,0x3F,0x20,0x1F,0x18,0x07,0x07,0x00,0x00
	.byte	0xC0,0xC0,0xF0,0x30,0x08,0xF8,0x04,0xFC,0x04,0xFC,0x02,0xFE,0x02,0xFE,0x92,0x6E
	.byte	0xD6,0x2A,0xFE,0x02,0xEC,0x14,0xFC,0x04,0xF8,0x08,0xF0,0x30,0xC0,0xC0,0x00,0x00
	.byte	0x07,0x07,0x1D,0x1A,0x36,0x29,0x5C,0x63,0x6C,0x53,0xCE,0xB1,0x9F,0xE0,0x9E,0xE1
	.byte	0xAE,0xD1,0xBF,0xC0,0x47,0x78,0x47,0x78,0x2F,0x30,0x1F,0x18,0x07,0x07,0x00,0x00
	.byte	0xC0,0xC0,0x70,0xB0,0x08,0xF8,0x04,0xFC,0x04,0xFC,0xE2,0x1E,0x32,0xCE,0x0E,0xF2
	.byte	0x0E,0xF2,0x1E,0xE2,0x1C,0xE4,0x2C,0xD4,0xF8,0x08,0xF0,0x30,0xC0,0xC0,0x00,0x00

	; Tile 0x18
	.byte	0x07,0x07,0x1E,0x19,0x33,0x2C,0x49,0x76,0x42,0x7D,0xC4,0xBB,0xC1,0xBE,0xC1,0xBE
	.byte	0xE2,0x9D,0xF3,0x8C,0x78,0x47,0x78,0x47,0x3C,0x23,0x1C,0x1B,0x07,0x07,0x00,0x00
	.byte	0xC0,0xC0,0x70,0xB0,0x68,0x98,0xC4,0x3C,0xC4,0x3C,0xEE,0x12,0xF2,0x0E,0xE2,0x1E
	.byte	0xE2,0x1E,0xF2,0x0E,0x7C,0x84,0x7C,0x84,0xF8,0x08,0xF0,0x30,0xC0,0xC0,0x00,0x00

.endtp1:

.tp2:

.frame_data:

	; Tile 0x00
	.byte	0xFF,0x00,0x80,0x7F,0x80,0x7F,0x80,0x7F,0x80,0x7F,0x80,0x7F,0x80,0x7F,0x80,0x7F
	.byte	0xFF,0x00,0x01,0xFE,0x03,0xFC,0x07,0xF8,0x0F,0xF0,0x1F,0xE0,0x3F,0xC0,0x7F,0x80
	.byte	0xFF,0x00,0xFE,0x01,0xFC,0x03,0xF8,0x07,0xF0,0x0F,0xE0,0x1F,0xC0,0x3F,0x80,0x7F
	.byte	0xFF,0x00,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF
	.byte	0xFF,0x00,0xFF,0x01,0xFD,0x03,0xF9,0x07,0xF1,0x0F,0xE1,0x1F,0xC1,0x3F,0x81,0x7F
	.byte	0x80,0x7F,0x81,0x7E,0x83,0x7C,0x87,0x78,0x8F,0x70,0x9F,0x60,0xBF,0x40,0xFF,0x00
	.byte	0xFF,0x70,0xFF,0x98,0xEF,0xB8,0xCF,0xF8,0xFF,0x70,0xFF,0x00,0xFF,0x00,0xFF,0x01
	.byte	0xFF,0x00,0xFE,0x01,0xFC,0x03,0xF8,0x07,0xF0,0x0F,0xE0,0x1F,0xC0,0x3F,0xFF,0xFF

	; Tile 0x08
	.byte	0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0xFF,0xFF
	.byte	0x00,0xFF,0x01,0xFE,0x03,0xFC,0x07,0xF8,0x0F,0xF0,0x1F,0xE0,0x3F,0xC0,0xFF,0xFF
	.byte	0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0xFF
	.byte	0xFF,0x0E,0xFF,0x13,0xFD,0x17,0xF9,0x1F,0xFE,0x0F,0xE0,0x1F,0xC0,0x3F,0x80,0xFF
	.byte	0x01,0xFF,0x01,0xFF,0x01,0xFF,0x01,0xFF,0x01,0xFF,0x01,0xFF,0x01,0xFF,0x01,0xFF
	.byte	0xFF,0x01,0xFF,0x01,0xFD,0x03,0xF9,0x07,0xF1,0x0F,0xE1,0x1F,0xC1,0x3F,0x81,0x7F
	.byte	0x80,0x7F,0x80,0x7F,0x80,0x7F,0x80,0x7F,0x80,0x7F,0x80,0x7F,0x80,0x7F,0x80,0x7F
	.byte	0x01,0xFF,0x01,0xFF,0x03,0xFD,0x07,0xF9,0x0F,0xF1,0x1F,0xE1,0x3F,0xC1,0x7F,0x81

	; Tile 0x10
	.byte	0xFF,0x01,0xFF,0x01,0xFF,0x01,0xFF,0x01,0xFF,0x01,0xFF,0x01,0xFF,0x01,0xFF,0x01
	.byte	0x01,0xFF,0x01,0xFE,0x03,0xFC,0x77,0xF8,0xFF,0x98,0xEF,0xB8,0xCF,0xF8,0x7F,0xF0
	.byte	0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x0E,0xFF,0x13,0xFD,0x17,0xF9,0x1F,0xFF,0x0E
	.byte	0x80,0x7F,0x81,0x7E,0x83,0x7C,0x87,0x78,0x8F,0x70,0x9F,0x60,0xBF,0x40,0xFF,0x7F
	.byte	0x01,0xFF,0x01,0xFF,0x01,0xFF,0x01,0xFF,0x01,0xFF,0x01,0xFF,0x01,0xFF,0xFF,0xFF

.door1_data:

	; Tile 0x15
	.byte	0xFF,0x00,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0xFF,0xFF,0xFF,0x00,0x00,0xFF
	.byte	0x00,0xFF,0x00,0xFF,0x00,0xFF,0xFF,0xFF,0xFF,0x00,0x00,0xFF,0x00,0xFF,0x00,0xFF
	.byte	0x00,0xFF,0xFF,0xFF,0xFF,0x00,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0xFF,0xFF

.door2_data:

	; Tile 0x18
	.byte	0x00,0xFF,0x00,0xFF,0x00,0xFF,0xFF,0xFF,0xFF,0x00,0x00,0xFF,0x00,0xFF,0x00,0xFF
	.byte	0x00,0xFF,0xFF,0xFF,0xFF,0x00,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0xFF,0xFF
	.byte	0xFF,0x00,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0xFF,0xFF,0xFF,0x00,0x00,0xFF
	.byte	0xFF,0x00,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF

.door3_data:

	; Tile 0x1C
	.byte	0x00,0xFF,0xFF,0xFF,0xFF,0x00,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0xFF,0xFF
	.byte	0xFF,0x00,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0xFF,0xFF,0xFF,0x00,0x00,0xFF
	.byte	0x00,0xFF,0x00,0xFF,0x00,0xFF,0xFF,0xFF,0xFF,0x00,0x00,0xFF,0x00,0xFF,0x00,0xFF
	.byte	0x00,0xFF,0x00,0xFF,0x00,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF

.door4_data:

	; Tile 0x20
	.byte	0x00,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF

.endtp2:

.tp3:

.bkg_data:

	; Tile 0x00
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xEF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xDF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFB,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xF7,0xF7,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xDF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x7F
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xF7,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xDF,0xFF,0xEF,0xFF,0xFF,0xF7,0xFF,0xFB,0xFF,0xFD,0xFF,0xFE,0xFE,0xFF

	; Tile 0x08
	.byte	0xFF,0xFF,0xFF,0xFF,0xF7,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x7D,0xFE,0x7C,0x39
	.byte	0xFF,0xFF,0xF7,0xFF,0xEF,0xFF,0xFF,0xDF,0xFF,0xBF,0xFF,0x7F,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xDF,0xFF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFE,0xFF,0xFF,0xFE,0xFF,0xFD
	.byte	0xBB,0x01,0xC7,0x83,0xC7,0x83,0xC7,0x83,0xBB,0x01,0x7C,0x39,0x7D,0xFE,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFD,0xFF,0xFF,0xFF,0xFF,0xFF,0x7F
	.byte	0xFF,0xFF,0xFF,0xFF,0xFD,0xFF,0xFF,0xFE,0xFF,0xFF,0xFF,0x7F,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFD,0xFF,0xFF,0xFB,0xAF,0x77,0x27,0x8F,0xDF,0x8F,0x27,0x8F

	; Tile 0x10
	.byte	0xFF,0xFF,0xFF,0xFE,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFB,0xFF,0xF7,0xEF,0xFF,0xDF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x7F,0xFF,0xFF,0xFB,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xBF,0xFF,0xDF,0xEF,0xFF,0xF7,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFD,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFE,0xFD,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.byte	0xAF,0x77,0xFF,0xFB,0xFD,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFD,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFB,0xFF

	; Tile 0x18
	.byte	0xFF,0xFF,0xFF,0xFF,0xFE,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x7F,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xF7,0xFF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFB,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFE,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFE,0xFF,0x7D,0xFE,0x7C,0x39
	.byte	0xFF,0xFF,0xF7,0xFF,0xEF,0xFF,0xFF,0xDF,0xFF,0xBF,0xFF,0x7F,0x7F,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xBF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFD,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xEF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x7F,0xFD

	; Tile 0x20
	.byte	0xFF,0xFF,0xDF,0xFF,0xEF,0xFF,0xFF,0xF7,0xFF,0xFB,0xFE,0xFD,0xFD,0xFE,0xFE,0xFF
	.byte	0xAB,0x11,0xC7,0x83,0x83,0xC7,0xC7,0x83,0xAB,0x11,0x7C,0x39,0x7D,0xFE,0xFE,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFB,0xDF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x7F,0xFF,0xFF,0x7F
	.byte	0xFB,0xFF,0xFF,0xFD,0xFE,0xFE,0xFE,0xFF,0xFE,0xFE,0xFF,0xFD,0xFB,0xFF,0xFF,0xFF
	.byte	0xEF,0xFF,0xFF,0xDF,0x3F,0xBF,0x3F,0x7F,0x3F,0xBF,0xFF,0xDF,0xEF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xEF,0xFB,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFE,0xFF,0xFD,0xFE,0xFE,0xFD
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFB,0xFF,0xFF

	; Tile 0x28
	.byte	0xF7,0xFF,0xFB,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xBF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFE,0xFE,0xFF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFD,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.byte	0xFF,0xFF,0xFF,0xFF,0x7F,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF

.endtp3:

	; Image size: 0x40 x 0x40
	; Number of tiles (total - unique): 0x40 - 0x2D

.bkg_tiles:

	.byte	0x00,0x01,0x02,0x03,0xFC,0xFC,0x04,0xFC
	.byte	0x00,0x01,0x02,0x03,0xFC,0xFC,0x04,0xFC
	.byte	0x00,0x01,0x02,0x03,0xFC,0xFC,0x04,0xFC
	.byte	0x00,0x01,0x02,0x03,0xFC,0xFC,0x04,0xFC

	.byte	0xFC,0x05,0x06,0xFC,0x07,0x08,0x09,0x0A
	.byte	0xFC,0x05,0x06,0xFC,0x07,0x08,0x09,0x0A
	.byte	0xFC,0x05,0x06,0xFC,0x07,0x08,0x09,0x0A
	.byte	0xFC,0x05,0x06,0xFC,0x07,0x08,0x09,0x0A

	.byte	0xFC,0xFC,0xFC,0x02,0x0B,0x0C,0x0D,0xFC
	.byte	0xFC,0xFC,0xFC,0x02,0x0B,0x0C,0x0D,0xFC
	.byte	0xFC,0xFC,0xFC,0x02,0x0B,0x0C,0x0D,0xFC
	.byte	0xFC,0xFC,0xFC,0x02,0x0B,0x0C,0x0D,0xFC

	.byte	0x0E,0x0F,0x10,0xFC,0x11,0x12,0x13,0x14
	.byte	0x0E,0x0F,0x10,0xFC,0x11,0x12,0x13,0x14
	.byte	0x0E,0x0F,0x10,0xFC,0x11,0x12,0x13,0x14
	.byte	0x0E,0x0F,0x10,0xFC,0x11,0x12,0x13,0x14

	.byte	0x15,0x16,0x17,0xFC,0x18,0x19,0x1A,0xFC
	.byte	0x15,0x16,0x17,0xFC,0x18,0x19,0x1A,0xFC
	.byte	0x15,0x16,0x17,0xFC,0x18,0x19,0x1A,0xFC
	.byte	0x15,0x16,0x17,0xFC,0x18,0x19,0x1A,0xFC

	.byte	0x1B,0x1C,0x1D,0xFC,0xFC,0x1E,0x1F,0x20
	.byte	0x1B,0x1C,0x1D,0xFC,0xFC,0x1E,0x1F,0x20
	.byte	0x1B,0x1C,0x1D,0xFC,0xFC,0x1E,0x1F,0x20
	.byte	0x1B,0x1C,0x1D,0xFC,0xFC,0x1E,0x1F,0x20

	.byte	0x21,0x22,0xFC,0x23,0x24,0x25,0xFC,0x26
	.byte	0x21,0x22,0xFC,0x23,0x24,0x25,0xFC,0x26
	.byte	0x21,0x22,0xFC,0x23,0x24,0x25,0xFC,0x26
	.byte	0x21,0x22,0xFC,0x23,0x24,0x25,0xFC,0x26

	.byte	0x27,0x13,0x28,0x29,0x2A,0x2B,0x2C,0x11
	.byte	0x27,0x13,0x28,0x29,0x2A,0x2B,0x2C,0x11
	.byte	0x27,0x13,0x28,0x29,0x2A,0x2B,0x2C,0x11
	.byte	0x27,0x13,0x28,0x29,0x2A,0x2B,0x2C,0x11

	.byte	0x00,0x01,0x02,0x03,0xFC,0xFC,0x04,0xFC
	.byte	0x00,0x01,0x02,0x03,0xFC,0xFC,0x04,0xFC
	.byte	0x00,0x01,0x02,0x03,0xFC,0xFC,0x04,0xFC
	.byte	0x00,0x01,0x02,0x03,0xFC,0xFC,0x04,0xFC

	.byte	0xFC,0x05,0x06,0xFC,0x07,0x08,0x09,0x0A
	.byte	0xFC,0x05,0x06,0xFC,0x07,0x08,0x09,0x0A
	.byte	0xFC,0x05,0x06,0xFC,0x07,0x08,0x09,0x0A
	.byte	0xFC,0x05,0x06,0xFC,0x07,0x08,0x09,0x0A

	.byte	0xFC,0xFC,0xFC,0x02,0x0B,0x0C,0x0D,0xFC
	.byte	0xFC,0xFC,0xFC,0x02,0x0B,0x0C,0x0D,0xFC
	.byte	0xFC,0xFC,0xFC,0x02,0x0B,0x0C,0x0D,0xFC
	.byte	0xFC,0xFC,0xFC,0x02,0x0B,0x0C,0x0D,0xFC

	.byte	0x0E,0x0F,0x10,0xFC,0x11,0x12,0x13,0x14
	.byte	0x0E,0x0F,0x10,0xFC,0x11,0x12,0x13,0x14
	.byte	0x0E,0x0F,0x10,0xFC,0x11,0x12,0x13,0x14
	.byte	0x0E,0x0F,0x10,0xFC,0x11,0x12,0x13,0x14

	.byte	0x15,0x16,0x17,0xFC,0x18,0x19,0x1A,0xFC
	.byte	0x15,0x16,0x17,0xFC,0x18,0x19,0x1A,0xFC
	.byte	0x15,0x16,0x17,0xFC,0x18,0x19,0x1A,0xFC
	.byte	0x15,0x16,0x17,0xFC,0x18,0x19,0x1A,0xFC

	.byte	0x1B,0x1C,0x1D,0xFC,0xFC,0x1E,0x1F,0x20
	.byte	0x1B,0x1C,0x1D,0xFC,0xFC,0x1E,0x1F,0x20
	.byte	0x1B,0x1C,0x1D,0xFC,0xFC,0x1E,0x1F,0x20
	.byte	0x1B,0x1C,0x1D,0xFC,0xFC,0x1E,0x1F,0x20

	.byte	0x21,0x22,0xFC,0x23,0x24,0x25,0xFC,0x26
	.byte	0x21,0x22,0xFC,0x23,0x24,0x25,0xFC,0x26
	.byte	0x21,0x22,0xFC,0x23,0x24,0x25,0xFC,0x26
	.byte	0x21,0x22,0xFC,0x23,0x24,0x25,0xFC,0x26

	.byte	0x27,0x13,0x28,0x29,0x2A,0x2B,0x2C,0x11
	.byte	0x27,0x13,0x28,0x29,0x2A,0x2B,0x2C,0x11
	.byte	0x27,0x13,0x28,0x29,0x2A,0x2B,0x2C,0x11
	.byte	0x27,0x13,0x28,0x29,0x2A,0x2B,0x2C,0x11

	.byte	0x00,0x01,0x02,0x03,0xFC,0xFC,0x04,0xFC
	.byte	0x00,0x01,0x02,0x03,0xFC,0xFC,0x04,0xFC
	.byte	0x00,0x01,0x02,0x03,0xFC,0xFC,0x04,0xFC
	.byte	0x00,0x01,0x02,0x03,0xFC,0xFC,0x04,0xFC

	.byte	0xFC,0x05,0x06,0xFC,0x07,0x08,0x09,0x0A
	.byte	0xFC,0x05,0x06,0xFC,0x07,0x08,0x09,0x0A
	.byte	0xFC,0x05,0x06,0xFC,0x07,0x08,0x09,0x0A
	.byte	0xFC,0x05,0x06,0xFC,0x07,0x08,0x09,0x0A

	.byte	0xFC,0xFC,0xFC,0x02,0x0B,0x0C,0x0D,0xFC
	.byte	0xFC,0xFC,0xFC,0x02,0x0B,0x0C,0x0D,0xFC
	.byte	0xFC,0xFC,0xFC,0x02,0x0B,0x0C,0x0D,0xFC
	.byte	0xFC,0xFC,0xFC,0x02,0x0B,0x0C,0x0D,0xFC

	.byte	0x0E,0x0F,0x10,0xFC,0x11,0x12,0x13,0x14
	.byte	0x0E,0x0F,0x10,0xFC,0x11,0x12,0x13,0x14
	.byte	0x0E,0x0F,0x10,0xFC,0x11,0x12,0x13,0x14
	.byte	0x0E,0x0F,0x10,0xFC,0x11,0x12,0x13,0x14

	.byte	0x15,0x16,0x17,0xFC,0x18,0x19,0x1A,0xFC
	.byte	0x15,0x16,0x17,0xFC,0x18,0x19,0x1A,0xFC
	.byte	0x15,0x16,0x17,0xFC,0x18,0x19,0x1A,0xFC
	.byte	0x15,0x16,0x17,0xFC,0x18,0x19,0x1A,0xFC

	.byte	0x1B,0x1C,0x1D,0xFC,0xFC,0x1E,0x1F,0x20
	.byte	0x1B,0x1C,0x1D,0xFC,0xFC,0x1E,0x1F,0x20
	.byte	0x1B,0x1C,0x1D,0xFC,0xFC,0x1E,0x1F,0x20
	.byte	0x1B,0x1C,0x1D,0xFC,0xFC,0x1E,0x1F,0x20

	.byte	0x21,0x22,0xFC,0x23,0x24,0x25,0xFC,0x26
	.byte	0x21,0x22,0xFC,0x23,0x24,0x25,0xFC,0x26
	.byte	0x21,0x22,0xFC,0x23,0x24,0x25,0xFC,0x26
	.byte	0x21,0x22,0xFC,0x23,0x24,0x25,0xFC,0x26

	.byte	0x27,0x13,0x28,0x29,0x2A,0x2B,0x2C,0x11
	.byte	0x27,0x13,0x28,0x29,0x2A,0x2B,0x2C,0x11
	.byte	0x27,0x13,0x28,0x29,0x2A,0x2B,0x2C,0x11
	.byte	0x27,0x13,0x28,0x29,0x2A,0x2B,0x2C,0x11

	.byte	0x00,0x01,0x02,0x03,0xFC,0xFC,0x04,0xFC
	.byte	0x00,0x01,0x02,0x03,0xFC,0xFC,0x04,0xFC
	.byte	0x00,0x01,0x02,0x03,0xFC,0xFC,0x04,0xFC
	.byte	0x00,0x01,0x02,0x03,0xFC,0xFC,0x04,0xFC

	.byte	0xFC,0x05,0x06,0xFC,0x07,0x08,0x09,0x0A
	.byte	0xFC,0x05,0x06,0xFC,0x07,0x08,0x09,0x0A
	.byte	0xFC,0x05,0x06,0xFC,0x07,0x08,0x09,0x0A
	.byte	0xFC,0x05,0x06,0xFC,0x07,0x08,0x09,0x0A

	.byte	0xFC,0xFC,0xFC,0x02,0x0B,0x0C,0x0D,0xFC
	.byte	0xFC,0xFC,0xFC,0x02,0x0B,0x0C,0x0D,0xFC
	.byte	0xFC,0xFC,0xFC,0x02,0x0B,0x0C,0x0D,0xFC
	.byte	0xFC,0xFC,0xFC,0x02,0x0B,0x0C,0x0D,0xFC

	.byte	0x0E,0x0F,0x10,0xFC,0x11,0x12,0x13,0x14
	.byte	0x0E,0x0F,0x10,0xFC,0x11,0x12,0x13,0x14
	.byte	0x0E,0x0F,0x10,0xFC,0x11,0x12,0x13,0x14
	.byte	0x0E,0x0F,0x10,0xFC,0x11,0x12,0x13,0x14

	.byte	0x15,0x16,0x17,0xFC,0x18,0x19,0x1A,0xFC
	.byte	0x15,0x16,0x17,0xFC,0x18,0x19,0x1A,0xFC
	.byte	0x15,0x16,0x17,0xFC,0x18,0x19,0x1A,0xFC
	.byte	0x15,0x16,0x17,0xFC,0x18,0x19,0x1A,0xFC

	.byte	0x1B,0x1C,0x1D,0xFC,0xFC,0x1E,0x1F,0x20
	.byte	0x1B,0x1C,0x1D,0xFC,0xFC,0x1E,0x1F,0x20
	.byte	0x1B,0x1C,0x1D,0xFC,0xFC,0x1E,0x1F,0x20
	.byte	0x1B,0x1C,0x1D,0xFC,0xFC,0x1E,0x1F,0x20

	.byte	0x21,0x22,0xFC,0x23,0x24,0x25,0xFC,0x26
	.byte	0x21,0x22,0xFC,0x23,0x24,0x25,0xFC,0x26
	.byte	0x21,0x22,0xFC,0x23,0x24,0x25,0xFC,0x26
	.byte	0x21,0x22,0xFC,0x23,0x24,0x25,0xFC,0x26

	.byte	0x27,0x13,0x28,0x29,0x2A,0x2B,0x2C,0x11
	.byte	0x27,0x13,0x28,0x29,0x2A,0x2B,0x2C,0x11
	.byte	0x27,0x13,0x28,0x29,0x2A,0x2B,0x2C,0x11
	.byte	0x27,0x13,0x28,0x29,0x2A,0x2B,0x2C,0x11

	; Image size: 0x10 x 0x70
	; Number of tiles (total - unique): 0x1C - 0x1C

.earth_tiles:

	.byte	0x00,0x02
	.byte	0x04,0x06
	.byte	0x08,0x0A
	.byte	0x0C,0x0E
	.byte	0x10,0x12
	.byte	0x14,0x16
	.byte	0x18,0x1A

	; Image size: 0x80 x 0x50
	; Number of tiles (total - unique): 0xA0 - 0x15

.frame_tiles:

	.byte	0x80,0x81,0xFD,0x82,0x83,0x81,0xFD,0x82,0x83,0x81,0xFD,0x82,0x83,0x81,0xFD,0x84
	.byte	0x85,0x86,0x87,0x88,0x89,0x8A,0x87,0x88,0x89,0x8A,0x87,0x88,0x89,0x8A,0x8B,0x8C
	.byte	0xFD,0x8D,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x8E,0x8F
	.byte	0x82,0x8C,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x85,0x90
	.byte	0x8E,0x8F,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFD,0x8D
	.byte	0x85,0x90,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x82,0x8C
	.byte	0xFD,0x8D,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x8E,0x8F
	.byte	0x82,0x8C,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x85,0x90
	.byte	0x8E,0x91,0xFD,0x82,0x83,0x81,0xFD,0x82,0x83,0x81,0xFD,0x82,0x83,0x81,0x92,0x8D
	.byte	0x93,0x8A,0x87,0x88,0x89,0x8A,0x87,0x88,0x89,0x8A,0x87,0x88,0x89,0x8A,0x87,0x94

	; Image size: 0x60 x 0x30
	; Number of tiles (total - unique): 0x48 - 0x03

.door1_tiles:

	.byte	0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95
	.byte	0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96
	.byte	0x97,0x97,0x97,0x97,0x97,0x97,0x97,0x97,0x97,0x97,0x97,0x97
	.byte	0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95
	.byte	0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96
	.byte	0x97,0x97,0x97,0x97,0x97,0x97,0x97,0x97,0x97,0x97,0x97,0x97

	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC
	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC
	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC
	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC
	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC
	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC

	; Image size: 0x60 x 0x30
	; Number of tiles (total - unique): 0x48 - 0x04

.door2_tiles:

	.byte	0x98,0x98,0x98,0x98,0x98,0x98,0x98,0x98,0x98,0x98,0x98,0x98
	.byte	0x99,0x99,0x99,0x99,0x99,0x99,0x99,0x99,0x99,0x99,0x99,0x99
	.byte	0x9A,0x9A,0x9A,0x9A,0x9A,0x9A,0x9A,0x9A,0x9A,0x9A,0x9A,0x9A
	.byte	0x98,0x98,0x98,0x98,0x98,0x98,0x98,0x98,0x98,0x98,0x98,0x98
	.byte	0x99,0x99,0x99,0x99,0x99,0x99,0x99,0x99,0x99,0x99,0x99,0x99
	.byte	0x9B,0x9B,0x9B,0x9B,0x9B,0x9B,0x9B,0x9B,0x9B,0x9B,0x9B,0x9B

	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC
	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC
	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC
	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC
	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC

	; Image size: 0x60 x 0x30
	; Number of tiles (total - unique): 0x48 - 0x04

.door3_tiles:

	.byte	0x9C,0x9C,0x9C,0x9C,0x9C,0x9C,0x9C,0x9C,0x9C,0x9C,0x9C,0x9C
	.byte	0x9D,0x9D,0x9D,0x9D,0x9D,0x9D,0x9D,0x9D,0x9D,0x9D,0x9D,0x9D
	.byte	0x9E,0x9E,0x9E,0x9E,0x9E,0x9E,0x9E,0x9E,0x9E,0x9E,0x9E,0x9E
	.byte	0x9C,0x9C,0x9C,0x9C,0x9C,0x9C,0x9C,0x9C,0x9C,0x9C,0x9C,0x9C
	.byte	0x9D,0x9D,0x9D,0x9D,0x9D,0x9D,0x9D,0x9D,0x9D,0x9D,0x9D,0x9D
	.byte	0x9F,0x9F,0x9F,0x9F,0x9F,0x9F,0x9F,0x9F,0x9F,0x9F,0x9F,0x9F

	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC
	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC
	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC
	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC
	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC

	; Image size: 0x60 x 0x30
	; Number of tiles (total - unique): 0x48 - 0x01

.door4_tiles:

	.byte	0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95
	.byte	0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96
	.byte	0x97,0x97,0x97,0x97,0x97,0x97,0x97,0x97,0x97,0x97,0x97,0x97
	.byte	0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95,0x95
	.byte	0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96,0x96
	.byte	0xA0,0xA0,0xA0,0xA0,0xA0,0xA0,0xA0,0xA0,0xA0,0xA0,0xA0,0xA0

	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC
	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC
	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC
	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC
	.byte	0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC

.film:
	.word	.door1_tiles+0x0C*0
	.word	.door2_tiles+0x0C*0
	.word	.door3_tiles+0x0C*0
	.word	.door4_tiles+0x0C*0
	.word	.door1_tiles+0x0C*1
	.word	.door2_tiles+0x0C*1
	.word	.door3_tiles+0x0C*1
	.word	.door4_tiles+0x0C*1
	.word	.door1_tiles+0x0C*2
	.word	.door2_tiles+0x0C*2
	.word	.door3_tiles+0x0C*2
	.word	.door4_tiles+0x0C*2
	.word	.door1_tiles+0x0C*3
	.word	.door2_tiles+0x0C*3
	.word	.door3_tiles+0x0C*3
	.word	.door4_tiles+0x0C*3
	.word	.door1_tiles+0x0C*4
	.word	.door2_tiles+0x0C*4
	.word	.door3_tiles+0x0C*4
	.word	.door4_tiles+0x0C*4
	.word	.door1_tiles+0x0C*5
	.word	.door2_tiles+0x0C*5
	.word	.door3_tiles+0x0C*5
	.word	.door4_tiles+0x0C*5
.endfilm:
	.word	.door1_tiles+0x0C*6
