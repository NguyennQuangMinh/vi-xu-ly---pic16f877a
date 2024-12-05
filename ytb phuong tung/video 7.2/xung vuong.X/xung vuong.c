/*
 * File:   xung vuong.c
 * Author: Nguy?nQuangMinh
 *
 * Created on April 9, 2023, 10:09 AM
 */


// PIC16F887 Configuration Bit Settings

// 'C' source line config statements

// CONFIG1
#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator: High-speed crystal/resonator on RA6/OSC2/CLKOUT and RA7/OSC1/CLKIN)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled and can be enabled by SWDTEN bit of the WDTCON register)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config MCLRE = OFF      // RE3/MCLR pin function select bit (RE3/MCLR pin function is digital input, MCLR internally tied to VDD)
#pragma config CP = OFF         // Code Protection bit (Program memory code protection is disabled)
#pragma config CPD = OFF        // Data Code Protection bit (Data memory code protection is disabled)
#pragma config BOREN = ON       // Brown Out Reset Selection bits (BOR enabled)
#pragma config IESO = OFF       // Internal External Switchover bit (Internal/External Switchover mode is disabled)
#pragma config FCMEN = OFF      // Fail-Safe Clock Monitor Enabled bit (Fail-Safe Clock Monitor is disabled)
#pragma config LVP = OFF        // Low Voltage Programming Enable bit (RB3 pin has digital I/O, HV on MCLR must be used for programming)

// CONFIG2
#pragma config BOR4V = BOR40V   // Brown-out Reset Selection bit (Brown-out Reset set to 4.0V)
#pragma config WRT = OFF        // Flash Program Memory Self Write Enable bits (Write protection off)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

#include <xc.h>
#include <math.h>
#define _XTAL_FREQ 4000000

void delay_5ms()
{
    TMR0=100;
    TMR0IF=0;
    T0CS=0;
    GIE=PEIE=TMR0IE=0;// 0 : CAM NGAT ; 1: CHO PHEP NGAT
    PSA=0;
    PS2=1;
    PS1=0;
    PS0=0;
    while(TMR0IF==0);
}

void delay_100us(unsigned int n)
{  
    while(n--)
    {
        TMR0=231;
        TMR0IF=0;
        T0CS=0;
        GIE=PEIE=TMR0IE=0;
        PSA=0;
        PS2=0;
        PS1=0;
        PS0=0;
    }
}

void main(void) {
    ANSEL = ANSELH = 0x00;
    TRISE1=0x00;
    TRISE2=0x00;
//    delay_5ms();
    unsigned char count=0 ; 
    while(1)
    {        
        RE1=!RE1;
        delay_100us(5);
        count++;
        if(count == 20 )
        {
            count=0;
            RE2=!RE2;
        }
            
    }
    
}
