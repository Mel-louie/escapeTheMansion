# To do

:radio_button: to do; :ballot_box_with_check: OK; :exclamation: priority; :scissors: not a thing anymore<br><br><br>


:radio_button: hall with a scroll (! the player moves with the screen limits)<br>
:radio_button: after splash screen: cinematic<br>
:radio_button: faire un logo press A<br>
:radio_button: music stops when text A<br>
:exclamation::radio_button: animer la cuisine<br><br>

:ballot_box_with_check: corriger bug titlescreen<br>
:ballot_box_with_check: refacto notamment le feu qui est un sprite qui reste sur la map1<br>
:ballot_box_with_check: background collisions<br>
:ballot_box_with_check: moving camera: ok<br>
:ballot_box_with_check: after splash screen: credits<br>
:ballot_box_with_check: creat and update the readme with sound credits (gbt-player + the sound)<br>
:ballot_box_with_check: add a player<br>
:ballot_box_with_check: clean the directories<br>
:ballot_box_with_check: refaire la buche avec les rondins trouvés<br>

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

15 char/line

Optimizing For GBDK https://gbdev.io/guides/tools.html#optimizing-for-gbdk

    Global variables
    Use as many global variables as you can; the Game Boy has a lot of RAM compared to other platforms such as the NES, but is slow at using the stack. Thus, minimizing the number of local variables, especially in heavily-called functions, will reduce the time spent manipulating the stack.
    Optimized code
    Write code as efficient as possible. Sometimes there is a readability tradeoff, so I recommend you get the comment machine gun out and put some everywhere.
    By default GBDK-2020 (after v4.0.1) will use the SDCC flag --max-allocs-per-node 50000 for an increased optimization pass. You may also choose to use --opt-code-speed (optimize code generation towards fast code, possibly at the expense of codesize) or --opt-code-size (optimize code generation towards compact code, possibly at the expense of codespeed).
    Inlining
    When performance is important avoid using functions if you can inline them, which skips passing all arguments to the stack, mostly. Macros will be your friends there. If needed you can also use inline ASM.
    NEVER use recursive functions
    AVOID printf
    printf clobbers a sizeable chunk of VRAM with unnecessary text tiles. Instead, you should sprintf to a buffer in WRAM, then put that on the screen using a custom font.
    Geometry funcs
    Avoid the functions that draw geometry on-screen (lines, rectangles, etc.). The Game Boy isn't designed for this kind of drawing method, and you will have a hard time mixing this with, say, background art. Plus, the functions are super slow.
    const (very important!)
    Declaring a variable that doesn't change as const greatly reduces the amount of ROM, RAM, and CPU used.
    The technical reason behind that is that non-const values, especially arrays, are loaded to RAM from ROM in an extremely inefficient way. This takes up a LOT more ROM, and copies the value(s) to RAM when it's unneeded. (And the GB does not have enough RAM for that to be viable.)
    Don't use MBC1
    MBC1 is often assumed to be the simplest of all MBCs... but it has a quirk that adds some overhead every time ROM or SRAM bank switches are performed. MBC3 and MBC5 don't have this quirk, and don't add any complexity. Using MBC1 has no real use. (Let's not talk about MBC2, either.)