/*
 * File:   newmain.c
 * Author: Admin
 *
 * Created on November 22, 2022, 8:33 PM
 */

// CONFIG
#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator)
#pragma config WDTE = ON        // Watchdog Timer Enable bit (WDT enabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = OFF      // Brown-out Reset Enable bit (BOR disabled)
#pragma config LVP = OFF        // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
#pragma config CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

#include <xc.h>

void main(void) {
    PORTB=0;
    TRISB=0;
    while(1)
    {
     /*   R0  R1  R2  R3  R4  R5  R6 
        a   b   c   d   e   f   g (LED 7 thanh ch? sáng ???c t? s? 0 ??n s? 9) 
 s? 0 : 0   0   0   0   0   0   1
 s? 1 : 1   0   0   1   1   1   1
        
    =>  R7   R6   R5  R4  R3  R2  R1  R0
             g    f   e    d   c   b   a 
 s? 0 : 0    1    0   0    0   0   0   0
 s? 1 : 0    1    1   1    1   0   0   1 */
        PORTB=0X40;
        
        
    }
}
