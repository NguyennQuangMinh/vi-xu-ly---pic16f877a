/*
 * File:   th bai 1.c
 * Author: Admin
 *
 * Created on November 22, 2022, 3:54 PM
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

/*M?i m?t c?ng A,B,C,D ,E ??u c� m?t thanh ghi TRIS ?? ?i?u khi?n c?ng n�y v?i 2 ch?c n?ng :
    1.Nh?n d? li?u v�o ( v� d? nh? : ngu?n c?p ?i?n v�o(m?c logic 1) )
    2.??a d? li?u ra*/ 

void main(void) {
 /*   TRISB = 00000000 => M� Hexa = 
  (8bits)  TRISB= RB7  RB6  RB5  RB4  RB3  RB2  RB1  RB0  l� thanh ghi ?i?u khi?n c?ng B l?y d? li?u v�o ho?c xu?t d? li?u ra
                  1/0  1/0  1/0  1/0  1/0  1/0  1/0  1/0
                   0    0    0    0    0    0    0    0
            1 : l?y d? li?u v�o
            0: l?y d? li?u ra*/
    PORTC=0;// t? ch�n RC7 ??n ch�n RC0 ??u b?ng 0
    PORTD=0;// t? ch�n RD7 ??n  ch�n RD0 ?i?n �p b?ng 0
    TRISC=0;// l?p tr�nh c?ng C ??a ?i?n �p ra
    TRISD=0;// l?p tr�nh c?ng D ??a ?i?n �p ra
   
    //TRISB=1; // l?p tr�nh c?ng B ??a ?i?n �p v�o
    while(1) // 1: true l� s? dung; 0 : false l� kh�ng s? d?ng
    {
        PORTC=0X82;  // B?t LED D1 v� D3
        PORTD=0X42  ;//S�ng LED D2 v� D4
        __delay_ms(1000);
        //RC7  RC6  RC5  RC4  RC3  RC2  RC1  RC0; //?i?u khi?n c?ng C ??a ?i?n �p ra l� 5V (M?c logic 1) hay l� 0V ( M?c logic 0)
                   //  1/0  1/0  1/0  1/0  1/0  1/0  1/0  1/0
                   //   1    0    0    0    0    0    1    0  => M� Hexa=0X82;
        
        PORTC=0X00  ;//t?t LED D1 v� D3
        PORTD=0X00;//T?t LED D2 v� D4
        __delay_ms(500);
        //RD7  RD6  RD5  RD4  RD3  RD2  RD1  RD0; //?i?u khi?n c?ng D ??a ?i?n �p ra l� 5V (M?c logic 1) hay l� 0V ( M?c logic 0)
                   //  1/0  1/0  1/0  1/0  1/0  1/0  1/0  1/0
                   //   0    1    0    0    0    0    1    0  => M� Hexa=0X42;
      
    }
}
