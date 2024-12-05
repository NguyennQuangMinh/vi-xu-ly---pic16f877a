/*
 * File:   btvn 3.c
 * Author: Nguy?nQuangMinh
 *
 * Created on March 7, 2023, 10:01 AM
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
#define Led_7Seg PORTB 
#define Tris_Led_7seg TRISB

#define d1 PORTCbits.RC1
#define d2 PORTCbits.RC2
#define d3 PORTCbits.RC3

#define tris_d1 TRISCbits.TRISC1
#define tris_d2 TRISCbits.TRISC2
#define tris_d3 TRISCbits.TRISC3

unsigned char Ma[10]={0X40,0X79,0X24,0X30,0X19,0X12,0X02,0X78,0X00,0X10};
unsigned char tram,chuc,dv; 
unsigned char digit;
unsigned char adc_value;
unsigned char temperature;
unsigned char voltage;

void hienthi(char x)
{
    tram=x/100;
    chuc=(x%100)/10;
    dv=((x%100)%10);
        switch (digit){
        case 0: 
            d3=0;d2=1;d1=1;
            Led_7Seg=Ma[tram];
        break;
        case 1: 
            d3=1;d2=0;d1=1;
            Led_7Seg=Ma[chuc];
        break;
        case 2: 
            d3=1;d2=1;d1=0;
            Led_7Seg=Ma[dv];
    }
    
    
}
void ADC_Initialize()

{

  ADCON0 = 0b01000001; //ADC ON and Fosc/16 is selected

  ADCON1 = 0b11000000; // Internal reference voltage is selected

}


unsigned int ADC_Read(unsigned char channel)

{

  ADCON0 &= 0x11000101; //Clearing the Channel Selection Bits

  ADCON0 |= channel<<3; //Setting the required Bits

  __delay_ms(2); //Acquisition time to charge hold capacitor

  GO_nDONE = 1; //Initializes A/D Conversion

  while(GO_nDONE); //Wait for A/D Conversion to complete

  return ((ADRESH<<8)+ADRESL); //Returns Result

}

void main(void) {
    ADCON1 = 0x06;
    float adc;
    float volt, temp;
    int temp1;
    ADC_Initialize();
    TRISC=0x00;
    TRISB=0x00;
    while (1)
    {
        adc = (ADC_Read(4)); // Reading ADC values

        volt = adc*4.88281; // Convert it into the voltage 

        temp=volt/10.0;  // Getting the temperature values 

        temp1 = temp*100;
        hienthi(temp1);
        
    }
}
