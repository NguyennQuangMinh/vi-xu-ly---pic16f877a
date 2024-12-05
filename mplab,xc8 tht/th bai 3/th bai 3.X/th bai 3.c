/*
 * File:   th bai 3.c
 * Author: Admin
 *
 * Created on November 25, 2022, 3:56 PM
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
#define _XTAL_FREQ 16000000//16Mhz

unsigned char Ma[10]={0X40,0X79,0X24,0X30,0X19,0X12,0X02,0X78,0X00,0X10};

void quedled(int x)
{
    int c,dv;
    if(x<0)
    {
        int y=-x;
        RC1=0;
        RC4=0;
        PORTB=Ma[y];
        __delay_ms(1000);
    }
    if(x>=0)
    {
        c=x/10;
        dv=x%10;
        
        for(int z=0;z<100;z++)
        {
            RC1=0;
            PORTB=Ma[c];
            __delay_ms(5);
            RC1=1;
            RC4=0;
            PORTB=Ma[dv];
            __delay_ms(5);
            RC4=1;
            
        
        }
    
    
    }

}

void main(void) {
    TRISB=0;
    TRISC=0;
    TRISD=1;
    while(1)
    {
        if(PORTDbits.RD5==0)
        {
            __delay_ms(2);
            for(int k=-9;k<0;k++)
            {
                quedled(k);
        
            }
        }
        for(int i=0;i<100;i++)
        {
            quedled(i);
            if(PORTDbits.RD5==0)
                break;
        }
    
        
    }
    
    
}
