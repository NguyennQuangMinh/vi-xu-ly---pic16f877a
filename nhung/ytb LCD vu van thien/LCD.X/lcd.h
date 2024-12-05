
// PIC16F877A Configuration Bit Settings

// 'C' source line config statements

// CONFIG
#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = OFF      // Brown-out Reset Enable bit (BOR disabled)
#pragma config LVP = OFF        // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
#pragma config CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)

#define RS RB0
#define RW RB1
#define E  RB2
// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.
#define _XTAL_FREQ 20000000
#include <xc.h>

void lenh(unsigned char a)
{
    RS=0;
    RW=0;
    PORTD=a;
    E=1;
    E=0;
    PORTD= a<<4 ;
    E=1;
    E=0;
    __delay_us(40);
}

void gui_lenh(unsigned char a)
{
    RS=0;
    RW=0;
    
    PORTD=a;
    E=1;
    E=0;
    __delay_us(40);
            
}

void khoi_taoLCD()
{
    gui_lenh(0x82);
    lenh(0x28);
    lenh(0x06);
    lenh(0x0e);
}

void du_lieu(unsigned char a)
{
    RS=1;
    RW=0;
    PORTD=a;
    E=1;
    E=0;
    PORTD = a<<4 ;
    E=1;
    E=0;
    __delay_us(40);
}

void chuoi_kytu(unsigned char *a)
{
    unsigned int i;
    for(i=0;a[i]!='\0';i++)
    {
        du_lieu(a[i]);
    }
}