/*#+/+/+/+/+/+/+/+/+/+/+/+/+/#
#    Escape the Mansion  	 #
#						     #
#       ©H GRAY 2021    	 #
#+/+/+/+/+/+/+/+/+/+/+/+/+/#*/

#include "../include/game.h"



void	init_fire(s *fire) {

	fire->sprite_pos_world[0] = 7;
	fire->sprite_pos_world[1] = 6;
	fire->sprite_pos_screen[0] = fire->sprite_pos_world[0] * 8;
	fire->sprite_pos_screen[1] = fire->sprite_pos_world[1] * 10;
	fire->sprite_animation_frame = 0;
	fire->frame_skip = 6;

	// load tiles sprites in video memory
	// 0 -> first 8 pix of the sprite, 1 -> 8 next
	set_sprite_data(0, FIRE_TILE_COUNT, FIRE);
	set_sprite_tile(0, 0);
	set_sprite_tile(1, 2);
	set_sprite_prop(0, S_PALETTE);
	set_sprite_prop(1, S_PALETTE);
	move_sprite(0, fire->sprite_pos_screen[0], fire->sprite_pos_screen[1]);
	move_sprite(1, fire->sprite_pos_screen[0] + 8, fire->sprite_pos_screen[1]);
}

void	init_player(s *pl) {

	pl->sprite_pos_world[0] = 12;
	pl->sprite_pos_world[1] = 9;
	pl->sprite_pos_screen[0] = pl->sprite_pos_world[0] * 8;
	pl->sprite_pos_screen[1] = pl->sprite_pos_world[1] * 8;
	pl->sprite_animation_frame = 0;
	pl->frame_skip = 6;
	set_sprite_data(38, PLAYER_TILE_COUNT, PLAYER);
	set_sprite_tile(3, 38);
	set_sprite_tile(4, 40);
	move_sprite(3, pl->sprite_pos_screen[0], pl->sprite_pos_screen[1]);
	move_sprite(4, pl->sprite_pos_screen[0] + 8, pl->sprite_pos_screen[1]);
}

void	init_sprites(s *fire, s *pl) {
	
	fire->o = 1;
	init_fire(fire);
	init_player(pl);
}