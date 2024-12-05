/*
 * File:   main.c
 * Author: Nguy?nQuangMinh
 *
 * Created on April 7, 2023, 10:42 PM
 */



// PIC16F887 Configuration Bit Settings

// 'C' source line config statements

// CONFIG1
#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator: High-speed crystal/resonator on RA6/OSC2/CLKOUT and RA7/OSC1/CLKIN)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled and can be enabled by SWDTEN bit of the WDTCON register)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config MCLRE = OFF      // RE3/MCLR pin function select bit (RE3/MCLR pin function is digital input, MCLR internally tied to VDD)
#pragma config CP = OFF         // Code Protection bit (Program memory code protection is disabled)
#pragma config CPD = OFF        // Data Code Protection bit (Data memory code protection is disabled)
#pragma config BOREN = ON       // Brown Out Reset Selection bits (BOR enabled)
#pragma config IESO = OFF       // Internal External Switchover bit (Internal/External Switchover mode is disabled)
#pragma config FCMEN = OFF      // Fail-Safe Clock Monitor Enabled bit (Fail-Safe Clock Monitor is disabled)
#pragma config LVP = OFF        // Low Voltage Programming Enable bit (RB3 pin has digital I/O, HV on MCLR must be used for programming)

// CONFIG2
#pragma config BOR4V = BOR40V   // Brown-out Reset Selection bit (Brown-out Reset set to 4.0V)
#pragma config WRT = OFF        // Flash Program Memory Self Write Enable bits (Write protection off)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

#include <xc.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <htc.h>
#include "lcd.h"
#define _XTAL_FREQ 4000000

const char dat_line1[]= "PHUONG TUNG";
const char dat_line2[]= "Channel";
unsigned char i;

void main(void) {
    lcd_init();
    while(1)
    {
        lcd_put_byte(0,0x01);
        lcd_gotoxy(0,0);
        for(i=0;i<=10;i++)
        {
            lcd_putc(dat_line1[i]);
        }
        lcd_gotoxy(0,1);
        for(i=0;i<=7;i++)
       {
            lcd_putc(dat_line2[i]);
        }
        __delay_ms(3000);
        lcd_put_byte(0,0x01);
        lcd_gotoxy(0,0);
        lcd_puts("MINH");
        lcd_gotoxy(0,1);
        lcd_puts("201404024");
        __delay_ms(3000);
        lcd_put_byte(0,0x01);
        lcd_gotoxy(0,0);
        lcd_puts("NGUYEN QUANG MINH");
        lcd_gotoxy(0,1);
        lcd_puts("19/05/2002");
        __delay_ms(3000);
    }
        
}
