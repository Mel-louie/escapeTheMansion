/*#+/+/+/+/+/+/+/+/+/+/+/+/+/#
#    Escape the Mansion  	 #
#						     #
#       ©H GRAY 2021    	 #
#+/+/+/+/+/+/+/+/+/+/+/+/+/#*/

#include "../include/game.h"


void	game(s *fire, s*pl) {

	if (!pl->o)
		init_sprites(fire, pl);

	if (fire->animX <= 46)
	{
		set_sprite_tile(2, fire->animX = (fire->animX + 4));
		set_sprite_tile(3, fire->animY = (fire->animY + 4));
	}
	else {
		fire->animX = 36;
		fire->animY = fire->animX + 2;
		set_sprite_tile(2, fire->animX);
		set_sprite_tile(3, fire->animY);
	}
	player_init(pl);
}

void	init_game(void) {

	HIDE_BKG;
	SHOW_SPRITES;
	SPRITES_8x16;
	init_map();
}