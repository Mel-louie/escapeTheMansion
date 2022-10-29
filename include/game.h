/*#+/+/+/+/+/+/+/+/+/+/+/+/+/#
#    Escape the Mansion  	 #
#						     #
#       ©H GRAY 2021    	 #
#+/+/+/+/+/+/+/+/+/+/+/+/+/+#*/

#ifndef GAME_H
# define GAME_H

#include "../gbdk2020-3.1/include/gb/gb.h"
#include "../gbdk2020-3.1/include/gb/cgb.h"
#include "../gbdk2020-3.1/include/stdio.h"

#include "../musics/gbt_player.h"

#include "texts.h"
#include "font.h"
#include "titleScreen.h"
#include "splashscreen.h"
#include "credits.h"
#include "kitchen.h"

#include "fire.h"
#include "player.h"

// sprite's sate
typedef struct	sprites
{
	UINT8	sprite_pos_screen[2];
	UINT8	sprite_pos_world[2];
	UINT8	player_direction;
	UINT8	sprite_animation_frame;
	UINT8	frame_skip;
	UBYTE	o;
	UBYTE	animX;
	UBYTE	animY;
}				s;

// Values must be in the range 0-31! For example, CGB_PAL(31, 31, 31) is white, CGB_PAL(0, 0, 0) is black, and CGB_PAL(0, 31, 0) is green
#define	CGB_PAL(r, g, b) (((b) & 31) << 10 | ((g) & 31) << 5 | ((r) & 31))

void	title_screen(void);
void	splash_screen(void);
void	clear_title_screen(void);


/* @void	perform_delay_player(UINT8 time);	 */
/*												 */
/* number of sec before refresh the sreen, if not*/
/* , the moves will be too quick				 */
/* time: can adjust for how much loop it can be  */
/* slow; 										 */
void	perform_delay(UINT8 time);

/* @UINT8	perform_delay_(UINT8 time);			 */
/*												 */
/* number of sec OR a touch key before refresh	 */
/* the sreen, if not							 */			
/* , the moves will be too quick				 */
/* time: can adjust for how much loop it can be  */
/* slow; 										 */
UINT8	perform_delay_joypad(UINT8 time);


/* @void	init_game(void);		  */
/*									  */
/* initialize 1st map ans sprites	  */
void	init_game(s *fire);

/* @void	init_map(s *fire);		  */
/*									  */
/* initialize the 1st map of the game */
void	init_map(s *fire);

/* @void	game(void);				  */
/*									  */
/* engine, serious stuffs begin here  */
void	game(s *fire, s *pl);

void	init_sprites(s *fire, s* pl);
void	player_init(s *pl, s *fire);
void	anim_fire(s *fire);
void	interact(s *pl, s *fire);
void	show_message(unsigned char *str, UINT8 player_x, UINT8 player_y);
void	clear_message(void);
void	clear_message(void);

#endif