/*#+/+/+/+/+/+/+/+/+/+/+/+/+/#
#    Escape the Mansion  	 #
#						     #
#       ©H GRAY 2021    	 #
#+/+/+/+/+/+/+/+/+/+/+/+/+/#*/

#include "../include/game.h"

extern const unsigned char * song_Data[];

const UWORD palette_table[] =
{
	CGB_PAL(25, 31, 23), CGB_PAL(19, 29, 15), CGB_PAL(9, 16, 16), CGB_PAL(4, 4, 6), //sweet green0			//0

	CGB_PAL(25, 31, 23), CGB_PAL(25, 31, 23), CGB_PAL(9, 16, 16), CGB_PAL(4, 4, 6), //sweet green0 sprites	//4
	CGB_PAL(31, 10, 23), CGB_PAL(31, 26, 31), CGB_PAL(23, 13, 17), CGB_PAL(5, 3, 5), //sweet red0 sprites	//8

	CGB_PAL(19, 29, 15), CGB_PAL(19, 29, 15), CGB_PAL(9, 16, 16), CGB_PAL(4, 4, 6), //sweet green1			//12
	CGB_PAL(9, 16, 16), CGB_PAL(9, 16, 16), CGB_PAL(9, 16, 16), CGB_PAL(4, 4, 6), //sweet green2			//16
	CGB_PAL(4, 4, 6), CGB_PAL(4, 4, 6), CGB_PAL(4, 4, 6), CGB_PAL(4, 4, 6),			//sweet green3			//20
};

void	main(void) {

	set_bkg_palette(0, 1, &palette_table[0]);
	set_sprite_palette(0, 1, &palette_table[8]);
	splash_screen();

	disable_interrupts();
	gbt_play(song_Data, 2, 7);
	gbt_loop(0);

	set_interrupts(VBL_IFLAG);
	enable_interrupts();

	HIDE_BKG;
	title_screen();
	clear_title_screen();

	s	fire;
	s	pl;

	fire.o = 0;
	init_game();
	while (1) {
		wait_vbl_done();
		game(&fire, &pl);

        gbt_update(); // This will change to ROM bank 1.

	}
}
