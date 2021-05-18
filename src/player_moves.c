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
#define PLAYER_DIRECTION_DOWN	0
#define PLAYER_DIRECTION_UP		1
#define PLAYER_DIRECTION_RIGHT	2
#define PLAYER_DIRECTION_LEFT	3

// datas to animate the player
UINT8 PLAYER_ANIMATION_SIDE[] = {24, 28, 24, 32};
UINT8 PLAYER_ANIMATION_UP[] = {12, 16, 12, 20};
UINT8 PLAYER_ANIMATION_DOWN[] = {0, 4, 0, 8};

UINT8 bkg_XPosition = 0;
UINT8 bkg_YPosition = 0;

/* @UINT8	can_player_move(INT8 dx, INT8 dy);	 */
/*												 */
/* number of sec before refresh the sreen, if not*/
/* , the moves will be too quick				 */
/* time: can adjust for hoz much loop it can be  */
/* slow; 										 */

UINT8	can_player_move(INT8 dx, INT8 dy, s *pl) {

	UINT8 cx = (pl->sprite_pos_world[0] + dx) - 1;
	UINT8 cy = (pl->sprite_pos_world[1] + dy) - 1;	// -1 or +1, it's a problem, we step on the left side of the furnitures
	UINT8 tile;

// don't exit the screen
// ! it's not in pixel, but in square of the grid, one by one
	if ((pl->sprite_pos_world[0] + dx < 1) ||
		(pl->sprite_pos_world[0] + dx == 36) ||
		(pl->sprite_pos_world[1] + dy < 2) ||
		(pl->sprite_pos_world[1] + dy == 34))
		return (0);

	get_bkg_tiles(cx, cy, 1, 1, &tile);

// return a tile where the player can walk
	return (tile == 0x2E || tile == 0x2F);
//	return (1);
}


void	move_player(INT8 dx, INT8 dy, s *pl, s *fire) {

	UBYTE flag = 0;
	if (!can_player_move(dx, dy, pl))
		flag = 1;

	// init the new position of the player by adding the value of the move_player()
	// if !flag, collision so no new pos but movement still
	if (!flag) {
		pl->sprite_pos_world[0] += dx;
		pl->sprite_pos_world[1] += dy;
	}

	for (UINT8 delta = 8 ; delta ; delta--) {	// moving 8 squares by 8 squares, maybe change in 16x16

		if (!flag) {
		//move camera x
			if ((bkg_XPosition && dx == -1 && pl->sprite_pos_screen[0] == 2 * 8) ||
			(bkg_XPosition < (16 - 10) * 16 && dx == 1 && pl->sprite_pos_screen[0] == 8 * 16)) {
				bkg_XPosition += dx * 124;
				move_bkg(bkg_XPosition, 0);
				dx += dx *16;
			}
		//move camera y
			if ((bkg_YPosition && dy == -1 && pl->sprite_pos_screen[1] == 2 * 8) ||
			(bkg_YPosition < (16 - 10) * 16 && dy == 1 && pl->sprite_pos_screen[1] == 8 * 16)) {
				bkg_YPosition += dy * 124;
				move_bkg(0, bkg_YPosition);
				dy += dy *16;
			}

		// move player
			pl->sprite_pos_screen[0] += dx ;
			pl->sprite_pos_screen[1] += dy;

			move_sprite(0, pl->sprite_pos_screen[0] , pl->sprite_pos_screen[1]);
			move_sprite(1, pl->sprite_pos_screen[0] + 8, pl->sprite_pos_screen[1]);}
			anim_fire(fire);
		//	wait_vbl_done();

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
			can_player_move(0, 0, pl);
			// to pass at the next sprite of the tileset
			pl->sprite_animation_frame = (pl->sprite_animation_frame + 1) % 4;
			pl->frame_skip = 6;
		}
	}
}

void	player_init(s *pl, s *fire) {

	if (joypad() & J_UP) {
		pl->player_direction = PLAYER_DIRECTION_UP;	// init the direction according to the joypad
			move_player(0, -1, pl, fire);			// increment or decrement the square of the grid where is the player,
	}												// here, -1 square on y;
	else if (joypad() & J_DOWN) {					// if chose if instead of else if: moving in diagonal
		pl->player_direction = PLAYER_DIRECTION_DOWN;
			move_player(0, +1, pl, fire);
	}
	else if (joypad() & J_LEFT) {
		pl->player_direction = PLAYER_DIRECTION_LEFT;
			move_player(-1, 0, pl, fire);
	}
	else if (joypad() & J_RIGHT) {
		pl->player_direction = PLAYER_DIRECTION_RIGHT;
			move_player(+1, 0, pl, fire);
	}
	else {
		anim_fire(fire);
	}
}