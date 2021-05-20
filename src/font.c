/*#+/+/+/+/+/+/+/+/+/+/+/+/+/#
#    Escape the Mansion  	 #
#						     #
#       ©H GRAY 2021    	 #
#+/+/+/+/+/+/+/+/+/+/+/+/+/#*/

#include "../include/game.h"

const UINT8 FONT_TILESET[] = {
    0x04, 0x04, 0x0C, 0x0C, 0x14, 0x14, 0x14, 0x14, 0x24, 0x24, 0x3C, 0x3C, 0x24, 0x24, 0x24, 0x24,
    0x1C, 0x1C, 0x12, 0x12, 0x22, 0x22, 0x2C, 0x2C, 0x22, 0x22, 0x22, 0x22, 0x24, 0x24, 0x18, 0x18,
    0x0C, 0x0C, 0x12, 0x12, 0x10, 0x10, 0x20, 0x20, 0x20, 0x20, 0x22, 0x22, 0x24, 0x24, 0x18, 0x18,
    0x18, 0x18, 0x14, 0x14, 0x12, 0x12, 0x22, 0x22, 0x22, 0x22, 0x24, 0x24, 0x28, 0x28, 0x30, 0x30,
    0x0E, 0x0E, 0x10, 0x10, 0x20, 0x20, 0x2C, 0x2C, 0x30, 0x30, 0x20, 0x20, 0x20, 0x20, 0x1C, 0x1C,
    0x0E, 0x0E, 0x10, 0x10, 0x20, 0x20, 0x2C, 0x2C, 0x30, 0x30, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
    0x0C, 0x0C, 0x12, 0x12, 0x20, 0x20, 0x26, 0x26, 0x2A, 0x2A, 0x22, 0x22, 0x24, 0x24, 0x18, 0x18,
    0x12, 0x12, 0x12, 0x12, 0x22, 0x22, 0x2E, 0x2E, 0x32, 0x32, 0x22, 0x22, 0x24, 0x24, 0x24, 0x24,
    0x1C, 0x1C, 0x08, 0x08, 0x08, 0x08, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x38, 0x38,
    0x0E, 0x0E, 0x02, 0x02, 0x02, 0x02, 0x04, 0x04, 0x04, 0x04, 0x24, 0x24, 0x24, 0x24, 0x18, 0x18,
    0x12, 0x12, 0x24, 0x24, 0x24, 0x24, 0x28, 0x28, 0x28, 0x28, 0x30, 0x30, 0x28, 0x28, 0x24, 0x24,
    0x08, 0x08, 0x10, 0x10, 0x10, 0x10, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x1C, 0x1C,
    0x16, 0x16, 0x29, 0x29, 0x29, 0x29, 0x49, 0x49, 0x49, 0x49, 0x49, 0x49, 0x41, 0x41, 0x42, 0x42,
    0x11, 0x11, 0x29, 0x29, 0x29, 0x29, 0x29, 0x29, 0x49, 0x49, 0x45, 0x45, 0x45, 0x45, 0x42, 0x42,
    0x0C, 0x0C, 0x12, 0x12, 0x12, 0x12, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x24, 0x24, 0x18, 0x18,
    0x0C, 0x0C, 0x12, 0x12, 0x22, 0x22, 0x24, 0x24, 0x38, 0x38, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
    0x0C, 0x0C, 0x12, 0x12, 0x12, 0x12, 0x22, 0x22, 0x22, 0x22, 0x2A, 0x2A, 0x24, 0x24, 0x1A, 0x1A,
    0x0C, 0x0C, 0x12, 0x12, 0x12, 0x12, 0x22, 0x22, 0x24, 0x24, 0x38, 0x38, 0x28, 0x28, 0x24, 0x24,
    0x04, 0x04, 0x0A, 0x0A, 0x10, 0x10, 0x08, 0x08, 0x04, 0x04, 0x04, 0x04, 0x48, 0x48, 0x30, 0x30,
    0x3E, 0x3E, 0x08, 0x08, 0x08, 0x08, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10,
    0x12, 0x12, 0x12, 0x12, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x24, 0x24, 0x18, 0x18,
    0x12, 0x12, 0x12, 0x12, 0x24, 0x24, 0x24, 0x24, 0x28, 0x28, 0x28, 0x28, 0x30, 0x30, 0x20, 0x20,
    0x11, 0x11, 0x21, 0x21, 0x41, 0x41, 0x41, 0x41, 0x49, 0x49, 0x49, 0x49, 0x55, 0x55, 0x22, 0x22,
    0x22, 0x22, 0x14, 0x14, 0x14, 0x14, 0x08, 0x08, 0x10, 0x10, 0x28, 0x28, 0x48, 0x48, 0x46, 0x46,
    0x22, 0x22, 0x22, 0x22, 0x24, 0x24, 0x28, 0x28, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10,
    0x1C, 0x1C, 0x22, 0x22, 0x04, 0x04, 0x08, 0x08, 0x08, 0x08, 0x10, 0x10, 0x22, 0x22, 0x1C, 0x1C,
    0x0C, 0x0C, 0x12, 0x12, 0x32, 0x32, 0x22, 0x22, 0x52, 0x52, 0x4A, 0x4A, 0x44, 0x44, 0x38, 0x38,
    0x0C, 0x0C, 0x14, 0x14, 0x04, 0x04, 0x08, 0x08, 0x08, 0x08, 0x10, 0x10, 0x10, 0x10, 0x38, 0x38,
    0x0C, 0x0C, 0x12, 0x12, 0x22, 0x22, 0x04, 0x04, 0x18, 0x18, 0x20, 0x20, 0x42, 0x42, 0x7C, 0x7C,
    0x0C, 0x0C, 0x12, 0x12, 0x22, 0x22, 0x0C, 0x0C, 0x02, 0x02, 0x02, 0x02, 0x44, 0x44, 0x38, 0x38,
    0x04, 0x04, 0x0A, 0x0A, 0x12, 0x12, 0x22, 0x22, 0x44, 0x44, 0x48, 0x48, 0x3E, 0x3E, 0x08, 0x08,
    0x1E, 0x1E, 0x20, 0x20, 0x40, 0x40, 0x58, 0x58, 0x24, 0x24, 0x02, 0x02, 0x42, 0x42, 0x3C, 0x3C,
    0x0C, 0x0C, 0x12, 0x12, 0x20, 0x20, 0x5C, 0x5C, 0x62, 0x62, 0x42, 0x42, 0x44, 0x44, 0x38, 0x38,
    0x1C, 0x1C, 0x22, 0x22, 0x42, 0x42, 0x04, 0x04, 0x08, 0x08, 0x10, 0x10, 0x20, 0x20, 0x20, 0x20,
    0x0C, 0x0C, 0x12, 0x12, 0x24, 0x24, 0x18, 0x18, 0x24, 0x24, 0x42, 0x42, 0x42, 0x42, 0x3C, 0x3C,
    0x0C, 0x0C, 0x12, 0x12, 0x22, 0x22, 0x26, 0x26, 0x1A, 0x1A, 0x02, 0x02, 0x44, 0x44, 0x38, 0x38,
    0x00, 0x00, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3C, 0x3C, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x18, 0x18, 0x18, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x18, 0x18, 0x18, 0x10, 0x10,
    0x00, 0x00, 0x00, 0x00, 0x18, 0x18, 0x18, 0x18, 0x00, 0x00, 0x18, 0x18, 0x18, 0x18, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x18, 0x18, 0x18, 0x18, 0x00, 0x00, 0x18, 0x18, 0x18, 0x18, 0x10, 0x10,
    0x04, 0x04, 0x04, 0x04, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00, 0x18, 0x18, 0x00, 0x00,
    0x0C, 0x0C, 0x12, 0x12, 0x02, 0x02, 0x04, 0x04, 0x08, 0x08, 0x00, 0x00, 0x18, 0x18, 0x00, 0x00,
    0x08, 0x08, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x08, 0x08,
    0x10, 0x10, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x10, 0x10,
    0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
};

const UINT8 FONT_TILESET_BLCK[] = {
	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xC7, 0xC7, 0xBB, 0xBB, 0xBB, 0xBB, 0x83, 0x83, 0xBB, 0xBB,
    0xFF, 0xFF, 0x83, 0x83, 0x99, 0x99, 0x83, 0x83, 0x99, 0x99, 0x99, 0x99, 0x83, 0x83, 0xFF, 0xFF,
    0xFF, 0xFF, 0xC3, 0xC3, 0x99, 0x99, 0x9F, 0x9F, 0x9F, 0x9F, 0x99, 0x99, 0xC3, 0xC3, 0xFF, 0xFF,
    0xFF, 0xFF, 0x83, 0x83, 0xB1, 0xB1, 0xB1, 0xB1, 0xB1, 0xB1, 0xB1, 0xB1, 0x83, 0x83, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x83, 0x83, 0xBF, 0xBF, 0x87, 0x87, 0xBF, 0xBF, 0x83, 0x83,
    0xFF, 0xFF, 0x81, 0x81, 0x9F, 0x9F, 0x9F, 0x9F, 0x83, 0x83, 0x9F, 0x9F, 0x9F, 0x9F, 0xFF, 0xFF,
    0xFF, 0xFF, 0xC3, 0xC3, 0x99, 0x99, 0x9F, 0x9F, 0x91, 0x91, 0x99, 0x99, 0xC1, 0xC1, 0xFF, 0xFF,
    0xFF, 0xFF, 0xB9, 0xB9, 0xB9, 0xB9, 0x81, 0x81, 0xB9, 0xB9, 0xB9, 0xB9, 0xB9, 0xB9, 0xFF, 0xFF,
    0xFF, 0xFF, 0xC3, 0xC3, 0xE7, 0xE7, 0xE7, 0xE7, 0xE7, 0xE7, 0xE7, 0xE7, 0xC3, 0xC3, 0xFF, 0xFF,
    0xFF, 0xFF, 0xE1, 0xE1, 0xF3, 0xF3, 0xF3, 0xF3, 0x93, 0x93, 0x93, 0x93, 0xC7, 0xC7, 0xFF, 0xFF,
    0xFF, 0xFF, 0x99, 0x99, 0x93, 0x93, 0x87, 0x87, 0x87, 0x87, 0x93, 0x93, 0x99, 0x99, 0xFF, 0xFF,
    0xFF, 0xFF, 0x9F, 0x9F, 0x9F, 0x9F, 0x9F, 0x9F, 0x9F, 0x9F, 0x9F, 0x9F, 0x81, 0x81, 0xFF, 0xFF,
    0xFF, 0xFF, 0xB9, 0xB9, 0x91, 0x91, 0x81, 0x81, 0xA9, 0xA9, 0xB9, 0xB9, 0xB9, 0xB9, 0xFF, 0xFF,
    0xFF, 0xFF, 0xB9, 0xB9, 0x99, 0x99, 0x89, 0x89, 0xA1, 0xA1, 0xB1, 0xB1, 0xB9, 0xB9, 0xFF, 0xFF,
    0xFF, 0xFF, 0xC3, 0xC3, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0xC3, 0xC3, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x87, 0x87, 0xBB, 0xBB, 0xBB, 0xBB, 0x87, 0x87, 0xBF, 0xBF,
    0xFF, 0xFF, 0xC3, 0xC3, 0x9D, 0x9D, 0x9D, 0x9D, 0x95, 0x95, 0x9B, 0x9B, 0xC5, 0xC5, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x87, 0x87, 0xBB, 0xBB, 0xBB, 0xBB, 0x87, 0x87, 0xBB, 0xBB,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x87, 0x87, 0xBF, 0xBF, 0x87, 0x87, 0xF7, 0xF7, 0x87, 0x87,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x83, 0x83, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF,
    0xFF, 0xFF, 0xB9, 0xB9, 0xB9, 0xB9, 0xB9, 0xB9, 0xB9, 0xB9, 0xB1, 0xB1, 0xC3, 0xC3, 0xFF, 0xFF,
    0xFF, 0xFF, 0xB9, 0xB9, 0xB9, 0xB9, 0xB9, 0xB9, 0xB9, 0xB9, 0xD3, 0xD3, 0xE7, 0xE7, 0xFF, 0xFF,
    0xFF, 0xFF, 0xB9, 0xB9, 0xB9, 0xB9, 0xA9, 0xA9, 0x81, 0x81, 0x91, 0x91, 0xB9, 0xB9, 0xFF, 0xFF,
    0xFF, 0xFF, 0xB9, 0xB9, 0xD3, 0xD3, 0xE7, 0xE7, 0xC7, 0xC7, 0x9B, 0x9B, 0xBD, 0xBD, 0xFF, 0xFF,
    0xFF, 0xFF, 0x99, 0x99, 0x99, 0x99, 0xC3, 0xC3, 0xE7, 0xE7, 0xE7, 0xE7, 0xE7, 0xE7, 0xFF, 0xFF,
    0xFF, 0xFF, 0x81, 0x81, 0xF1, 0xF1, 0xE3, 0xE3, 0xC7, 0xC7, 0x8F, 0x8F, 0x81, 0x81, 0xFF, 0xFF,
    0xFF, 0xFF, 0xC1, 0xC1, 0x98, 0x98, 0x94, 0x94, 0x94, 0x94, 0x8C, 0x8C, 0xC1, 0xC1, 0xFF, 0xFF,
    0xFF, 0xFF, 0xE7, 0xE7, 0xC7, 0xC7, 0xE7, 0xE7, 0xE7, 0xE7, 0xE7, 0xE7, 0xC3, 0xC3, 0xFF, 0xFF,
    0xFF, 0xFF, 0xC3, 0xC3, 0xB1, 0xB1, 0xF1, 0xF1, 0xC3, 0xC3, 0x8F, 0x8F, 0x81, 0x81, 0xFF, 0xFF,
    0xFF, 0xFF, 0x83, 0x83, 0xF1, 0xF1, 0xC3, 0xC3, 0xF1, 0xF1, 0xF1, 0xF1, 0x83, 0x83, 0xFF, 0xFF,
    0xFF, 0xFF, 0xC3, 0xC3, 0x93, 0x93, 0xB3, 0xB3, 0xB3, 0xB3, 0x81, 0x81, 0xF3, 0xF3, 0xFF, 0xFF,
    0xFF, 0xFF, 0x83, 0x83, 0x9F, 0x9F, 0x83, 0x83, 0xF1, 0xF1, 0xB1, 0xB1, 0xC3, 0xC3, 0xFF, 0xFF,
    0xFF, 0xFF, 0xC3, 0xC3, 0x9F, 0x9F, 0x83, 0x83, 0x99, 0x99, 0x99, 0x99, 0xC3, 0xC3, 0xFF, 0xFF,
    0xFF, 0xFF, 0x81, 0x81, 0xF9, 0xF9, 0xF3, 0xF3, 0xE7, 0xE7, 0xC7, 0xC7, 0xC7, 0xC7, 0xFF, 0xFF,
    0xFF, 0xFF, 0xC3, 0xC3, 0xB1, 0xB1, 0xC3, 0xC3, 0xB1, 0xB1, 0xB1, 0xB1, 0xC3, 0xC3, 0xFF, 0xFF,
    0xFF, 0xFF, 0xC3, 0xC3, 0xB1, 0xB1, 0xB1, 0xB1, 0xC1, 0xC1, 0xF1, 0xF1, 0xC3, 0xC3, 0xFF, 0xFF,
    0xE7, 0xE7, 0xE7, 0xE7, 0xF7, 0xF7, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xC3, 0xC3, 0xC3, 0xC3, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x9F, 0x9F, 0x9F, 0x9F, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xCF, 0xCF, 0xCF, 0xCF, 0xEF, 0xEF, 0xDF, 0xDF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xCF, 0xCF, 0xCF, 0xCF, 0xFF, 0xFF, 0xCF, 0xCF, 0xCF, 0xCF, 0xFF, 0xFF,
    0xFF, 0xFF, 0xCF, 0xCF, 0xCF, 0xCF, 0xFF, 0xFF, 0xCF, 0xCF, 0xCF, 0xCF, 0xEF, 0xEF, 0xDF, 0xDF,
    0xFF, 0xFF, 0xE3, 0xE3, 0xE3, 0xE3, 0xE3, 0xE3, 0xE3, 0xE3, 0xFF, 0xFF, 0xE3, 0xE3, 0xFF, 0xFF,
    0xFF, 0xFF, 0xC3, 0xC3, 0xB1, 0xB1, 0xF1, 0xF1, 0xE3, 0xE3, 0xE7, 0xE7, 0xFF, 0xFF, 0xE7, 0xE7,
    0xF3, 0xF3, 0xE7, 0xE7, 0xCF, 0xCF, 0x8F, 0x8F, 0x8F, 0x8F, 0xCF, 0xCF, 0xE7, 0xE7, 0xF3, 0xF3,
    0xCF, 0xCF, 0xE7, 0xE7, 0xF3, 0xF3, 0xF1, 0xF1, 0xF1, 0xF1, 0xF3, 0xF3, 0xE7, 0xE7, 0xCF, 0xCF,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
};

const UINT8 FONT_BLCK[] = {
    0xFB, 0xFB, 0xF3, 0xF3, 0xEB, 0xEB, 0xEB, 0xEB, 0xDB, 0xDB, 0xC3, 0xC3, 0xDB, 0xDB, 0xDB, 0xDB,
    0xE3, 0xE3, 0xED, 0xED, 0xDD, 0xDD, 0xD3, 0xD3, 0xDD, 0xDD, 0xDD, 0xDD, 0xDB, 0xDB, 0xE7, 0xE7,
    0xF3, 0xF3, 0xED, 0xED, 0xEF, 0xEF, 0xDF, 0xDF, 0xDF, 0xDF, 0xDD, 0xDD, 0xDB, 0xDB, 0xE7, 0xE7,
    0xE7, 0xE7, 0xEB, 0xEB, 0xED, 0xED, 0xDD, 0xDD, 0xDD, 0xDD, 0xDB, 0xDB, 0xD7, 0xD7, 0xCF, 0xCF,
    0xF1, 0xF1, 0xEF, 0xEF, 0xDF, 0xDF, 0xD3, 0xD3, 0xCF, 0xCF, 0xDF, 0xDF, 0xDF, 0xDF, 0xE3, 0xE3,
    0xF1, 0xF1, 0xEF, 0xEF, 0xDF, 0xDF, 0xD3, 0xD3, 0xCF, 0xCF, 0xDF, 0xDF, 0xDF, 0xDF, 0xDF, 0xDF,
    0xF3, 0xF3, 0xED, 0xED, 0xDF, 0xDF, 0xD9, 0xD9, 0xD5, 0xD5, 0xDD, 0xDD, 0xDB, 0xDB, 0xE7, 0xE7,
    0xED, 0xED, 0xED, 0xED, 0xDD, 0xDD, 0xD1, 0xD1, 0xCD, 0xCD, 0xDD, 0xDD, 0xDB, 0xDB, 0xDB, 0xDB,
    0xE3, 0xE3, 0xF7, 0xF7, 0xF7, 0xF7, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xC7, 0xC7,
    0xF1, 0xF1, 0xFD, 0xFD, 0xFD, 0xFD, 0xFB, 0xFB, 0xFB, 0xFB, 0xDB, 0xDB, 0xDB, 0xDB, 0xE7, 0xE7,
    0xED, 0xED, 0xDB, 0xDB, 0xDB, 0xDB, 0xD7, 0xD7, 0xD7, 0xD7, 0xCF, 0xCF, 0xD7, 0xD7, 0xDB, 0xDB,
    0xF7, 0xF7, 0xEF, 0xEF, 0xEF, 0xEF, 0xDF, 0xDF, 0xDF, 0xDF, 0xDF, 0xDF, 0xDF, 0xDF, 0xE3, 0xE3,
    0xE9, 0xE9, 0xD6, 0xD6, 0xD6, 0xD6, 0xB6, 0xB6, 0xB6, 0xB6, 0xB6, 0xB6, 0xBE, 0xBE, 0xBD, 0xBD,
    0xEE, 0xEE, 0xD6, 0xD6, 0xD6, 0xD6, 0xD6, 0xD6, 0xB6, 0xB6, 0xBA, 0xBA, 0xBA, 0xBA, 0xBD, 0xBD,
    0xF3, 0xF3, 0xED, 0xED, 0xED, 0xED, 0xDD, 0xDD, 0xDD, 0xDD, 0xDD, 0xDD, 0xDB, 0xDB, 0xE7, 0xE7,
    0xF3, 0xF3, 0xED, 0xED, 0xDD, 0xDD, 0xDB, 0xDB, 0xC7, 0xC7, 0xDF, 0xDF, 0xDF, 0xDF, 0xDF, 0xDF,
    0xF3, 0xF3, 0xED, 0xED, 0xED, 0xED, 0xDD, 0xDD, 0xDD, 0xDD, 0xD5, 0xD5, 0xDB, 0xDB, 0xE5, 0xE5,
    0xF3, 0xF3, 0xED, 0xED, 0xED, 0xED, 0xDD, 0xDD, 0xDB, 0xDB, 0xC7, 0xC7, 0xD7, 0xD7, 0xDB, 0xDB,
    0xFB, 0xFB, 0xF5, 0xF5, 0xEF, 0xEF, 0xF7, 0xF7, 0xFB, 0xFB, 0xFB, 0xFB, 0xB7, 0xB7, 0xCF, 0xCF,
    0xC1, 0xC1, 0xF7, 0xF7, 0xF7, 0xF7, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF,
    0xED, 0xED, 0xED, 0xED, 0xDD, 0xDD, 0xDD, 0xDD, 0xDD, 0xDD, 0xDD, 0xDD, 0xDB, 0xDB, 0xE7, 0xE7,
    0xED, 0xED, 0xED, 0xED, 0xDB, 0xDB, 0xDB, 0xDB, 0xD7, 0xD7, 0xD7, 0xD7, 0xCF, 0xCF, 0xDF, 0xDF,
    0xEE, 0xEE, 0xDE, 0xDE, 0xBE, 0xBE, 0xBE, 0xBE, 0xB6, 0xB6, 0xB6, 0xB6, 0xAA, 0xAA, 0xDD, 0xDD,
    0xDD, 0xDD, 0xEB, 0xEB, 0xEB, 0xEB, 0xF7, 0xF7, 0xEF, 0xEF, 0xD7, 0xD7, 0xB7, 0xB7, 0xB9, 0xB9,
    0xDD, 0xDD, 0xDD, 0xDD, 0xDB, 0xDB, 0xD7, 0xD7, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF,
    0xE3, 0xE3, 0xDD, 0xDD, 0xFB, 0xFB, 0xF7, 0xF7, 0xF7, 0xF7, 0xEF, 0xEF, 0xDD, 0xDD, 0xE3, 0xE3,
    0xF3, 0xF3, 0xED, 0xED, 0xCD, 0xCD, 0xDD, 0xDD, 0xAD, 0xAD, 0xB5, 0xB5, 0xBB, 0xBB, 0xC7, 0xC7,
    0xF3, 0xF3, 0xEB, 0xEB, 0xFB, 0xFB, 0xF7, 0xF7, 0xF7, 0xF7, 0xEF, 0xEF, 0xEF, 0xEF, 0xC7, 0xC7,
    0xF3, 0xF3, 0xED, 0xED, 0xDD, 0xDD, 0xFB, 0xFB, 0xE7, 0xE7, 0xDF, 0xDF, 0xBD, 0xBD, 0x83, 0x83,
    0xF3, 0xF3, 0xED, 0xED, 0xDD, 0xDD, 0xF3, 0xF3, 0xFD, 0xFD, 0xFD, 0xFD, 0xBB, 0xBB, 0xC7, 0xC7,
    0xFB, 0xFB, 0xF5, 0xF5, 0xED, 0xED, 0xDD, 0xDD, 0xBB, 0xBB, 0xB7, 0xB7, 0xC1, 0xC1, 0xF7, 0xF7,
    0xE1, 0xE1, 0xDF, 0xDF, 0xBF, 0xBF, 0xA7, 0xA7, 0xDB, 0xDB, 0xFD, 0xFD, 0xBD, 0xBD, 0xC3, 0xC3,
    0xF3, 0xF3, 0xED, 0xED, 0xDF, 0xDF, 0xA3, 0xA3, 0x9D, 0x9D, 0xBD, 0xBD, 0xBB, 0xBB, 0xC7, 0xC7,
    0xE3, 0xE3, 0xDD, 0xDD, 0xBD, 0xBD, 0xFB, 0xFB, 0xF7, 0xF7, 0xEF, 0xEF, 0xDF, 0xDF, 0xDF, 0xDF,
    0xF3, 0xF3, 0xED, 0xED, 0xDB, 0xDB, 0xE7, 0xE7, 0xDB, 0xDB, 0xBD, 0xBD, 0xBD, 0xBD, 0xC3, 0xC3,
    0xF3, 0xF3, 0xED, 0xED, 0xDD, 0xDD, 0xD9, 0xD9, 0xE5, 0xE5, 0xFD, 0xFD, 0xBB, 0xBB, 0xC7, 0xC7,
    0xFF, 0xFF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xC3, 0xC3, 0xFF, 0xFF, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xE7, 0xE7, 0xE7, 0xE7, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xE7, 0xE7, 0xE7, 0xE7, 0xEF, 0xEF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xE7, 0xE7, 0xE7, 0xE7, 0xFF, 0xFF, 0xE7, 0xE7, 0xE7, 0xE7, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xE7, 0xE7, 0xE7, 0xE7, 0xFF, 0xFF, 0xE7, 0xE7, 0xE7, 0xE7, 0xEF, 0xEF,
    0xFB, 0xFB, 0xFB, 0xFB, 0xF7, 0xF7, 0xF7, 0xF7, 0xF7, 0xF7, 0xFF, 0xFF, 0xE7, 0xE7, 0xFF, 0xFF,
    0xF3, 0xF3, 0xED, 0xED, 0xFD, 0xFD, 0xFB, 0xFB, 0xF7, 0xF7, 0xFF, 0xFF, 0xE7, 0xE7, 0xFF, 0xFF,
    0xF7, 0xF7, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xEF, 0xF7, 0xF7,
    0xEF, 0xEF, 0xF7, 0xF7, 0xF7, 0xF7, 0xF7, 0xF7, 0xF7, 0xF7, 0xF7, 0xF7, 0xF7, 0xF7, 0xEF, 0xEF,
    0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
};
