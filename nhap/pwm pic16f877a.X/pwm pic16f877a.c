/*
 * File:   pwm pic16f877a.c
 * Author: Nguy?nQuangMinh
 *
 * Created on April 10, 2023, 7:00 PM
 */



// PIC16F877A Configuration Bit Settings

// 'C' source line config statements

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
#include <math.h>
#define _XTAL_FREQ 16000000

void pwm(void)
{
    TRISC1=1;
    TMR2=0;
    PR2=399;
    CCP2CON=0X0C;
    CCPR2L =30;
    T2CKPS0 = 0;
    T2CKPS1=0;
    T2CON=0X00;
    TRISC1 = 0;
    TMR2ON=1;
    
}

void main(void) {
    pwm();
    while(1)
    {
    
    }
}
