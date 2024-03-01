/* 
 * Idk, trying to draw a cool circle without any graphical
 * library, just to see if I can do it x3
 *
 * Compilation: gcc circle.c -lm
 *
 */

#include <math.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

/* ANSI Escape Sequences */
#define ESC     "\x1B"
#define CLS     ESC"[2J"
#define HOME    ESC"[H"

void screen_refresh(char* screen, int size_x, int size_y) {
	// system("clear"); // Bruh, I actually don't need it if I redraw the whole 
	printf(HOME);
	//printf("X: %d\n", size_x);	
	//printf("Y: %d\n", size_y);	
    char line[size_x + 1];

	for(int y = 0; y < size_y; y++) {
		for(int x = 0; x < size_x; x++) {
			//printf("%s", *(screen + (x + y * size_x)) ? "#" : " " );	// So far this only does black and white
            line[x] = *(screen + (x + y * size_x)) ? '#' : ' ';
			//printf("%d", *(screen + (x + y * size_x)));	// So far this only does black and white
		}
        line[size_x] = 0;
		printf("%s\n",line);
	}
}

void draw_circle(char* screen, int size_x, int size_y, int radius, int origin_x, int origin_y, char value) {

	for(int i = 1; i < 360 ; i++) {
		int x = (radius * cos(i * M_PI / 180)) + origin_x;
		int y = (radius * sin(i * M_PI / 180)) + origin_y;
		//printf("X: %d, Y: %d\n",x,y);
		screen[x + y * size_x] = value;	// So far this only does black and white
	}
}

int main() { 
	struct winsize w;
    ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);	// Get the size of the terminal

    //printf ("Columns: %d\n", w.ws_col); // (x)
	//printf ("Rows: %d\n", w.ws_row); // (y)

	char *screenarr = malloc((sizeof *screenarr) * w.ws_col * w.ws_row);
	memset(screenarr, 0, (sizeof *screenarr) * w.ws_col * w.ws_row);	// Set the screen to all black	
    // \x1b[?1049h
	
	int radius = w.ws_row / 2;
	if(w.ws_row > w.ws_col)
		radius = w.ws_col / 2;
	for(int balls = 0; balls < 1000; balls++) {	
		// Move the circle to the left
		for(int shift = -(w.ws_col/ 2) + radius; shift < w.ws_col / 2 - radius; shift++) {
			draw_circle(screenarr, w.ws_col, w.ws_row, radius, w.ws_col / 2 + shift, w.ws_row / 2, 1);
			screen_refresh(screenarr, w.ws_col, w.ws_row); // This is kinda of a dumb way to do it
			draw_circle(screenarr, w.ws_col, w.ws_row, radius, w.ws_col / 2 + shift, w.ws_row / 2, 0);
			//usleep(5000);
		}
		
		// Move the circle to the middle
		for(int shift = w.ws_col / 2 - radius; shift >= 0; shift--) {
			draw_circle(screenarr, w.ws_col, w.ws_row, radius, w.ws_col / 2 + shift, w.ws_row / 2, 1);
			screen_refresh(screenarr, w.ws_col, w.ws_row); // This is kinda of a dumb way to do it
			draw_circle(screenarr, w.ws_col, w.ws_row, radius, w.ws_col / 2 + shift, w.ws_row / 2, 0);
			//usleep(5000);
		}
	
		// Zoom in and out with the circle
		int direction = 1;
		int test = 0;
		for(int i = 0; i < radius * 4; i++) {
			draw_circle(screenarr, w.ws_col, w.ws_row, radius - test, w.ws_col / 2, w.ws_row / 2, 1);
			screen_refresh(screenarr, w.ws_col, w.ws_row); // This is kinda of a dumb way to do it
			draw_circle(screenarr, w.ws_col, w.ws_row, radius - test, w.ws_col / 2, w.ws_row / 2, 0);
			if(test >= radius)
				direction = direction * -1;
			else if(test <= 0) {
				direction = direction * -1;
				test = 0;
			}
			test += direction;
			//printf("Direction: %d\n", direction);
			//printf("Test: %d\n", test);
			//usleep(10000);
		}
		
		// Move the circle back to the start
		for(int shift = 0; shift >= -(w.ws_col / 2) + radius; shift--) {
			draw_circle(screenarr, w.ws_col, w.ws_row, radius, w.ws_col / 2 + shift, w.ws_row / 2, 1);
			screen_refresh(screenarr, w.ws_col, w.ws_row); // This is kinda of a dumb way to do it
			draw_circle(screenarr, w.ws_col, w.ws_row, radius, w.ws_col / 2 + shift, w.ws_row / 2, 0);
		//	usleep(5000);
		}
	}
	system("clear");
	
	return 0; 
}

