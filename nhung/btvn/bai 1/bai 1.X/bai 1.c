/*
 * File:   bai 1.c
 * Author: Nguy?nQuangMinh
 *
 * Created on April 19, 2023, 2:55 PM
 */

// CONFIG
#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = ON       // Brown-out Reset Enable bit (BOR enabled)
#pragma config LVP = ON        // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
#pragma config CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

#include <xc.h>
#include <string.h>

#define _XTAL_FREQ 16000000

#define Led PORTEbits.RE2
#define Tris_Led TRISEbits.TRISE2

char in_buffer[6];
unsigned char in_count;

void Init_uart(void)
{
    TXSTA=0x20; // TXEN=1
    RCSTA=0x90;// SPEN=1 CREN=1
    SPBRG=25; // 9600b/s 16MHZ
    RCIE=1;
}

void __interrupt() Receive_UART(void) //1ms
{
    char ch;
    if (RCIE && RCIF)
    {
        ch=RCREG;
        in_buffer[in_count++]=ch;
        if(in_count==5)
        {
            in_count=0;
            if(strncmp(in_buffer,"start",5)==0)
            {
                Led=1;
                __delay_ms(200);
                Led=0;
                __delay_ms(500);
            }
            if(strncmp(in_buffer,"stop",4)==0)
            Led=0;
        }
    }
}
int main ()
{
    ADCON1 = 0x06;// All Analog Input Disable
    Tris_Led=0;
    Init_uart();
    while(1)
    {
    }
}
