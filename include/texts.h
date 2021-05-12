/*#+/+/+/+/+/+/+/+/+/+/+/+/+/#
#    Escape the Mansion  	 #
#						     #
#       ©H GRAY 2021    	 #
#+/+/+/+/+/+/+/+/+/+/+/+/+/+#*/

#ifndef _TEXT_H
# define _TEXT_H

#include "game.h"

/*
** FONTS CODES
*/
# define TEXT_OFFSET			0xd0
# define TEXT_CHAR_A			TEXT_OFFSET
# define TEXT_CHAR_0			TEXT_OFFSET + 26
# define TEXT_CHAR_QUOTE		TEXT_OFFSET + 26 + 10 + 0
# define TEXT_CHAR_DASH			TEXT_OFFSET + 26 + 10 + 1
# define TEXT_CHAR_DOT			TEXT_OFFSET + 26 + 10 + 2
# define TEXT_CHAR_COMMA		TEXT_OFFSET + 26 + 10 + 3
# define TEXT_CHAR_DL_DOTS		TEXT_OFFSET + 26 + 10 + 4
# define TEXT_CHAR_SEMICOLON	TEXT_OFFSET + 26 + 10 + 5
# define TEXT_CHAR_EX_MARK		TEXT_OFFSET + 26 + 10 + 6
# define TEXT_CHAR_QS_MARK		TEXT_OFFSET + 26 + 10 + 7
# define TEXT_CHAR_BRK_L		TEXT_OFFSET + 26 + 10 + 8
# define TEXT_CHAR_BRK_R		TEXT_OFFSET + 26 + 10 + 9
# define TEXT_CHAR_BORDER		TEXT_OFFSET + 26 + 10 + 10
# define TEXT_CHAR_SPACE		TEXT_OFFSET + 26 + 10 + 11


void	text_load_font(UINT8 code);
void	text_putchar_win(UINT8 x, UINT8 y, unsigned char c); // pass char to window
void	text_putstr_win(UINT8 x, UINT8 y, unsigned char *str);

#endif