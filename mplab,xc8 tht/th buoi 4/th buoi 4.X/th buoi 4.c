/*
 * File:   th buoi 4.c
 * Author: Admin
 *
 * Created on November 28, 2022, 9:51 PM
 */


// CONFIG
#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator)
#pragma config WDTE = OFF        // Watchdog Timer Enable bit (WDT enabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = ON      // Brown-out Reset Enable bit (BOR disabled)
#pragma config LVP = OFF        // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
#pragma config CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

#include <xc.h>
#define _XTAL_FREQ 16000000//16Mhz

unsigned char Ma[10]={0X40,0X79,0X24,0X30,0X19,0X12,0X02,0X78,0X00,0X10};
void scanled(int x)
{
    int t,c,dv;
    t=x/100;
    c=x%100/10;
    dv=x%100%10;
    
    for(int i=0;i<25;i++)
    {
        PORTB=Ma[t];
        RC0=0;
        __delay_ms(1);
        RC0=1;
        
        PORTB=Ma[c];
        RC3=0;
        __delay_ms(1);
        RC3=1;
        
        PORTB=Ma[dv];
        RC6=0;
        __delay_ms(2);
        RC6=1;     
        //==> tong thoi gian = (1+1+2)*25=100ms ~ 0,1s
    }
}

void scanled1(int x)
{
    int t,c,dv;
    t=x/100;
    c=x%100/10;
    dv=x%100%10;
    
    for(int i=0;i<500;i++)
    {
        PORTB=Ma[t];
        RC0=0;
        __delay_ms(1);
        RC0=1;
        
        PORTB=Ma[c];
        RC3=0;
        __delay_ms(1);
        RC3=1;
        
        PORTB=Ma[dv];
        RC6=0;
        __delay_ms(2);
        RC6=1;
        
        //==> tong thoi gian = (1+1+2)*500=2000ms ~ 2s
    }

}
// phim bam : khi bam phim thi LED 7 thanh giam dan,khi khong bam phim thi  LED 7 thanh tang dan tu 000 ??n 999

int h=0;

/*timer2 : bo dem thoi gian tran dien thoai : lap trinh mode;prescale;postscal;tmr2
        
dem theo cac cai dat truoc nhu mode ,prescale,postscale => khi dem xong thi no se chay lenh

giong nhu phan mem tren dien thoai khi dem thi no se khong lam gi ca */

int count=0;
void setup_timer2()  // dua ra cac yeu cau prescale;postscale
{
    GIE = 1; // bat cho phep ngat
    
    PEIE=1; // can bang 1 thi moi  ngat timer2 duoc
    
    TMR2IE = 1; // cho phep ngat timer2

    TMR2ON=1; // BAT TIMER2
    
    T2CKPS0=0;
    T2CKPS1=0; // => prescale =1Mhz
    
    // postscale = 1,2,3,...,16
    TOUTPS0=0;
    TOUTPS1=0;
    TOUTPS2=0;
    TOUTPS3=0;
    /// postscale = 0000 = 0  (+1) = 1Mhz;( postscale thì se la he 2 cong 1)

    PR2=255;
    TMR2=55;
    
    /* tinh thoi gian ngat : Tngat=4*prescale*( PR2-TMR2)*postscale*1/f
                                  =4*1*200*1*(1/16 000 000) = 0,05 ms      */
}

// yeu cau cu 0,5 ms la led o chan RB7 nhap nhay 1 lan => tinh lan chay lenh => 0,5 ms => 0,5/0,05=10 lan
void __interrupt() ngat_timer2()
{
    // hieu la voi setup_timer2 cu 0,5ms la chay lenh trong ham nay
    if(TMR2IE && TMR2IF )
    {
        TMR2IF=0;
        count++;
        if(count==10)
        {
            RB7=1;// sang con led o chan RB7
            __delay_ms(10);
            RB7=0;
            count=0;
        }
    }
}

void main(void) {
    setup_timer2();
    TRISC=0;
    TRISB=0;
    TRISD=1;
    while(1)
    {
        for(int j=0;j<999;j++)
        {
            scanled(j);
        }
        for(int k=999;k>=0;k-- )
        {
            scanled1(k);
            //k=999;
        }    
    }           
}
