/*
 * File:   bai 2.c
 * Author: Admin
 *
 * Created on December 7, 2022, 3:28 PM
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

#define _XTAL_FREQ 20000000

void delay_timer0_5ms(unsigned int time)
{
    while (time--) //l?p l?i time l?n 5ms.
    {
        OPTION_REGbits.T0CS = 0; //Dùng xung n?i
        OPTION_REGbits.PSA = 0; //Dùng b? chia timer0
        //chon bo chia 1:128
        OPTION_REGbits.PS2 = 1;
        OPTION_REGbits.PS1 = 1;
        OPTION_REGbits.PS0 = 0; //Ch?n b? chia 1:128
        TMR0 = 60; //??t giá tr? cho TMR0
        while(!INTCONbits.TMR0IF); //??i c? tràn
        INTCONbits.TMR0IF = 0; //Xóa c? tràn
    }
}
void show1()
{
    char i;
    PORTC=0X00;
    PORTD=0X00;
    for(i=0;i<8;i++)
    {
        PORTC =0X01<<i;
        PORTD =0X80>>i;
        delay_timer0_5ms(5);
    }
}
void show2()
{
    char i;
    for(i=0;i<8;i++)
    {
        PORTC=0X01<<i;
        delay_timer0_5ms(10);
    }
}
void show3()
{
    char i;
    for(i=0;i<8;i++)
    {
        PORTD=0X01<<i;
        delay_timer0_5ms(10);
    }
}
unsigned int count=0;
void __interrupt() timer2 (void)
{
if(TMR2IF)
{
    TMR2IF=0;
    count++;
    if(count<=5)
    {
        RB0 = 1;
    }
    else if(count>5&&count<=10)
    {
        RB0 = 0;
    }
    if(count > 10)
    {
        count = 0;
    }
}
TMR2IE=1;//bat co ngat
TMR2IF=0;
TMR2=230;
// PR2=230;
}
void timer2_init()
{
    TMR2=230;
    T2CON=0B00000100;
    TMR2IE=1; //bat co ngat tu TMR2 den PR2
    TMR2IF=0;
    GIE=1; //ngat toan cuc
    PEIE=1;
}
void main(void) 
{
    TRISB=0x00;
    TRISC=0x00;
    TRISD=0x00;
    PORTD=0X00;
    PORTC=0X00;
    PORTB=0X00;
    timer2_init();
    while(1)
    {
        show1();
        PORTC=0X00;
        PORTD=0X00;
        show2();
        PORTC=0X00;
        PORTD=0X00;
        show3();
        PORTC=0X00;
        PORTD=0X00;
    }
}
