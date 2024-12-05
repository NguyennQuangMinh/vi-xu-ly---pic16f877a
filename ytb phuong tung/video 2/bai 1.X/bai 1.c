/*
 * File:   bai 1.c
 * Author: Nguy?nQuangMinh
 *
 * Created on April 5, 2023, 10:50 PM
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
#define _XTAL_FREQ 4000000
unsigned char led[] = { 0x01, 0x02 , 0x04 , 0x08 , 0x10 ,0x20 , 0x40 , 0x80 };
unsigned char i;
unsigned char j;

void ledchoptat()
{
    PORTD = 0x00;
    __delay_ms(500);
    PORTD = 0XFF;
    __delay_ms(500);
}

void ledsangduoi()
{
    for(i=0;i<=7;i++)
    {
        PORTD=led[i];
        __delay_ms(500);
    }
}

void ledsangdan()
{
    unsigned char a=0x01;
    PORTD=0x00;
    __delay_ms(500);
    PORTD=a;
    __delay_ms(500);
    for(i=0;i<=7;i++)
    {
        a |= a<<1;
        PORTD=a;
        __delay_ms(500);
    }
}

void leddemnhiphan()
{
    unsigned int i;
    for(i=0;i<=255;i++)
    {
        PORTD=i;
        __delay_ms(500);
    }
}

void ledsangdon()
{
    unsigned char a = 0x00 ;
    for(i=0;i<8;i++)
    {
        for( j=0; j<8-i ;j++)
        {
            PORTD = (0X80 >> j) |a;
            __delay_ms(500);
        }
        a=PORTD;
        __delay_ms(500);
    }
}

void main(void) {
    ANSEL = ANSELH = 0x00;
    TRISD = 0x00;
    PORTD = 0x00;
    while(1)
    {
        //ledchoptat();
        //ledsangduoi();
        //ledsangdan();
        //leddemnhiphan();
        ledsangdon();
        
    }
}
