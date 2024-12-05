// CONFIG
#pragma config FOSC = XT        // Oscillator Selection bits (XT oscillator)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = ON       // Power-up Timer Enable bit (PWRT enabled)
#pragma config BOREN = ON       // Brown-out Reset Enable bit (BOR enabled)
#pragma config LVP = ON         // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3/PGM pin has PGM function; low-voltage programming enabled)
#pragma config CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.
#define _XTAL_FREQ    16000000

#include <xc.h>
#define Input  1
#define Out    0
#define kb0 PORTAbits.RA4
#define kb1 PORTAbits.RA5
#define kb2 PORTEbits.RE0
#define kb3 PORTEbits.RE1

#define Tris_kb0 TRISAbits.TRISA4
#define Tris_kb1 TRISAbits.TRISA5
#define Tris_kb2 TRISEbits.TRISE0
#define Tris_kb3 TRISEbits.TRISE1

#define Led PORTEbits.RE2
#define Tris_Led TRISEbits.TRISE2

#define Led2 PORTEbits.RE3
#define Tris_Led2 TRISEbits.TRISE3
#define Led3 PORTEbits.RE4
#define Tris_Led TRISEbits.TRISE4

#define Led_7SEG       PORTD
#define Tris_Led_7SEG TRISD

#define d1 PORTAbits.RA0
#define d2 PORTAbits.RA1
#define d3 PORTAbits.RA2
#define d4 PORTAbits.RA3

#define Tris_d1 TRISAbits.TRISA0
#define Tris_d2 TRISAbits.TRISA1
#define Tris_d3 TRISAbits.TRISA2
#define Tris_d4 TRISAbits.TRISA3

unsigned char bLed;
unsigned int i;
char number[]={0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90};  


unsigned int num,j;
 unsigned char donvi,truc,tram,ngin,digit; 
 unsigned int count, count_s;
 unsigned char pre_kb0,pre_kb1,pre_kb2; 
 unsigned int count_t0,count_t1;
 
  
void hienthi(void)
{
   	 Led_7SEG=0xff;
    switch (digit)
    {
       case 0:         
  		    d4=1;d1=0;d2=1;d3=1;
 	        Led_7SEG=number[ngin];
          break;
        case 1:
    	 
         d1=1;d2=0;d3=1;d4=1;
         Led_7SEG=number[tram];  
          break;
        case 2:
    	 
         d1=1;d2=1;d3=0;d4=1;
         Led_7SEG=number[truc];  
          break;
          case 3:

         d1=1;d2=1;d3=1;d4=0;
         Led_7SEG=number[donvi];  
    }      
}
void timer2_initialize ()  
{
    T2CKPS0=1;
    T2CKPS1=0;
    PR2=100;  //0.1ms
    TOUTPS0=1;
    TOUTPS1=1;
    TOUTPS2=1;
    TOUTPS2=1; //0.1/16
    TMR2ON=1;
    TMR2IE=1; 
    PEIE=1;
    GIE=1;
}

void timer0_initialize ()  
{
    T0CS=2; // Chon CLK0=FOSC/4 =4Mhz T=0.25us
    PSA=0; //  Co su dung he so chia
    PS0=1;
    PS1=1;
    PS2=0;  //He so chi 011=1:16 0.25us*16=4us
    TMR0=5;      //250 xung tran    
    TMR0IE=1; 
    GIE=1;
}

 void __interrupt()  Count_Up(void) //1ms  50us
{
  if (TMR0IE && TMR0IF) 
  {
      TMR0=5; 
      TMR0IF=0;
      count_t0++;
      
      if(count_t0==500)  //500ms
	 {
      count_t0=0;   
      Led=~Led;
      }
      
  }
  /*
  if (TMR2IE && TMR2IF) 
{
  TMR2IF=0;
    count++;
    
	 if(count==5)  //5ms
	 {
      count=0;
      if(kb0)
      {  
      count_t1++;
        if(count_t1==100)  //500ms
         {
        count_t1=0;
        num++;
       }
      } 
      
      hienthi();
      digit++;    
      if(digit==4)
        digit=0;      
      count_s++;
      if(count_s==25)
      {  
          count_s=0;         
      ngin=num/1000;	  
       j=num%1000;
        tram=j/100;
	   j=j%100;	
       truc=j/10;
       donvi=j%10;
      }      
      
	  bLed=!bLed;	 
      if(bLed)
          Led=1;
      else
          Led=0;
     }
}
}
*/
 /*
 void hienthi()
 {
     num=1234;
        ngin=num/1000;
        j=num%1000;
        tram=j/100;
        j=j%100;
        truc=j/10;
        donvi=j%10;
        
        Led_7SEG=0xff;
        d1=0;d2=1;d3=1;d4=1;
        Led_7SEG=number[ngin];
        __delay_ms(5);
        Led_7SEG=0xff;
        
        d1=1;d2=0;d3=1;d4=1;
        Led_7SEG=number[tram];
        __delay_ms(5);
        
        Led_7SEG=0xff;
        d1=1;d2=1;d3=0;d4=1;
        Led_7SEG=number[truc];
        __delay_ms(5);
        Led_7SEG=0xff;
        d1=1;d2=1;d3=1;d4=0;
        Led_7SEG=number[donvi];
        __delay_ms(5);     
 }
 */
int  main ()
{
     ADCON1 = 0x06;// All Analog Input Disable
     
    /*Tris_kb0=Input ;  
    Tris_kb1=Input;
    Tris_kb2=Input;
    Tris_kb3=Input;
    
    Tris_Led=Out;*/
     
    Tris_d1=Out;
    Tris_d2=Out;
    Tris_d3=Out;
    Tris_d4=Out;
    Tris_Led_7SEG=0;
    //TRISB=0;
    //timer0_initialize (); 
    //timer2_initialize ();
    
	while(1)
	{   
      //  Led3=Led|Led2;
        
     //  hienthi();  // 20ms
        
        	if(kb0)       // Phim bam
               pre_kb0=1;
        
         if(pre_kb0&&!kb0)// Pre_Kb0==1 va phim nha kb0==0
		{
         pre_kb0=0;
         num++;
		  //num=0;
        }
            
/*
        if(kb1)
         pre_kb1=1;
         if(pre_kb1&&!kb1)
		{
		// delay=0;
         pre_kb1=0;
         num++;          
		 if(num==10000)
		  num=0;
        }
		 if(kb2)
         pre_kb2=1;
         if(pre_kb2&&!kb2)
		{
		// delay=0;
         pre_kb2=0;
		 if(num>0)
         num--;          
        }*/ 
     }
   }

