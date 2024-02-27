/* 
 * Idk, trying to draw a cool circle without any graphical
 * library, just to see if I can do it x3
 *
 * Compilation: gcc circle.c
 *
 */

#include <sys/ioctl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void draw(char* screen, int size_x, int size_y) {
	system("clear");
	printf("X: %d\n", size_x);	
	printf("Y: %d\n", size_y);	
	
	for(int i = 0; i < size_x; i++) {
		for(int j = 0; j < size_y; j++) {
			//printf("%s", *(screen + (i * size_x + j)) ? "#" : " " );	// So far this only does black and white
			printf("%d", *(screen + (i * size_x + j)));	// So far this only does black and white
		}
		printf("\n");
	}
}

int main() { 
	struct winsize w;
    ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);	// Get the size of the terminal

	printf ("lines %d\n", w.ws_row); // (x)
    printf ("columns %d\n", w.ws_col); // (y)

	char *screenlol = malloc((sizeof *screenlol) * w.ws_row * w.ws_col);
	memset(screenlol, 0, (sizeof *screenlol) * w.ws_row * w.ws_col);	// Set the screen to all black	
	memset(screenlol + (w.ws_row * 2) + 0 , 1, 0);	

	draw(screenlol, w.ws_row, w.ws_col); // This is kinda of a dumb way to do it

	return 0; 
}

