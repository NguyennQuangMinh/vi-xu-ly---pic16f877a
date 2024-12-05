/*
 * File:   newmain.c
 * Author: Admin
 *
 * Created on November 21, 2022, 2:08 PM
 */


#include <xc.h>
#include <pic16f877a.h>
#define _XTAL_FREQ 20000000
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
    for(i=0;i<4;i++){
    PORTD = 0X01<<i;
    __delay_ms(100);
    }
    PORTD=0x00;
    for(i=0;i<4;i++){
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