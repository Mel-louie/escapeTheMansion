/*#+/+/+/+/+/+/+/+/+/+/+/+/+/#
#    Escape the Mansion  	 #
#						     #
#       ©H GRAY 2021    	 #
#+/+/+/+/+/+/+/+/+/+/+/+/+/#*/

#include "../include/game.h"

/* unused palettes
CGB_PAL(27, 31, 27), CGB_PAL(19, 29, 15), CGB_PAL(9, 16, 16), CGB_PAL(5, 7, 5), //sweet green0			//0
*/

const UWORD palette_splash[] =
{
	CGB_PAL(25, 31, 23), CGB_PAL(19, 29, 15), CGB_PAL(9, 16, 16), CGB_PAL(4, 4, 6), //sweet green0			//0
	CGB_PAL(19, 29, 15), CGB_PAL(19, 29, 15), CGB_PAL(9, 16, 16), CGB_PAL(4, 4, 6), //sweet green1			//4
	CGB_PAL(9, 16, 16), CGB_PAL(9, 16, 16), CGB_PAL(9, 16, 16), CGB_PAL(4, 4, 6), //sweet green2			//8
	CGB_PAL(4, 4, 6), CGB_PAL(4, 4, 6), CGB_PAL(4, 4, 6), CGB_PAL(4, 4, 6),			//sweet green3			//12
};

void	clear_title_screen(void) {

	perform_delay(15);
	BGP_REG = 0xf9;
	set_bkg_palette( 0, 1, &palette_splash[4] );
	perform_delay(20);
	BGP_REG = 0xfe;
	set_bkg_palette( 0, 1, &palette_splash[8] );
	perform_delay(25);
	BGP_REG = 0xff;
	set_bkg_palette( 0, 1, &palette_splash[12] );
	perform_delay(30);
	BGP_REG = 0xe4;
	set_bkg_palette( 0, 1, &palette_splash[0] );
	HIDE_WIN;
	HIDE_BKG;
}

void	splash_screen(void) {

	set_bkg_data(0, TILESET_TILE_COUNTSP, TILESETSP);
	set_bkg_tiles(0, 0, TILEMAP_WIDTHSP, TILEMAP_HEIGHTSP, TILEMAPSP);
	SHOW_BKG;
	// Black screen (initial state)
	BGP_REG = 0xFF;
	set_bkg_palette( 0, 1, &palette_splash[12] );
	perform_delay(60);  // ~ 1s

	// Fade-in
	BGP_REG = 0xff;
	set_bkg_palette( 0, 1, &palette_splash[12] );
	perform_delay(15);
	BGP_REG = 0xfe;
	set_bkg_palette( 0, 1, &palette_splash[8] );
	perform_delay(15);
	BGP_REG = 0xf9;
	set_bkg_palette( 0, 1, &palette_splash[4] );
	perform_delay(15);
	BGP_REG = 0xe4;
	set_bkg_palette( 0, 1, &palette_splash[0] );
	perform_delay(15);

	perform_delay(90);  // ~ 1.5s

	// Fade-out
	BGP_REG = 0xe4; // normal palette
	set_bkg_palette( 0, 1, &palette_splash[0] );
	perform_delay(15);
	BGP_REG = 0xf9;
	set_bkg_palette( 0, 1, &palette_splash[4] );
	perform_delay(15);
	BGP_REG = 0xfe;
	set_bkg_palette( 0, 1, &palette_splash[8] );
	perform_delay(15);
	BGP_REG = 0xff;
	set_bkg_palette( 0, 1, &palette_splash[12] );
	perform_delay(15);

	perform_delay(60);
	HIDE_BKG;
}

void	title_screen(void) {

	perform_delay(10);

	set_bkg_data(0, TILESET_SCREEN_TILE_COUNT, TILESET_SCREEN);
	set_bkg_tiles(0, 0, TILEMAP_SCREEN_WIDTH, TILEMAP_SCREEN_HEIGHT, TILEMAP_SCREEN);

	BGP_REG = 0xe4; // puts back the PALETTE to its init point, very important to not have a forever with/black background
	set_bkg_palette( 0, 1, &palette_splash[0] );
	SHOW_BKG;

	// TEXT
	text_load_font(1);
	move_win(0, 16*8);
	text_putstr_win(0, 0, "     press start     \n                   ");
	// show text
	SHOW_WIN;
	// blinking text
	while (1) {
		if (perform_delay_joypad(45))
			break ;
		HIDE_WIN;
		if (perform_delay_joypad(25))
			break ;
		SHOW_WIN;
	}
}
