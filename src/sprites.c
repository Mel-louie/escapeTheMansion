/*#+/+/+/+/+/+/+/+/+/+/+/+/+/#
#    Escape the Mansion  	 #
#						     #
#       ©H GRAY 2021    	 #
#+/+/+/+/+/+/+/+/+/+/+/+/+/#*/

#include "../include/game.h"

void	anim_fire(s *fire)
{
	if (fire->animX <= 57)
	{
		set_sprite_tile(2, fire->animX = (fire->animX + 4));
		set_sprite_tile(3, fire->animY = (fire->animY + 4));
		perform_delay(1);
		//delay(10);
	}
	else
	{
		fire->animX = 36;
		fire->animY = fire->animX + 2;
		set_sprite_tile(2, fire->animX);
		set_sprite_tile(3, fire->animY);
		perform_delay(1);
	}	
}

void	init_fire(s *fire)
{
	fire->sprite_pos_world[0] = 7;
	fire->sprite_pos_world[1] = 6;
	fire->sprite_pos_screen[0] = fire->sprite_pos_world[0] * 8;
	fire->sprite_pos_screen[1] = fire->sprite_pos_world[1] * 10;
	fire->sprite_animation_frame = 0;
	fire->frame_skip = 6;

	fire->animX = 36;
	fire->animY = fire->animX + 2;

	set_sprite_data(36, FIRE_TILE_COUNT, FIRE);
	set_sprite_tile(2, fire->animX);
	set_sprite_tile(3, fire->animY);
	set_sprite_prop(2, S_PALETTE);
	set_sprite_prop(3, S_PALETTE);
	move_sprite(2, fire->sprite_pos_screen[0], fire->sprite_pos_screen[1]);
	move_sprite(3, fire->sprite_pos_screen[0] + 8, fire->sprite_pos_screen[1]);
}

void	init_player(s *pl)
{
	pl->sprite_pos_world[0] = 12;
	pl->sprite_pos_world[1] = 9;
	pl->sprite_pos_screen[0] = pl->sprite_pos_world[0] * 8;
	pl->sprite_pos_screen[1] = pl->sprite_pos_world[1] * 8;
	pl->sprite_animation_frame = 0;
	pl->frame_skip = 6;
	set_sprite_data(0, PLAYER_TILE_COUNT, PLAYER);
	// load tiles sprites in video memory
	// 0 -> first 8 pix of the sprite, 1 -> 8 next
	set_sprite_tile(0, 0);
	set_sprite_tile(1, 2);
	move_sprite(0, pl->sprite_pos_screen[0], pl->sprite_pos_screen[1]);
	move_sprite(1, pl->sprite_pos_screen[0] + 8, pl->sprite_pos_screen[1]);
}

void	init_sprites(s *fire, s *pl)
{	
	pl->o = 1;
	init_fire(fire);
	init_player(pl);
}
