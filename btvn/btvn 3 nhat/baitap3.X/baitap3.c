#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = ON       // Brown-out Reset Enable bit (BOR enabled)
#pragma config LVP = ON         // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3/PGM pin has PGM function; low-voltage programming enabled)
#pragma config CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF  

#include<xc.h>
#define _XTAL_FREQ 20000000
#define Tris_led7seg TRISB
#define led7seg PORTB

#define Tris_a1 TRISDbits.TRISD0
#define a1 PORTDbits.RD0
#define Tris_a2 TRISDbits.TRISD1
#define a2 PORTDbits.RD1

#define Tris_a3 TRISDbits.TRISD2
#define a3 PORTDbits.RD2
#define Tris_led TRISDbits.TRISD7
#define led PORTDbits.RD7

#define Input 1
#define Out 0

char ma[]={0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90}; 
unsigned int i;
unsigned int donvi,truc,tram,digit;
unsigned int num,j;
unsigned int ADCvalue = 0;
unsigned int count_50ms;

void ADC_Init()
{
TRISA = 0xff;
ADCON1 = 0b11110000; 
ADCON0 = 0b00000001;
ADRESH = 0;
ADRESL = 0;
}
unsigned int ADC_Read(int channel)
{

 ADCON0 |= channel<< 1;
  __delay_ms(2);
  GO_nDONE = 1;
  while(GO_nDONE);
  return ((ADRESH<< 8)+ADRESL);
  if(ADCvalue);
}

void hienthi(void)
{
    led7seg=0xff;
    switch(digit)
    {
        case 0:
            a1=0;a2=1;a3=1;
            led7seg=ma[tram];
            break;
        case 1:
            a1=1; a2=0; a3=1;
            led7seg=ma[truc];
            break;
        case 2:
            a1=1; a2=1; a3=0;
            led7seg=ma[donvi];
    }
}

void timer0_initialize ()  
{
    T0CS=0;
    PSA=0;
    PS0=0;
    PS1=1;
    PS2=0;
    TMR0=5;    
    TMR0IE=1; 
    GIE=1;
}
void __interrupt() Count_Up(void)
{
    if(TMR0IE && TMR0IF)
    {
        TMR0=5;
        TMR0IF=0;
        hienthi();
        tram=num/100;
        j=num%100;
        truc=j/10;
        donvi=j%10;
        digit++;
        if(digit==3)
            digit=0;
        if(count_50ms++==12)
        {
            count_50ms=0;
            ADCvalue=ADC_Read(0);
        }       
    }
}

int main()
{
    ADCON1=0x06;
    Tris_led7seg=0;
    Tris_led=0;
    Tris_a1=0;
    Tris_a2=0;
    Tris_a3=0;
    led7seg=0;
    TRISB=0x00;
    timer0_initialize ();
    ADC_Init();
    while(1)
    {
        
    }
    
}
