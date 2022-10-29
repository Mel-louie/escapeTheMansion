#*/*/*/*/*/*/*/*/*/*/*/*/*/#
#    Escape the Mansion    #
#						   #
#       ©H GRAY 2021       #
#*/*/*/*/*/*/*/*/*/*/*/*/*/#

SRC_DIR = ./src/

PROG = escapeTheMansion

################
#    COLORS    #
################

_BLACK		= "\033[30m"
_RED		= "\033[31m"
_GREEN		= "\033[32m"
_YELLOW		= "\033[33m"
_BLUE		= "\033[34m"
_VIOLET		= "\033[35m"
_CYAN		= "\033[36m"
_WHITE		= "\033[37m"
_END		= "\033[0m"

################
#   TARGETS    #
################

all:
#	@cp musics/mod2gbt . 
#	@./mod2gbt musics/mainTheme.mod song 2
#	@rm mod2gbt

	@echo $(_BLUE)"Building ... "$(_YELLOW)

	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o main.o src/main.c
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o s_fire.o src/s_fire.c
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o s_player.o src/s_player.c
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o game.o src/game.c
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o player.o src/player.c
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o kitchen.o src/kitchen.c
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o maps.o src/maps.c
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o sprites.o src/sprites.c
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o screens.o src/screens.c
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o utils.o src/utils.c
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o texts.o src/texts.c
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o titleScreen.o src/titleScreen.c
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o font.o src/font.c
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o splashscreen.o src/splashscreen.c
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o credits.o src/credits.c
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o interactions.o src/interactions.c
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o messages.o src/messages.c

# to compil with gbt-player, output.c created by mod2gbt
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o  output.o output.c
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o gbt_player.o musics/gbt_player.s
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o gbt_player_bank1.o musics/gbt_player_bank1.s

# compilation, work fine even if a wild warning 115 appears
	@./gbdk2020-3.1/bin/lcc -Wa-l -Wm-yc -Wl-m -Wl-j -o escapeTheMansion.gb main.o splashscreen.o font.o titleScreen.o screens.o utils.o texts.o output.o gbt_player.o gbt_player_bank1.o sprites.o maps.o kitchen.o game.o s_fire.o s_player.o credits.o player.o interactions.o messages.o

	@cp escapeTheMansion.gb escapeTheMansion-HTML/rom/game.gb
	@echo $(_GREEN)"Done!"$(_END)

clean:
	@echo $(_RED)"Cleaning in progress..."$(_END)
	@rm -rf escapeTheMansion.map escapeTheMansion.noi
	@rm -rf *.o *.lst *.sym *.asm *.ihx
	@echo $(_GREEN)"Cleaning done!"$(_END)
#	@make clean -C $(SRC_DIR)

fclean:	clean
	@rm -rf escapeTheMansion.gb
	@echo $(_GREEN)"escapeTheMansion.gb is delete!"$(_END)

re: clean all
