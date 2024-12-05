
#include <xc.h>
#pragma config FOSC = XT        // Oscillator Selection bits (XT oscillator)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = ON       // Power-up Timer Enable bit (PWRT enabled)
#pragma config BOREN = ON       // Brown-out Reset Enable bit (BOR enabled)
#pragma config LVP = ON         // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3/PGM pin has PGM function; low-voltage programming enabled)
#pragma config CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)

#define _XTAL_FREQ   16000000

 #define Led1  PORTCbits.RC1
 #define Led2  PORTCbits.RC3

#define Tris_Led1  TRISCbits.TRISC1
#define Tris_Led2  TRISCbits.TRISC3

// #define Led2  PORTBbits.RB1
// #define Led3  PORTBbits.RB2
// #define Led4  PORTBbits.RB3

 unsigned int count_t0;  //count_t0 0-65535    1000 char 
 unsigned int count_t1;
 
 void timer0_initialize ()  
{
     
    T0CS=0; // Chon CLK0=FOSC/4 =4Mhz T=0.25us
    PSA=0; //  Co su dung he so chia
    PS0=1;
    PS1=1;
    PS2=0;  //He so chia  011=1:16 0.25us*16=4us
    TMR0=6;      //250 xung tràn tuong ung 1ms 
    
    TMR0IE=1; //Cho phep ngat Timer0
    GIE=1;    // Cho phep toan cuc
}
 
 void __interrupt()  Count_Up(void) //1ms
{
  if (TMR0IE && TMR0IF) 
  {
      TMR0=6; 
      TMR0IF=0;
      count_t0++;       
      count_t1++;
  }
}

int main ()
{
 Tris_Led1=0;
 Tris_Led2=0;
 timer0_initialize ()  ;
 count_t0=0;
 count_t1=0;
 
while(1)
   {     
 
unsigned int num,j,counter;
char n,t,c,dv;
unsigned int count_t0;
unsigned char ma[]={0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x90};
void timer0_initialize() //ten chuong trinh ngat{
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
if(count_t0==4)
{
count_t0=0;
}
}
}int main()
{
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


      /*if(count_t0==500)  //500ms
	  {
          Led1=~Led1;
          count_t0=0;
      }
     if(count_t1<300)
          Led2=0;
      if(count_t1<900&&count_t1>=300)
          Led2=1;
      if(count_t1<1000&&count_t1>=900)
          Led2=0;
      if(count_t1<1300)
          Led2=1;
      if(count_t1>=1300)
          count_t1=0;
        */
   /* Led2=0;
    __delay_ms(300);
    Led2=1;
    __delay_ms(600);
    Led2=0;
    __delay_ms(100);
    Led2=1;
    __delay_ms(300);*/
    
   }
}

