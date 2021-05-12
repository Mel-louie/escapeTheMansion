/*#+/+/+/+/+/+/+/+/+/+/+/+/+/#
#    Escape the Mansion  	 #
#						     #
#       ©H GRAY 2021    	 #
#+/+/+/+/+/+/+/+/+/+/+/+/+/#*/

#include "../include/game.h"

void		init_map(void) {
	//set the background
	set_bkg_data(0, TILESET_KITCHEN_TILE_COUNT, TILESET_KITCHEN);
	set_bkg_tiles(0, 0, TILEMAP_KITCHEN_WIDTH, TILEMAP_KITCHEN_HEIGHT, TILEMAP_KITCHEN);
	SHOW_BKG;
}