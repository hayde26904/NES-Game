#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include <rand.h>

#include <gbdk/platform.h>
#include <nes/hardware.h>
#include <nes/nes.h>

#include "bg_data.c"
#include "bg_data.map"

// #include "vec.c"

// Sprite taken from 'small_sprite' example
const unsigned char dudeSprite[] =
	{
		0x7E, 0x7E, 0x99, 0x99, 0x81, 0x81, 0xA5, 0xA5,
		0x81, 0x81, 0xDB, 0xDB, 0xC3, 0xC3, 0x3C, 0x3C};

const unsigned int dudeWidth = 8;
const unsigned int dudeHeight = 8;

unsigned int screenW = DEVICE_SCREEN_PX_WIDTH;
unsigned int screenH = DEVICE_SCREEN_PX_HEIGHT;

// These palettes replace the default palette with the appropriate colors. See cgb.h for more defined colors.

/*UWORD bkgPalette[] = {
	RGB_PURPLE, RGB_BLACK, RGB_ORANGE, RGB_BROWN
};

UWORD sprPalette[] = {
	RGB_GREEN, RGB_BLUE, RGB_RED, RGB_YELLOW
};*/

UWORD bkgPalette[] = {
	0x03, 0x3F, 0x16, 0x08};

UWORD sprPalette[] = {
	0x19, 0x01, 0x06, 0x28};


const int8_t grav = 1;

struct dude
{
	int x;
	int y;
	int subX;
	int subY;
	int xv;
	int yv;
	int onGround;
	int id;
};

unsigned int dudesLen = 0;

/*void copy_dude(struct dude *original, struct dude *copy)
{
	// Copy individual members
	copy->x = original->x;
	copy->y = original->y;
	copy->xv = original->xv;
	copy->yv = original->yv;
	// Copy any other members if necessary
}*/

int randRange(int min, int max) {
    // Calculate the range size
    int range = max - min + 1;
    
    // Generate a random number within the range [0, 255]
    int randomValue = rand() % 256;
    
    // Map the random number to the desired range
    int result = min + (randomValue % range);
    
    return result;
}

void create_dude(int x, int y, int xv, int yv, int id, struct dude *d)
{
	d->x = x;
	d->y = y;
	d->xv = xv;
	d->yv = yv;
	d->onGround = 0;
	d->id = id;
}

void copy_dude(struct dude *original, struct dude *copy)
{
	// Copy individual members
	copy->x = original->x;
	copy->y = original->y;
	copy->xv = original->xv;
	copy->yv = original->yv;
	copy->id = original->id;
	// Copy any other members if necessary
}

void main(void)
{
	initrand(69);

	struct dude dudes[255];
	struct dude new_dude;
	create_dude(100, 25, -1, 1, dudesLen, &new_dude);
	dudes[dudesLen] = new_dude;
	dudesLen++;

	/*set_bkg_palette(0, 1, bkgPalette); // UBYTE first_palette, UBYTE nb_palettes, UWORD *rgb_data
	set_bkg_data(0, 131, tiledata);
	set_bkg_tiles(0, 0, 20, 18, tilemap);
	SHOW_BKG;*/

	// set_sprite_palette(0, 1, sprPalette); // UBYTE first_palette, UBYTE nb_palettes, UWORD *rgb_data
	/*set_sprite_data(0, 1, dudeSprite);
	set_sprite_tile(0, 0);
	move_sprite(0, x, y);
	SHOW_SPRITES;*/

	//set_sprite_palette(0, 1, sprPalette);
	set_sprite_data(0, 1, dudeSprite);

	DISPLAY_ON;
	SHOW_SPRITES;

	while (1)
	{
		vsync();

		switch (joypad())
		{
		case J_UP:
			struct dude new_dude;
			int spd = randRange(1,5);
			int xv = spd;
			int yv = spd;
			if(randRange(0,10) > 5){xv = -xv;}
			if(randRange(0,10) > 5){yv = -yv;}

			create_dude(rand(), rand(), xv, 1, dudesLen, &new_dude);
			dudes[dudesLen] = new_dude;
			set_sprite_tile(dudesLen, 0);
			dudesLen++;
			break;
		}

		for (int i = 0; i < dudesLen; i++)
		{

			/*struct dude d;
			copy_dude(&dudes[i], &d);

			d.x += d.xv;
			d.y += d.yv;
			move_sprite(d.id, d.x, d.y);

			copy_dude(&d, &dudes[i]);*/

			if(dudes[i].x + dudeWidth >= screenW || dudes[i].x <= 0){
				dudes[i].xv = -dudes[i].xv;
			}

			if(dudes[i].y + dudeHeight >= screenH || dudes[i].y <= 0){
				dudes[i].yv = -dudes[i].yv;

				/*if(dudes[i].y + dudeHeight >= screenH + dudeHeight){
					dudes[i].onGround = 1;
				}*/
			}

			if(dudes[i].onGround == 0){
				dudes[i].yv += grav;
				dudes[i].y += dudes[i].yv;
			}/* else {
				dudes[i].y = 50;
			}*/

			dudes[i].x += dudes[i].xv;
			move_sprite(dudes[i].id, dudes[i].x, dudes[i].y);
			//printf("%d\n", dudes[i].y);
		}

		//delay(100);
	}
}