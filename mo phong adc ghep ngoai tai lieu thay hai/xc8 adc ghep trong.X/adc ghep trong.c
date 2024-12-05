/*
 * File:   adc ghep trong.c
 * Author: Nguy?nQuangMinh
 *
 * Created on April 4, 2023, 6:49 PM
 */


#include <xc.h>
#include "lcd_hd44780_pic16.h"
#define _XTAL_FREQ 16000000
// Define ADC Channels
#define AN0 0
#define AN1 1
#define AN2 2
#define AN3 3
#define AN4 4
#define AN5 5
#define AN6 6
#define AN7 7
#define Add_A PORTCbits.RC0 // Address Pin A
#define Add_B PORTCbits.RC1
#define Add_C PORTCbits.RC2
#define ALE PORTCbits.RC3
#define EOC PORTCbits.RC4
#define OE PORTCbits.RC5
#define START PORTCbits.RC6
#define CLK PORTCbits.RC7
#define Data_Bus PORTB
#define HalfCycleDelay 10
#define Input 1
#define Out 0
unsigned int i;
float Dong,Dienap;
unsigned int count, count1,count_s;
unsigned char do_dienap;
unsigned char adc_ok;
void InitAdc(void)
{
ADCON1 = 0xC4; // D?ng d? li?u bên ph?i, Xung nh?p FOSC/64; C?ng Analog AN0-2.
ADCON0 =0x80; // ADMF=1
}
unsigned int ReadAdc(unsigned char Channel)
{
unsigned int value;
switch(Channel)
{
    case 0: CHS0 = 0; CHS1 = 0; CHS2 = 0; break;
    case 1: CHS0=1; CHS1 = 0; CHS2 = 0;
}
ADON=1;
__delay_us(5);
GO_DONE=1;
while(GO_DONE);
value=(unsigned int)ADRESH*256+ADRESL;
ADON=0;
return value;
}
void timer2_initialize ()
{
T2CKPS0=1;
T2CKPS1=0;
PR2=100; //0.1ms
TOUTPS0=1;
TOUTPS1=0;
TOUTPS2=0;
TOUTPS3=1; //0.1/10
TMR2ON=1;
TMR2IE=1;
PEIE=1;
GIE=1;
}
void __interrupt() Count_Up(void) //1ms
{
if (TMR2IE && TMR2IF)
{
TMR2IF=0;
count++;
if(count==20) //20ms
{
count=0;
count1++;
if(do_dienap)
{
Dienap=(float)(ReadAdc(AN0)); // Read ADC value from Channel 0
Dienap=Dienap*1.962;
adc_ok=1;
}
else
{
Dong = (float)(ReadAdc(AN1)); // Read ADC value from Channel 1
Dong=Dong/2.55;
}
do_dienap=~do_dienap; // Chuy?n ??i gi?a ?o dòng và áp
}
}
}
int main ()
{
unsigned char Digit[3] = { 0,0,0 }; // To make digits to display on LCD
unsigned int ADC_Value = 0;
ADCON1 = 0x06;
LCDInit(LS_NONE);
InitAdc();
timer2_initialize ();

while(1)
{

if(adc_ok && count1==25) //25*20ms=500ms hi?n th? lên LCD 1 l?n
{
count1=0;
ADC_Value=(unsigned int)Dong;
Digit[2] = (ADC_Value/100);
Digit[1] = (ADC_Value%100)/10;
Digit[0] = (ADC_Value%100)%10;
LCDGotoXY(1,0);
LCDWriteString("Gia tri I=   ");
LCDData(Digit[2]+0x30);
LCDData('.');
LCDData(Digit[1]+0x30);
LCDData(Digit[0]+0x30);
ADC_Value=(unsigned int)Dienap;
Digit[2] = (ADC_Value/100);
Digit[1] = (ADC_Value%100)/10;
Digit[0] = (ADC_Value%100)%10;
LCDGotoXY(1,1);
LCDWriteString("Gia tri U=   ");
LCDData(Digit[2]+0x30);
LCDData('.');
LCDData(Digit[1]+0x30);
LCDData(Digit[0]+0x30);

}
LCDClear();
}
}

