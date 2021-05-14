/*#+/+/+/+/+/+/+/+/+/+/+/+/+/#
#    Escape the Mansion  	 #
#						     #
#       ©H GRAY 2021    	 #
#+/+/+/+/+/+/+/+/+/+/+/+/+/#*/

#include "../include/game.h"

// the numbers represent the byte where the
// sub-animation starts in the global data of the
// player
#define PLAYER_DIRECTION_DOWN	0
#define PLAYER_DIRECTION_UP		1
#define PLAYER_DIRECTION_RIGHT	2
#define PLAYER_DIRECTION_LEFT	3

// datas to animate the player
UINT8 PLAYER_ANIMATION_SIDE[] = {24, 28, 24, 32};
UINT8 PLAYER_ANIMATION_UP[] = {12, 16, 12, 20};
UINT8 PLAYER_ANIMATION_DOWN[] = {0, 4, 0, 8};

void	move_player(INT8 dx, INT8 dy, s *pl) {

	pl->sprite_pos_world[0] += dx;
	pl->sprite_pos_world[1] += dy;


	for (UINT8 delta = 8 ; delta ; delta--) {	// moving 8 squares by 8 squares, maybe change in 16x16
	// move player
		pl->sprite_pos_screen[0] += dx;
		pl->sprite_pos_screen[1] += dy;
		move_sprite(0, pl->sprite_pos_screen[0], pl->sprite_pos_screen[1]);
		move_sprite(1, pl->sprite_pos_screen[0] + 8, pl->sprite_pos_screen[1]);
		perform_delay(1);

		// manage animation
		pl->frame_skip -= 1;
		if (!pl->frame_skip) {
			switch (pl->player_direction) {
				case PLAYER_DIRECTION_UP :
					set_sprite_prop(0, get_sprite_prop(0) | S_FLIPX);
					set_sprite_prop(1, get_sprite_prop(1) | S_FLIPX);
					set_sprite_tile(1, PLAYER_ANIMATION_UP[pl->sprite_animation_frame]);
					set_sprite_tile(0, PLAYER_ANIMATION_UP[pl->sprite_animation_frame] + 2);
					break;
				case PLAYER_DIRECTION_DOWN :
					set_sprite_prop(0, get_sprite_prop(0) | S_FLIPX);
					set_sprite_prop(1, get_sprite_prop(1) | S_FLIPX);
					set_sprite_tile(1, PLAYER_ANIMATION_DOWN[pl->sprite_animation_frame]);
					set_sprite_tile(0, PLAYER_ANIMATION_DOWN[pl->sprite_animation_frame] + 2);
					break;
				case PLAYER_DIRECTION_LEFT:
					set_sprite_prop(0, get_sprite_prop(0) | S_FLIPX);
					set_sprite_prop(1, get_sprite_prop(1) | S_FLIPX);
					set_sprite_tile(1, PLAYER_ANIMATION_SIDE[pl->sprite_animation_frame]);
					set_sprite_tile(0, PLAYER_ANIMATION_SIDE[pl->sprite_animation_frame] + 2);
					break;
				case PLAYER_DIRECTION_RIGHT:
					set_sprite_prop(0, get_sprite_prop(0) & ~S_FLIPX);
					set_sprite_prop(1, get_sprite_prop(1) & ~S_FLIPX);
					set_sprite_tile(0, PLAYER_ANIMATION_SIDE[pl->sprite_animation_frame]);
					set_sprite_tile(1, PLAYER_ANIMATION_SIDE[pl->sprite_animation_frame] + 2);
					break;
			}
			//can_player_move(0, 0, pl, cat, rmt);
			// to pass at the next sprite of the tileset
			pl->sprite_animation_frame = (pl->sprite_animation_frame + 1) % 4;
			pl->frame_skip = 6;
		}
	}
}

void	player_init(s *pl) {

	if (joypad() & J_UP) {
		pl->player_direction = PLAYER_DIRECTION_UP;		// init the direction according to the joypad
			move_player(0, -1, pl);						// increment or decrement the square of the grid where is the player,
	}												// here, -1 square on y;
	else if (joypad() & J_DOWN) {					// if chose if instead of else if: moving in diagonal
		pl->player_direction = PLAYER_DIRECTION_DOWN;
			move_player(0, +1, pl);
	}
	else if (joypad() & J_LEFT) {
		pl->player_direction = PLAYER_DIRECTION_LEFT;
			move_player(-1, 0, pl);
	}
	else if (joypad() & J_RIGHT) {
		pl->player_direction = PLAYER_DIRECTION_RIGHT;
			move_player(+1, 0, pl);
	}
/*	if (joypad() & J_A) {
		interact(pl);
	}*/
	
}