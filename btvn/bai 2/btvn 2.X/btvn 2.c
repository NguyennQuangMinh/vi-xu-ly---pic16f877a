/*
 * File:   btvn 2.c
 * Author: Nguy?nQuangMinh
 *
 * Created on February 21, 2023, 9:13 AM
 */


#include<xc.h>
#define _XTAL_FREQ 16000000
#define Tris_kb0 TRISAbits.TRISA0
#define kb0 PORTAbits.RA0
#define Tris_kb1 TRISAbits.TRISA3
#define kb1 PORTAbits.RA3
#define Tris_led TRISCbits.TRISC0
#define led PORTCbits.RC0
#define Tris_xung2 TRISCbits.TRISC1
#define xung2 PORTCbits.RC1
#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = ON       // Brown-out Reset Enable bit (BOR enabled)
#pragma config LVP = ON         // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3/PGM pin has PGM function; low-voltage programming enabled)
#pragma config CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF    
unsigned char pre_kb0;
int i=0,j=0;
char suon_len;
void timer0_initialize()
{
    T0CS=0;
    PSA=0;
    PS0=1;
    PS1=1;
    PS2=0;
    TMR0=5;
    TMR0IE=1;
    GIE=1;
}
void __interrupt() Count_Up(void)
{
    if(TMR0IE && TMR0IF)
    {
        TMR0=5;
        TMR0IF=0;
        i++;
        j++;
        if(kb0==0)
        {
            led=1;
            i=0;
        }
        if(suon_len)
        {
            if(i==2000)
                led=0;
        } 
    }
}
int main()
{
    ADCON1=0x06;
    Tris_kb0=1;
    Tris_led=0;
    Tris_kb1=1;
    Tris_xung2=0;
    suon_len=0;
    timer0_initialize();
    while(1)
    {
        if(suon_len==0 && kb0)
            suon_len=1;
        if(kb0==0)
        {
            suon_len=0;
            if(kb1==0)
                xung2=0;
            else
                xung2=1;
        }
    }
}
