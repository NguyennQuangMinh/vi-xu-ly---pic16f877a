/*
 * File:   bai 3.c
 * Author: Nguy?nQuangMinh
 *
 * Created on April 21, 2023, 10:07 PM
 */


// PIC16F877A Configuration Bit Settings

// 'C' source line config statements

// CONFIG
#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = ON       // Brown-out Reset Enable bit (BOR enabled)
#pragma config LVP = OFF        // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
#pragma config CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

#include <xc.h>
#include <pic16f877a.h>

#define _XTAL_FREQ 20000000

#include <stdio.h>
#include <stdlib.h>
#include <pic16f877a.h>
#include "lcd.h"
#include <string.h>

#define RS RD2
#define EN RD3
#define D4 RD4
#define D5 RD5
#define D6 RD6
#define D7 RD7

void ADC_init(void);
unsigned int ReadADC(void);
unsigned int ADC_value =0;
float f ;
unsigned int voltage;

// khoi tao ADC
void ADC_init(void)
{
    // CHON TAN SO CLOCK CHO BO ADC
    ADCON1bits.ADCS2 = 0;
    ADCON0bits.ADCS1 = 0;
    ADCON0bits.ADCS0 = 1;
    
    // chon kenh adc la kenh AN0
    ADCON0bits.CHS2 =0;
    ADCON0bits.CHS1 =0;
    ADCON0bits.CHS0 =0;
    
    // chon cach luu data
    ADCON1bits.ADFM=1;
    
    //CAU HINH CONG VAO
    ADCON1bits.PCFG3 =1;
    ADCON1bits.PCFG2 =1;
    ADCON1bits.PCFG1 =1;
    ADCON1bits.PCFG0 =0;
    
    // cap nguon cho khoi ADC
    ADCON0bits.ADON=1;
}
// doc ADC
unsigned int ReadADC(void)
{
    unsigned int TempValue =0 ;
    ADCON0bits.GO_nDONE =1;
    while(ADCON0bits.GO_nDONE);
    TempValue = ADRESH*256 + ADRESL;
    return(TempValue);
}

void main(void) {

    Lcd_Init();
    ADC_init();
    char s[20];
    TRISD = 0x00;
    RA0=1;
    TRISA0=1;
    TRISD=0;
    TRISB=0;

    
    
    while(1)
    {
        ADC_value=ReadADC();
        voltage = 5000.0f/1023*ADC_value;
        f=voltage/10;
        sprintf(s,"NHIET DO = %g",f);
        Lcd_Set_Cursor(1,1);
        Lcd_Write_String(s);
        Lcd_Write_Char(223);
        Lcd_Write_String("C");
        
        if(f>=25 && f<=30)
        {
            PORTBbits.RB0=1;           
        }
        else
            PORTBbits.RB0=0; 
    }
}
