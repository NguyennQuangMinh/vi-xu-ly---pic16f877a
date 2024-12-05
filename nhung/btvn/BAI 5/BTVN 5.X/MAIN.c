/*
 * File:   MAIN.c
 * Author: Nguy?nQuangMinh
 *
 * Created on April 19, 2023, 2:06 PM
 */


// CONFIG
#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = ON       // Brown-out Reset Enable bit (BOR enabled)
#pragma config LVP = OFF        // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
#pragma config CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

#include <xc.h>
#include "ADC0808.h"
#define _XTAL_FREQ 16000000

unsigned int count, count1;

void timer2_initialize()
/* tinh thoi gian ngat : Tngat=4*prescale*( PR2-TMR2)*postscale*1/f
                                       */
{
    T2CKPS1=0;
    T2CKPS0=1;
    
    PR2=100; //1ms
    TMR2=0;
    
    TOUTPS0=1;
    TOUTPS1=0;
    TOUTPS2=0;
    TOUTPS3=1; //0.1/10
    
    TMR2ON=1;
    TMR2IE=1;
    
    PEIE=1;
    GIE=1;
}

void __interrupt() Count_Up(void) //1ms
{
    if (TMR2IE && TMR2IF)
    {
        TMR2IF=0;
        count++;
        if(count==6) //6ms
        {
            count=0;
            count1++;
        }
    }
}

void main(void) {
    timer2_initialize();
    
}
