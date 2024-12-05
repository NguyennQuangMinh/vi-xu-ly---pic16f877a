/*
 * File:   newmain.c
 * Author: Admin
 *
 * Created on December 1, 2022, 2:58 PM
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
unsigned char ma[10] = {0x40,0x79,0x24,0x30,0x19,0x12,0x02,0x78,0x00,0x10};


void ser_int(){ // khoi tao uart
    TXSTA = 0x20;
    RCSTA = 0b10010000;
    SPBRG = 25;
    TXIF = RCIF = 0;
}

void tx(unsigned char a ){
    TXREG = a;
    while(!TXIF);
    TXIF = 0;
}
unsigned char rx(){
    while(!RCIF);
    RCIF = 0;
    return RCIF;
}
void txstr(unsigned char *s){
    while(*s){
    tx(*s++);
}
}
int count = 0;
void setup_timer2(){
    GIE = 1; // b?t cho phép ng?t
    PEIE =1; // c?n b?ng 1 thì m?i ng?t timer 2 dc
    TMR2IE = 1; // cho phép ng?t timer 2 
    TMR2ON = 1; // b?t timer 2;
    T2CKPS0 = 0;
    T2CKPS1 = 0; //=> prescale = 1  ;
    TOUTPS0 = 0;
    TOUTPS1 = 0;
    TOUTPS2 = 0;
    TOUTPS3 = 0; //=> postscale = 1;
    // 1 là: prescale = 16, postscale = 16 => l?n nh?t => th??ng là thòi gian kho?ng ms ??n s
    // 2 là: prescale = 1, postscale = 1 => nh? nh?t => th??ng là yêu c?u kho?ng th?i gian us
    TMR2 = 55;
    PR2 = 255;
 //   T = 4* prescale * (PR2-TMR2) * postscale *1/f = 4*1*200*1*1/16000000 = 5*10^-5ms = 50us
}

void __interrupt () timer2(){
//{ ngat_timer2() {
// hi?u là v?i cái setup_timer(2) c? ??n 12.8ms thì s? ch?y l?nh trong hàm này 
    
    if(TMR2IE && TMR2IF){
        TMR2IF = 0;
        count ++;
    if(count == 60){ // 3ms = 3000/50
        RA0=1; // sang con led
        __delay_ms(1);
        RA0=0;
        count =0;
    }
    }
}
char r1;
void main(void) {   
    ser_int(); // khoi tao uart     
    setup_timer2();
    ADCON1 = 0x07; // chuyen cong A tu tuong tu sang cong so 
    TRISA = 0;
    TRISB = 0;        
    TRISC = 0x80; // su dung trong truong hop giao tiep uart 
    RA0 = 0;
    //txstr("xin moi nhap chu");
    while(1){
        //r1=rx(); // nhan ki tu va luu vao bien r1
        //tx(r1); // gui vao du lieu luu o bien r1
        // yeu cau gui chuoi reading moi 2s
         txstr("Reading");
         __delay_ms(200);
    }
    
}

