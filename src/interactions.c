/*#+/+/+/+/+/+/+/+/+/+/+/+/+/#
#    Escape the Mansion  	 #
#						     #
#       ©H GRAY 2021    	 #
#+/+/+/+/+/+/+/+/+/+/+/+/+/#*/

#pragma bank 1

#include "../include/game.h"

// the numbers represent the byte where the
// sub-animation starts in the global data of the
// player
/*PLAYER_DIRECTION_DOWN	0
 PLAYER_DIRECTION_UP	1
 PLAYER_DIRECTION_RIGHT	2
 PLAYER_DIRECTION_LEFT	3*/

void	interact(s *pl, s *fire)
{
	UINT8 cx = pl->sprite_pos_world[0];
	UINT8 cy = pl->sprite_pos_world[1];
	UINT8 tile;

	if (pl->player_direction == 2)
	{
		cx = cx + 1;
		cy = cy - 1;
	}
	else if (pl->player_direction == 0)
		cy = cy + 2;
	else if (pl->player_direction == 1)
		cy = cy - 2;
	else if (pl->player_direction == 3)
	{
		cx = cx - 2;
		cy = cy - 1;
	}
		
	get_bkg_tiles(cx , cy , 1, 1, &tile);

	if (tile == 0x2C)
		show_message("\nIt's the bin.\nIt smells like\nfish...", pl->sprite_pos_screen[0], pl->sprite_pos_screen[1]);
	if (pl->player_direction == 1 && tile == 0x25 )
	{
		show_message("\nThe fire seems\nto be animated\nby its own\nconsciousness.\n\nWeird.", pl->sprite_pos_screen[0], pl->sprite_pos_screen[1]);
	}
	//ex sprites interaction
	/*else if (pl->player_direction == PLAYER_DIRECTION_UP &&
	pl->player_pos_world[0] == cat->player_pos_world[0] && pl->player_pos_world[1] == cat->player_pos_world[1] + 1) {
		set_sprite_prop(3, get_sprite_prop(3) & ~S_FLIPX);
		set_sprite_prop(4, get_sprite_prop(4) & ~S_FLIPX);
		set_sprite_tile(3, CAT_ANIMATION_DOWN[cat->player_animation_frame]);
		set_sprite_tile(4, CAT_ANIMATION_DOWN[cat->player_animation_frame] + 2);
		show_message("Meow ?", pl->player_pos_screen[0], pl->player_pos_screen[1]);
		set_sprite_prop(3, get_sprite_prop(3) & ~S_FLIPX);
		set_sprite_prop(4, get_sprite_prop(4) & ~S_FLIPX);
		set_sprite_tile(3, 62);
		set_sprite_tile(4, 64);
	}*/
}
