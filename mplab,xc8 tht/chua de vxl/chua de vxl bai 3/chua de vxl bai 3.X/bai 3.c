/*
 * File:   bai 3.c
 * Author: Admin
 *
 * Created on December 7, 2022, 8:13 PM
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

#define SW RC2
unsigned int count = 0;
#define Xung RC7
void __interrupt() timer2 (void)
{
if(TMR2IF)
{
TMR2IE=0;
count++;
if(count<=5)
{
Xung = 1;
}
else if(count>5&&count<=10)
{
Xung = 0;
}
if(count == 11){
count = 0;
} }
TMR2IE=1;//bat co ngat
TMR2IF=0;
TMR2=230;
// PR2=250;
}
void delay_timer0_5ms(unsigned int time)
{
while (time--) //l?p l?i time l?n 5ms.
{
OPTION_REGbits.T0CS = 0; //Dùng xung n?i
OPTION_REGbits.PSA = 0; //Dùng b? chia timer0
//chon bo chia 1:12813
OPTION_REGbits.PS2 = 1;
OPTION_REGbits.PS1 = 1;
OPTION_REGbits.PS0 = 0; //Ch?n b? chia 1:128
TMR0 = 60; //??t giá tr? cho TMR0
while(!INTCONbits.TMR0IF); //??i c? tràn
INTCONbits.TMR0IF = 0; //Xóa c? tràn
}}
void hienthi(unsigned int s)
{
unsigned int s1,s2,a,b,c,d;
const unsigned char MALED[] = {0xC0, 0xF9, 0xA4, 0xB0, 0x99,0x92, 0x82,0xF8, 0x80, 0x90};
a=(s/1000);
b=(s%1000)/100;
c=(s%100)/10;
d=s%10;
for(int i=0;i<20;i++)
{
PORTDbits.RD0=0; PORTB = MALED[a];
delay_timer0_5ms(2); PORTDbits.RD0=1;
PORTDbits.RD1=0; PORTB = MALED[b];
delay_timer0_5ms(1); PORTDbits.RD1=1;
PORTDbits.RD2=0; PORTB = MALED[c];
delay_timer0_5ms(2); PORTDbits.RD2=1;
PORTDbits.RD3=0; PORTB = MALED[d];
delay_timer0_5ms(1); PORTDbits.RD3=1;
}}
void timer2_init(){
INTCONbits.GIE=1;// ngat toan cuc
INTCONbits.PEIE=1;//cho phep ngat hoat dong
T2CON=0B00000100;//1:8
PIE1bits.TMR2IE=1;//bat co ngat tu TMR2-PR2
PIR1bits.TMR2IF=0;//co bao ngat
TMR2=230;}
void main(void) {
timer2_init();
TRISB = 0x00;
TRISD = 0x00;
TRISCbits.TRISC2 = 1;
TRISCbits.TRISC7 = 0;
PORTB = 0x00;
PORTD = 0x00;
unsigned int d = 0;
while(1)
{
if(SW == 0){
d++;
}
if(d>9999)
{ d=0; }
hienthi(d);
} 
}