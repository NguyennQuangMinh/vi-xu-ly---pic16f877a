/*
 * File:   vxl bai 1.c
 * Author: Admin
 *
 * Created on December 7, 2022, 3:14 PM
 */


#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator)
#pragma config WDTE = OFF      // Watchdog Timer Enable bit (WDT enabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = ON      // Brown-out Reset Enable bit (BOR disabled)
#pragma config LVP = OFF        // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
#pragma config CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)
#include <xc.h>

#define _XTAL_FREQ 16000000
unsigned int count = 0,i ,j ;
void init_time2()
{
    TMR2=230;
    T2CON=0B00000100;
    TMR2IE=1; //bat co ngat tu TMR2 den PR2
    TMR2IF=0;
    GIE=1; //ngat toan cuc
    PEIE=1; //ngat cuc bo ON
}
void __interrupt() count_up(void)
{
    if(TMR2IF)
    {
        TMR2IF=0;
        j++;
        if(j>20)
        j=0;
        if(j>=0&&j<=10)
        RC0=1;
        else if(j>=10&&j<=20)
        RC0=0;
    }
}
void thuanghich()
{
    PORTD=0x00;
    for(i=0;i<4;i++)
    {
        PORTD = 0X01<<i;
        __delay_ms(100);
    }
    PORTD=0x00;
    for(i=0;i<4;i++)
    {
        PORTD = 0X08>>i;
        __delay_ms(100);
    }   
}
void main()
{
    init_time2();
    TRISC=0X00;
    TRISD=0X00;
    PORTD=0X00;
    unsigned char d;
    while(1)
    {
        thuanghich();
    }
}
