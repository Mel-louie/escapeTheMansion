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
	CGB_PAL(31, 29, 31), CGB_PAL(31, 29, 31), CGB_PAL(20, 13, 14), CGB_PAL(5, 3, 5), //sweet red0 sprites	//8
};

void	main(void) {

	set_bkg_palette(0, 1, &palette_table[0]);
	set_sprite_palette(0, 1, &palette_table[8]);
//	splash_screen();

	disable_interrupts();
	gbt_play(song_Data, 2, 7);
	gbt_loop(0);

	set_interrupts(VBL_IFLAG);
	enable_interrupts();

	HIDE_BKG;
//	title_screen();
//	clear_title_screen();

	s	fire;
	s	pl;

	pl.o = 0;
	fire.o = 0;
	init_game(&fire);
	while (1) {		
		wait_vbl_done();
		game(&fire, &pl);
        gbt_update(); // This will change to ROM bank 1.
	}
}
