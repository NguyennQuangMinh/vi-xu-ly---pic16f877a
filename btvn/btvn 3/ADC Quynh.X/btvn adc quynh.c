/*
 * File:   btvn adc quynh.c
 * Author: Nguy?nQuangMinh
 *
 * Created on March 16, 2023, 9:31 PM
 */


// CONFIG
#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = ON       // Brown-out Reset Enable bit (BOR enabled)
#pragma config LVP = ON         // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3/PGM pin has PGM function; low-voltage programming enabled)
#pragma config CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

#include <xc.h>
#define _XTAL_FREQ 20000000

#define Led_7Seg PORTB
#define Tris_Led_7seg TRISB

#define Led PORTCbits.RC0
#define Tris_Led TRISCbits.TRISC0

#define d1 PORTCbits.RC1
#define d2 PORTCbits.RC2
#define d3 PORTCbits.RC3

#define tris_d1 TRISCbits.TRISC1
#define tris_d2 TRISCbits.TRISC2
#define tris_d3 TRISCbits.TRISC3

char ma[]={0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90};
 float nhiet_do;
unsigned char i,digit;
unsigned int j,adc_value;

void InitADC(void); //
void ReadADC(unsigned char channel);
void HienThi_7seg(void);

void InitADC(void){
    ADCON1=0xC4;
    ADCON0=0x80;
}
void ReadADC(unsigned char channel){
    switch(channel){
        case 0 : CHS0=0;CHS1=0;CHS2=0 ;break;
        case 1 : CHS0=1;CHS1=0;CHS2=0;
    }
    ADON=1;
    __delay_ms(50);
    GO_DONE =1;
    while(GO_DONE);
    adc_value = ((ADRESH<<8)|(ADRESH));
    if(adc_value >= 205){
        nhiet_do = (adc_value-205)*0.2444;
    }
    else nhiet_do =(205-adc_value)*0.2444;
}
void HienThi_7seg(void){
    unsigned char tram,chuc,donvi,num;
    Led_7Seg =0xff;
    ReadADC(0);
    num = (unsigned char)nhiet_do;
    tram = num/100;
    chuc = (num%100)/10;
    donvi=(num%100)%10;
    switch (digit){
        case 0: 
            d3=0;d2=1;d1=1;
            Led_7Seg=ma[tram];
        break;
        case 1: 
            d3=1;d2=0;d1=1;
            Led_7Seg=ma[chuc];
        break;
        case 2: 
            d3=1;d2=1;d1=0;
            Led_7Seg=ma[donvi];
    }
}
void timer0_inialize(){
    T0CS =0;
    PSA =0;
    PS0=1;
    PS1=1;
    PS2=0;
    TMR0=5;
    TMR0IE=1;
    GIE=1;
}
void __interrupt() Count_Up(void){
    if(TMR0IE && TMR0IF){
        TMR0=5;
        TMR0IF=0;
        i++;
        j++;
      //  if(adc_value>=205){
            if(i==5){
                digit++;
                if(digit==4)
                    digit=0;
                HienThi_7seg();
                i=0;
            }
            
      //  }
        //if(adc_value<205){
         //   if(i==5){
          //      HienThi_7seg();
           // }
           // i=0;
       // }
        if(nhiet_do >=100){
            if(j==500){
                Led=~Led;
            }
        }
        j=0;
        if(nhiet_do<100){
            Led=1;
        }
        
    }
    
}
int main() {
    Tris_Led=0;
    Tris_Led_7seg=0;
    tris_d1=1;
    tris_d2=0;
    tris_d3=0;
    timer0_inialize();
    InitADC();
    while(1){
        
    }
}
