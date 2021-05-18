/*#+/+/+/+/+/+/+/+/+/+/+/+/+/#
#    Escape the Mansion  	 #
#						     #
#       ©H GRAY 2021    	 #
#+/+/+/+/+/+/+/+/+/+/+/+/+/#*/

#include "../include/game.h"

void	text_load_font(UINT8 code) {
	if (code == 0) {
		set_bkg_data(TEXT_OFFSET, FONT_COUNT, FONT_TILESET);
	}
	else if (code == 1) {
		set_bkg_data(TEXT_OFFSET, FONT_COUNT, FONT_TILESET_BLCK);
	}
	else if (code == 2) {
		set_bkg_data(TEXT_OFFSET, FONT_COUNT, FONT_BLCK);
	}
}

void	text_putchar_win(UINT8 x, UINT8 y, unsigned char c) {
	UINT16	tile = TEXT_CHAR_QS_MARK;

	if (c >= 'A' && c <= 'Z') {
		tile = TEXT_CHAR_A + c - 'A';
	}
	else if (c >= 'a' && c <= 'z') {
		tile = TEXT_CHAR_A + c - 'a';
	}
	else if (c >= '0' && c <= '9') {
		tile = TEXT_CHAR_0 + c - '0';
	}
	else {
		switch (c) {
			case ' ':
				tile = TEXT_CHAR_SPACE;
				break ;
			case '\'':
				tile = TEXT_CHAR_QUOTE;
				break ;
			case '-':
				tile = TEXT_CHAR_DASH;
				break ;
			case '.':
				tile = TEXT_CHAR_DOT;
				break ;
			case ',':
				tile = TEXT_CHAR_COMMA;
				break ;
			case ':':
				tile = TEXT_CHAR_DL_DOTS;
				break ;
			case ';':
				tile = TEXT_CHAR_SEMICOLON;
				break ;
			case '!':
				tile = TEXT_CHAR_EX_MARK;
				break ;
			case '(':
				tile = TEXT_CHAR_BRK_L;
				break ;
			case ')':
				tile = TEXT_CHAR_BRK_R;
				break ;
		}
	}
	set_win_tiles(x, y, 1, 1, &tile);
}

void	text_putstr_title(UINT8 x, UINT8 y, unsigned char *str) {
	UINT8 i = 0;
	UINT8 tmpX = x;
	UINT8 tmpY = y;

	while (str[i]) {
		if (str[i] == '\n') {
			tmpY++;
			tmpX = x;
		}
		else {
			text_putchar_win(tmpX, tmpY, str[i]);
			tmpX++;
		}
		i++;
	}
}

void	text_putstr_win(UINT8 x, UINT8 y, unsigned char *str) {
/*	UINT8 i = 0;
	UINT8 tmpX = x;
	UINT8 tmpY = y;

	while (str[i]) {
		if (str[i] == '\n') {
			tmpY++;
			tmpX = x;
		}
		else {
			text_putchar_win(tmpX, tmpY, str[i]);
			tmpX++;
		}
		i++;
	}*/
	UINT8 i = 0;
	UINT8 tmpX = x;
	UINT8 tmpY = y;
	UINT8 newline = 3;

	while (str[i]) {
		if (str[i] == '\n') {
			tmpY++;
			tmpX = x;
			newline--;
		}
		else {
			text_putchar_win(tmpX, tmpY, str[i]);
			tmpX++;
		}
		if (!newline) {
			while (!(joypad() & J_A))
				wait_vbl_done();
			clear_message();
			tmpX = 1;
			tmpY = 1;
			newline = 3;
		}
		i++;
		perform_delay(2);
	}

	while (!(joypad() & J_A))
		wait_vbl_done();
}
