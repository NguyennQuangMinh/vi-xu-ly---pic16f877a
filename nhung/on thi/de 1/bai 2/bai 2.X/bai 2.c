/*
 * File:   bai 2.c
 * Author: Nguy?nQuangMinh
 *
 * Created on April 21, 2023, 9:45 PM
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
#include <pic16f877a.h>
#define _XTAL_FREQ 16000000

#define RD0 PORTDbits.RD0
#define Tris_RD0 TRISDbits.TRISD0

#define RD1 PORTDbits.RD1
#define Tris_RD1 TRISDbits.TRISD1

void main(void) {
    Tris_RD0 = 0;
    Tris_RD1 = 0 ;
    RD0 = 1 ;
    RD1 =1 ;
    while(1)
    {
        RD0 = 0 ;
        RD1 = 0 ;
        __delay_ms(250);
        
        RD0 = 1 ;
        RD1 = 1 ;
        __delay_ms(250);
        
        RD0 = 1 ;
        RD1 = 0 ;
        __delay_ms(250);
        
        RD0 = 0 ;
        RD1 = 1 ;
        __delay_ms(250);
        RD0 = 0 ;
        RD1 = 0 ;
        
    }
}
