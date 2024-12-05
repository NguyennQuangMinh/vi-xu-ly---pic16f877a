/*
 * File:   bt3_main.c
 * Author: admin
 *
 * Created on February 28, 2023, 11:15 PM
 */


#include <xc.h>

#define _XTAL_FREQ 20000000

void Init(void);
void adc(void);
void ledset(void);
void delay_5ms(void);
unsigned int led[] ={0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x90};
unsigned int i=0;
unsigned int adcval;
unsigned int temp=0;
unsigned int cnt = 0;

void main(void) {
    Init();

    while(1){ledset();};
}

void __interrupt() isr1() 
{
    
    if (T0IF == 1)
    {
        TMR0 = 157;
        T0IF = 0; 
        cnt ++;
        if(cnt%10==0)
        {
            adc();
            PORTBbits.RB0 = ~PORTBbits.RB0;
        }
        if(cnt == 100) 
        {
            if(temp>=100){
            PORTBbits.RB6 = ~PORTBbits.RB6;} else {PORTBbits.RB6=0;}
            cnt = 0;
        }
    }
}

void Init(void)
{
    TRISB=0;
    PORTB=0;
    TRISC=0;
    PORTC=0;
    TRISD=0;
    TRISA=1;
    
    OPTION_REG=0b00000111;
    INTCON=0b10100000;
}

void adc(void)
{
ADCON0=0b10000001;
ADCON1=0b10000000;
//delay_5ms();
__delay_ms(5);
GO_nDONE=1;
while(GO_nDONE);
adcval=((ADRESH<<8)|(ADRESL));
if(adcval>=205){
    temp=(adcval-205)*0.2445;
}
else{
    temp=(205-adcval)*0.2445;
}
}

void ledset(void)
{     
    i=temp;
    if(adcval>=205){
        PORTC = 0;    
        PORTD=led[(i/100)];
        PORTC = 1;
        delay_5ms();
        PORTC = 0;
        PORTD=led[((i%100)/10)];
        PORTC = 2;
        delay_5ms();
        PORTC = 0;
        PORTD=led[(i%10)];
        PORTC = 4;
        delay_5ms();
    } 
    else {
        PORTC = 0;    
        PORTD=0xBF;
        PORTC = 1;
        delay_5ms();
        PORTC = 0;
        PORTD=led[((i%100)/10)];
        PORTC = 2;
        delay_5ms();
        PORTC = 0;
        PORTD=led[(i%10)];
        PORTC = 4;
        delay_5ms();
    }
}

void delay_5ms(void)
{
    unsigned int a;
    a=cnt;
    while(a==cnt);
}