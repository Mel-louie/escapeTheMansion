/*#+/+/+/+/+/+/+/+/+/+/+/+/+/#
#    Escape the Mansion  	 #
#						     #
#       ©H GRAY 2021    	 #
#+/+/+/+/+/+/+/+/+/+/+/+/+/#*/

#include "../include/game.h"

void	perform_delay(UINT8 time) {
	UINT8 i = 0;

	while (i++ < time) {
		wait_vbl_done();
		// Updates gbt-player, should be called every frame.
		gbt_update();
	}
}

UINT8	perform_delay_joypad(UINT8 time) {
	UINT8 i = 0;
	UINT8 keys = 0;

	while (i++ < time) {
		keys = joypad();
		if (keys == J_START || keys == J_A)
			return (keys);
		wait_vbl_done();
		// Updates gbt-player, should be called every frame.
		gbt_update();
	}
	return (0);
}