/*
 * File:   led 7 seg.c
 * Author: Nguy?nQuangMinh
 *
 * Created on April 6, 2023, 3:24 PM
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

unsigned char num_disp, num_disp_c , num_disp_dv , i , j;
unsigned char led7seg[10] = { 0xC0 , 0xF9 , 0xA4 , 0xB0 , 0x99 , 0x92 , 0x82 , 0xF8 , 0x80 , 0x90 };
unsigned char led7seg_nghich[10] = { 0x90 , 0x80 , 0xF8 , 0x82 , 0x92 , 0x99 , 0xB0 , 0xA4 , 0xF9 , 0xC0 };

void demtu0_99()
{
    for(i=0;i<=9;i++)
    {
        for(j=0;j<=9;j++)
        {
            PORTC=led7seg[i];
            PORTD=led7seg[j];
            __delay_ms(500);
        }
    }
}

void demtu0_23()
{
    for(i=0;i<=23;i++)
    {
        PORTC = led7seg[i/10];
        PORTD = led7seg[i%10];
        __delay_ms(500);
    }
}

void demgiam23_0()
{
    for( j=23 ; j>0 ; j--)
    {
        PORTC = led7seg[j/10];
        PORTD = led7seg[j%10];
        __delay_ms(300);
    }
}

void main(void) {
    ANSEL = ANSELH = 0x00;
    TRISC = 0x00;
    TRISD = 0x00;
//    num_disp = 12;
//    num_disp_c= num_disp/10;
//    num_disp_dv = num_disp%10;
//    PORTC = led7seg[num_disp_c];
//    PORTD = led7seg[num_disp_dv];
    while(1)
    {
//        demtu0_99();
//        demtu0_23();
        demgiam23_0();
    }
    
    
}
