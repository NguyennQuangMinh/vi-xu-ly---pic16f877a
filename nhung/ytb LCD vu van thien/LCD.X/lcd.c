/*
 * File:   lcd.c
 * Author: Nguy?nQuangMinh
 *
 * Created on May 1, 2023, 8:43 PM
 */
// PIC16F877A Configuration Bit Settings

// 'C' source line config statements

// CONFIG
#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = OFF      // Brown-out Reset Enable bit (BOR disabled)
#pragma config LVP = OFF        // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
#pragma config CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)

#define _XTAL_FREQ 20000000
#include <xc.h>
#include "lcd.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
void main(void) {
    unsigned char chuoi[20];
    TRISB=0;
    TRISD=0;
    khoi_taoLCD();
    lenh(0xC0);
    sprintf(chuoi,'abcd efgh');
    chuoi_kytu(chuoi);
    while(1);
}
