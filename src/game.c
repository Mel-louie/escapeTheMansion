/*#+/+/+/+/+/+/+/+/+/+/+/+/+/#
#    Escape the Mansion  	 #
#						     #
#       ©H GRAY 2021    	 #
#+/+/+/+/+/+/+/+/+/+/+/+/+/#*/

#include "../include/game.h"


void	game(s *fire, s*pl) {

	if (!pl->o)
		init_sprites(fire, pl);
	player_init(pl, fire);
	perform_delay(1);
}

void	init_game(s *fire) {

	HIDE_BKG;
	SHOW_SPRITES;
	SPRITES_8x16;
	init_map(fire);
}