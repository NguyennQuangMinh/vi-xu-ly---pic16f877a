

#include <xc.h>

#pragma config FOSC = XT // Oscillator Selection bits (XT oscillator)
#pragma config WDTE = OFF // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = ON // Power-up Timer Enable bit (PWRT enabled)
#pragma config BOREN = ON // Brown-out Reset Enable bit (BOR enabled)
#pragma config LVP = ON // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3/PGM pin has PGM function; low-voltage programming enabled)
#pragma config CPD = OFF // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF // Flash Program Memory Code Protection bit (Code protection off)#include <xc.h>
#define _XTAL_FREQ 16000000
#define Led PORTD
#define Tris_Led TRISD
#define A1 PORTBbits.RB0
#define A2 PORTBbits.RB1
#define A3 PORTBbits.RB2
#define A4 PORTBbits.RB3
#define Tris_A1 TRISBbits.TRISB0
#define Tris_A2 TRISBbits.TRISB1
#define Tris_A3 TRISBbits.TRISB2
#define Tris_A4 TRISBbits.TRISB3

#define KB0 PORTBbits.RB6
#define KB1 PORTBbits.RB7
#define Tris_KB0 TRISBbits.TRISB6
#define Tris_KB1 TRISBbits.TRISB7
#define Input 1
#define out 0
unsigned int num,j,counter;
char n,t,c,dv;
unsigned int count_t0;
unsigned char ma[]={0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x90};

void timer0_initialize() //ten chuong trinh ngat
{
T0CS=0; //Chon CLK0=FOSC/4 =4Mhz T=0.25us
PSA=0; //Co su dung he so chia
PS0=1;
PS1=1;
PS2=0; //He so chia 011=1:16 0.25us*16=4us
TMR0=5; //250 xung tràn tuong ung 1ms
TMR0IE=1; //Cho phep ngat Timer0
GIE=1; //Cho phep ngat toan bo (ngat toan cuc)
}

void __interrupt() Count_Up(void)
{
if (TMR0IE && TMR0IF) //m?c ??nh (?? ki?m tra xem timer 0 ?ã ng?t ch?a)
{
TMR0=5;
TMR0IF=0;
counter++;
if(counter==4)
{
counter=0;
count_t0++;
  if(count_t0==4)
    count_t0=0;
}

if(count_t0==0)
{
Led=0xff; //Tat Led 7 thanh
A1=0; A2=1; A3=1; A4=1; //Bat so hang nghin, Tat so tram, chuc, don vi
Led=ma[n];
}
if(count_t0==1)
{
Led=0xff; //Tat Led 7 thanh
A1=1; A2=0; A3=1; A4=1; //Bat so hang tram, Tat so nghin, chuc, don vi
Led=ma[t]; //Hien thi so 2
}
if(count_t0==2)
{
Led=0xff; //Tat Led 7 thanh
A1=1; A2=1; A3=0; A4=1; //Bat so hang chuc, Tat so nghin, tram, don vi
Led=ma[c]; //Hien thi so 2
}
if(count_t0==3)
{
Led=0xff; //Tat Led 7 thanh
A1=1; A2=1; A3=1; A4=0; //Bat so hang don vi, Tat so nghìn, tram, chuc
Led=ma[dv]; //Hien thi so 4
}


}
}int main()
{
   ADCON1 = 0x06; 
Tris_A1=out;
Tris_A2=out;
Tris_A3=out;
Tris_A4=out;
Tris_Led=out;
timer0_initialize();
while(1)
{
// Dieu khien phim bam KB1
if(KB0==0)
{
num=1234;
j=num%1000;
n=num/1000;
t=j/100;
j=j%100;
c=j/10;
dv=j%10;
} // Dieu khien phim bam KB1
if(KB1==0)
{
num=5678;
j=num%1000;
n=num/1000;
t=j/100;
j=j%100;
c=j/10;
dv=j%10;
}
}
}

