# To do

:radio_button: to do; :ballot_box_with_check: OK; :exclamation: priority; :scissors: not a thing anymore<br><br><br>

:radio_button: creat and update the readme with sound credits (gbt-player + the sound)<br>

:radio_button: hall with a scroll (! the player moves with the screen limits)<br>
:radio_button: add a player<br>
:radio_button: after splash screen: credit<br><br>
:radio_button: clean the directories<br><br>
:radio_button: refaire la buche avec les rondins trouvés<br><br>
:radio_button: animer sprite joueur<br><br>


<h3>:green_book:random notes</h3>
To have the right shades of color for a sprite (black, gray, white, and light gray transparent):<br>
	- draw with WHITE for transparence, and LIGHT GREY for white;<br>
	- convert to gb with img2gb ans this commande:<br>
	img2gb tileset \<br>
    --output-c-file=../src/tiles_player.c \<br>
    --output-header-file=../includes/tiles_player.h \<br>
    --output-image=./player.sprites.png \<br>
    --sprite8x16 \<br>
    --name PLAYER_SPRITES1 \<br>
    ./player1.png<br>
	- when init sprite, add this change fot default palettes: 'OBP0_REG = OBP1_REG = 0xe2';<br>
	- can test other combinason<br><br>

memo palette:
put the hexa values avoid to have 'warning 158: overflow in implicit constant conversion' which is not great

b 11
g 10
l 01
w 00

PALETTE(WHITE, LIGHTGR, GREY, BLACK) = 11100100 = 0xe4
PALETTE(LIGHTGR, GREY, BLACK, BLACK) = 11111001 = 0xf9
PALETTE(GREY, BLACK, BLACK, BLACK) = 11111110 = 0xfe
PALETTE(BLACK, BLACK, BLACK, BLACK) = 11111111 = 0xff

memo text:

19 char/line
