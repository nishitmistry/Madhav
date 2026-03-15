#include <stddef.h>

volatile char* video_memory = (volatile char*) 0xB8000;
const int color = 0x0F;
const char ENTERED_PROTECTED[] = " Hurray you have entered 32 BIT Protected mode";
// Function to print a character at a specific position (offset)
void printChar(char character, int offset) {
    // Each character and its attribute take up 2 bytes in memory, 
    // so the offset must be multiplied by 2.
    *(video_memory + offset * 2) = character;
    *(video_memory + offset * 2 + 1) = color;
}
void __attribute__((cdecl)) c_start()
{
    int i = 0;
    while(ENTERED_PROTECTED[i] != NULL)
    {
        printChar(ENTERED_PROTECTED[i], i);
        i++;
    }
    for(;;){}
}