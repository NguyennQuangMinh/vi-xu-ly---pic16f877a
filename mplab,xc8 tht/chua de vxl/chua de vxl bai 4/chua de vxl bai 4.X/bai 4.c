/*
 * File:   bai 4.c
 * Author: Admin
 *
 * Created on December 7, 2022, 8:29 PM
 */

#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator)
#pragma config WDTE = OFF      // Watchdog Timer Enable bit (WDT enabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = ON      // Brown-out Reset Enable bit (BOR disabled)
#pragma config LVP = OFF        // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
#pragma config CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)
#include <xc.h>
#define _XTAL_FREQ 16000000
#define SBIT_PS2 2
#define Xung RA0
unsigned int count = 0,count1 = 0;
void timer0_init(){
OPTION_REG = (1<<SBIT_PS2);
TMR0=100; TMR0IE=1; GIE=1; PEIE=1;
}
char UART_Init(const long int tocdo)
{
unsigned int x;
x = (_XTAL_FREQ - tocdo*64)/(tocdo*64);
if(x>255)
{
x = (_XTAL_FREQ - tocdo*16)/(tocdo*16);
BRGH = 1;
}
if(x<256)
{
SPBRG = x;
SYNC = 0; //chon che do khong dong bo
SPEN = 1; // cho phep truyen thong
TRISC7 = 1; TRISC6 = 1;
CREN = 1; //cho phep nhan bit lien tuc
TXEN = 1; //cho phep truyen
PIR1bits.RCIF = 1; //Ngat tran nhan du lieu
PIR1bits.TXIF = 1; //Ngat tran truyen du lieuu
INTCONbits.PEIE = 1; //cho phep ngat ngoai vi
INTCONbits.GIE = 1; //cho phep ngat toan cuc.
return 1;
}
return 0;
}
void truyen_kt(char kt)
{
while(!TRMT);
TXREG = kt;
}
//viet mot chuoi
void truyen_chuoi(char *txt)
{
int i;
for(i=0;txt[i]!='\0';i++)
truyen_kt(txt[i]);
}
//Tao ngat voi do tre la 1ms
void __interrupt() timer0(){
if(TMR0IF == 1)
{
TMR0 = 101; TMR0IF = 0;
count++;
count1++;
if(count <= 1)
{ Xung = 0;}
else if(count >1 && count < 4)
{Xung = 1;}
if(count == 4)
{count = 0;}
if(count1 == 2000){
//Gui chuoi voi chu ki 2s = 1ms * 2000 = 2000ms
truyen_chuoi("Reading");
count1 = 0;
}}}
void main(void) {
TRISD = 0x00; TRISB = 0x00; TRISA=0x00;
TRISCbits.TRISC6 = 0;//output(TX)
TRISCbits.TRISC7 = 1;//input(RX)
PORTD = 0x00; PORTB = 0x00;
timer0_init(); UART_Init(19200);
while(1){
}}
